import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ResisterPage extends StatefulWidget {
  const ResisterPage({Key? key}) : super(key: key);

  @override
  _ResisterPageState createState() => _ResisterPageState();
}

class _ResisterPageState extends State<ResisterPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 30, left: 10),
          alignment: Alignment.topLeft,
          child: IconButton(
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
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF804B3A),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 100),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.70,
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/google_logo.png',
                      height: 20,
                      width: 20,
                      fit: BoxFit.cover,
                    ),
                    const Text(
                      'Googleでログインする',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(
                      FontAwesomeIcons.apple,
                      size: 20,
                    ),
                    Text(
                      'Appleでログインする',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.centerRight,
                child: RichText(
                  overflow: TextOverflow.clip,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'アカウントをお持ちでない方は',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      TextSpan(
                        text: 'こちら',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              RichText(
                overflow: TextOverflow.clip,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '利用規約',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade800,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pop(context),
                    ),
                    const TextSpan(
                        text: ' | ',
                        style: TextStyle(fontSize: 12, color: Colors.black)),
                    TextSpan(
                      text: 'プライバシーポリシー',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade800,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pop(context),
                    ),
                    const TextSpan(
                        text: ' | ',
                        style: TextStyle(fontSize: 12, color: Colors.black)),
                    TextSpan(
                      text: 'お問い合わせ',
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
