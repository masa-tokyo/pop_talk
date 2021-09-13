import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pop_talk/presentation/ui/templates/listening/listening.dart';

class ListeningPage extends StatelessWidget {
  static const routeName = '/listening';

  static const title = 'リスニング';

  @override
  Widget build(BuildContext context) {
    return ListeningTemplate();
  }
}
