import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyTalkPage extends StatelessWidget {
  static const routeName = '/my_talk';

  static const title = 'マイトーク';

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(child: Text(title)),
        ElevatedButton(
          onPressed: () async {
            final credential = await _auth.signInAnonymously();
            print(credential);
          },
          child: const Text('ログイン'),
        ),
      ],
    );
  }
}
