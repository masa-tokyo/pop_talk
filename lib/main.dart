import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info/package_info.dart';
import 'package:pop_talk/infrastructure/tracking.dart';
import 'package:pop_talk/presentation/notifier/auth.dart';
import 'package:pop_talk/presentation/ui/pages/service/privacy.dart';
import 'package:pop_talk/presentation/ui/pages/service/term_of_use.dart';
import 'package:pop_talk/presentation/ui/pages/top.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_strategy/url_strategy.dart';

import 'infrastructure/service_provider.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'PopTalk',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.mPlus1p().fontFamily,
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32,
            ),
            headline2: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
            headline3: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            headline4: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
            headline5: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 12,
            ),
            bodyText1: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ).apply(
            displayColor: Colors.black,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xFFFF934E),
              onSurface: const Color(0xFFC4C4C4),
              textStyle: TextStyle(
                fontSize: 16,
                fontFamily: GoogleFonts.mPlus1p().fontFamily,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFFF934E),
              textStyle: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: GoogleFonts.mPlus1p().fontFamily,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 6,
              ),
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
          primaryColor: const Color(0xFFFF934E),
          scaffoldBackgroundColor: const Color(0xFFF1EFE5),
          canvasColor: const Color(0xfff2f2f2),
          hoverColor: Colors.transparent,
          disabledColor: Colors.blue[300],
        ),
        routes: {
          TopPage.routeName: (_) => SetUp(child: TopPage()),
          ServicePrivacyPage.routeName: (_) => ServicePrivacyPage(),
          ServiceTermOfUsePage.routeName: (_) => ServiceTermOfUsePage(),
        },
        initialRoute: TopPage.routeName,
        navigatorObservers: [
          Tracking().getPageViewObserver(),
        ],
      ),
    );
  }
}

class SetUp extends StatefulWidget {
  const SetUp({
    required this.child,
  });

  final Widget child;

  @override
  _SetUpState createState() => _SetUpState();
}

class _SetUpState extends State<SetUp> {
  bool isLoading = true;
  bool shouldUpdate = false;

  @override
  void initState() {
    setUp(context).then((value) => setState(() => isLoading = false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || shouldUpdate) {
      return SplashScreen();
    }
    return widget.child;
  }

  Future<void> setUp(BuildContext context) async {
    // Splashスクリーンを見せるために最小1.5秒待つ
    final showSplash = Future<void>.delayed(
      const Duration(seconds: 1, milliseconds: 500),
    );
    await Future.wait([
      Firebase.initializeApp(),
      registerDIContainer(),
    ]);

    await Future.wait([
      checkBuildNumber(context),
      context.read(authProvider).implicitLogin(),
      showSplash,
    ]);
  }

  Future<void> checkBuildNumber(BuildContext context) async {
    if (kIsWeb) {
      return;
    }
    final remoteConfig = RemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 3),
      minimumFetchInterval: const Duration(seconds: 1),
    ));
    await remoteConfig.fetchAndActivate();
    final requireBuildNumber = remoteConfig.getInt('requireBuildNumber');

    final info = await PackageInfo.fromPlatform();
    final currentBuildNumber = int.parse(info.buildNumber);

    if (requireBuildNumber > currentBuildNumber) {
      setState(() {
        shouldUpdate = true;
      });
      await _showUpdateDialog(context: context);
    }
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/poptalk_logo.svg',
              fit: BoxFit.cover,
              height: 90,
              width: 90,
            ),
            Text(
              'PopTalk',
              style: GoogleFonts.mPlusRounded1c(
                letterSpacing: 0.5,
                textStyle: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF804B3A),
                ),
              ),
            ),
            Text(
              'ポップなテーマでトークが弾ける',
              style: GoogleFonts.mPlusRounded1c(
                letterSpacing: 0.5,
                textStyle: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF804B3A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showUpdateDialog({
  required BuildContext context,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text(
        'PopTalkの新しいバージョンが公開されました。アプリをアップデートして下さい。',
      ),
      actions: [
        Align(
          alignment: Alignment.center,
          child: TextButton(
            style: TextButton.styleFrom(
              primary: Colors.blue,
              backgroundColor: Colors.white,
            ),
            onPressed: () async {
              if (Platform.isIOS) {
                await launch('https://apps.apple.com/app/id1586833764');
              } else {
                await launch('https://play.google.com/store/apps/details?id=com.yamyanu.poptalk');
              }
            },
            child: const Text('アップデート'),
          ),
        ),
      ],
    ),
  );
}
