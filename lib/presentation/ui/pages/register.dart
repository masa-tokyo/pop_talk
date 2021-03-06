import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pop_talk/presentation/notifier/auth.dart';
import 'package:pop_talk/presentation/ui/pages/service/privacy.dart';
import 'package:pop_talk/presentation/ui/pages/service/term_of_use.dart';
import 'package:pop_talk/presentation/ui/utils/modal_bottom_sheet.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key? key,
    required this.isMember,
    required this.modalSetState,
  }) : super(key: key);

  final bool isMember;
  final StateSetter modalSetState;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool? isMember;
  bool isInit = true;

  @override
  Widget build(BuildContext context) {
    final authNotifier = context.read(authProvider);

    isMember = isInit ? widget.isMember : !widget.isMember;
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 36),
              alignment: Alignment.topLeft,
              child: IconButton(
                padding: const EdgeInsets.symmetric(vertical: 8),
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(height: 100),
            Column(
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
              ],
            ),
            const SizedBox(height: 100),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 180, maxWidth: 300),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () async {
                      final result = isMember!
                          ? await authNotifier.signInWithGoogle()
                          : await authNotifier.signUpWithGoogle();
                      if (result) {
                        Navigator.pop(context);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/google_logo.png',
                          height: 30,
                          width: 30,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          isMember! ? 'Google?????????????????????' : 'Google????????????',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (Platform.isIOS)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () async {
                        final result = isMember!
                            ? await authNotifier.signInWithApple()
                            : await authNotifier.signUpWithApple();
                        if (result) {
                          Navigator.pop(context);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.apple,
                            size: 30,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            isMember! ? 'Apple?????????????????????' : 'Apple????????????',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Consumer(
                    builder: (context, watch, __) {
                      final message = watch(authProvider).errorMessage;
                      if (message == null) {
                        return const SizedBox.shrink();
                      } else {
                        return SizedBox(
                          height: 50,
                          child: Center(
                            child: Text(
                              message,
                              style: const TextStyle(color: Colors.redAccent),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.centerRight,
                    child: RichText(
                      overflow: TextOverflow.clip,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: isMember! ? '??????????????????????????????????????????' : '????????????????????????????????????',
                            style: TextStyle(color: Colors.grey[800]),
                          ),
                          TextSpan(
                            text: '?????????',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                widget.modalSetState(() {
                                  isInit = !isInit;
                                });
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            isMember!
                ? RichText(
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '????????????',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade800,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => showBottomSheetPage(
                                context: context, page: ServiceTermOfUsePage()),
                        ),
                        const TextSpan(
                            text: ' | ',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black)),
                        TextSpan(
                          text: '??????????????????????????????',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade800,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => showBottomSheetPage(
                                context: context, page: ServicePrivacyPage()),
                        ),
                        const TextSpan(
                            text: ' | ',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black)),
                        TextSpan(
                          text: '??????????????????',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  )
                : RichText(
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: '??????????????????????????????\n',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        TextSpan(
                          text: '????????????',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade800,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => showBottomSheetPage(
                                context: context, page: ServiceTermOfUsePage()),
                        ),
                        const TextSpan(
                          text: '???',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        TextSpan(
                          text: '??????????????????????????????',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade800,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => showBottomSheetPage(
                                context: context, page: ServicePrivacyPage()),
                        ),
                        const TextSpan(
                          text: '????????????????????????????????????\n',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        TextSpan(
                          text: '??????????????????',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
