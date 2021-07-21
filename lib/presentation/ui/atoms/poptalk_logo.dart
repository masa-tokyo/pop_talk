import 'package:flutter/material.dart';

class PopTalkLogo extends StatelessWidget {
  const PopTalkLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      fit: BoxFit.fill,
      width: 40 * 1001 / 667,
      height: 40,
    );
  }
}
