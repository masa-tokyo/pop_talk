import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  String uid = '';
  // String name = '';
  bool isAnonymous = false;
  List<String> followingUserIds = [];
  List<String> likeTalkIds = [];
  List<String> myTalkIds = [];

  @override
  Widget build(BuildContext context) {
    isMember = isInit ? widget.isMember : !widget.isMember;
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
                  fontWeight: FontWeight.w800,
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
                onPressed: () async {
                  await _signInWithGoogle();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/google_logo.png',
                      height: 20,
                      width: 20,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      isMember! ? 'Googleでログインする' : 'Googleで始める',
                      style: const TextStyle(color: Colors.black),
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
                  children: [
                    const Icon(
                      FontAwesomeIcons.apple,
                      size: 20,
                    ),
                    Text(
                      isMember! ? 'Appleでログインする' : 'Appleで始める',
                      style: const TextStyle(color: Colors.white),
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
                        text: isMember! ? 'アカウントをお持ちでない方は' : 'アカウントをお持ちの方は',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      TextSpan(
                        text: 'こちら',
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
                      text: '利用規約',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade800,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
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
                      recognizer: TapGestureRecognizer()..onTap = () {},
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
              )
            : RichText(
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'アカウント登録により\n',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    TextSpan(
                      text: '利用規約',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade800,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    const TextSpan(
                      text: 'と',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'プライバシーポリシー',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade800,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    const TextSpan(
                        text: 'に同意することになります\n',
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
    );
  }

  Future _signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    try {
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await _auth.signInWithCredential(credential).then((value) async {
          uid = value.user!.uid;
          if (value.additionalUserInfo!.isNewUser != false) {
            await FirebaseFirestore.instance
                .collection('user')
                .doc(uid)
                .set(<String, dynamic>{
              'name': value.user!.displayName,
              'isisAnonymous': isAnonymous,
              'followingUserIds': followingUserIds,
              'likeTalkIds': likeTalkIds,
              'myTalkIds': myTalkIds,
              'photoUrl': value.user!.photoURL,
            });
          }
        });
        Navigator.pop(context);
      }
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }
}
