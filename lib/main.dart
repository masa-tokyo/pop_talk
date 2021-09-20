import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pop_talk/presentation/notifier/auth.dart';
import 'package:pop_talk/presentation/ui/pages/service/privacy.dart';
import 'package:pop_talk/presentation/ui/pages/service/term_of_use.dart';
import 'package:pop_talk/presentation/ui/pages/top.dart';

import 'infrastructure/service_provider.dart';

void main() {
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
      ),
    );
  }
}

class SetUp extends StatelessWidget {
  const SetUp({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setUp(context),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return child;
        }
        return SplashScreen();
      },
    );
  }

  Future<void> setUp(BuildContext context) async {
    // Splashスクリーンを見せるために最小1秒待つ
    final showSplash = Future<void>.delayed(const Duration(seconds: 1));
    await Future.wait([
      Firebase.initializeApp(),
      registerDIContainer(),
    ]);

    await Future.wait([
      context.read(authProvider).implicitLogin(),
      showSplash,
    ]);
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
