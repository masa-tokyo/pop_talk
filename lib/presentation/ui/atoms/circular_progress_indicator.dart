import 'package:flutter/material.dart';

class PopTalkCircularProgressIndicator extends StatelessWidget {
  const PopTalkCircularProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
    );
  }
}
