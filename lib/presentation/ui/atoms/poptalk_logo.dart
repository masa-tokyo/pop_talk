import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PopTalkLogo extends StatelessWidget {
  const PopTalkLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/poptalk_logo.svg',
      fit: BoxFit.fill,
      width: 40,
      height: 40,
    );
  }
}
