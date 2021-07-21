import 'package:flutter/material.dart';

class ListeningPage extends StatelessWidget {
  static const routeName = '/listening';

  static const title = '聞く';

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
