import 'package:flutter/material.dart';

class MyTalkPage extends StatelessWidget {
  static const routeName = '/my_talk';

  static const title = 'マイトーク';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(child: Text(title)),
      ],
    );
  }
}
