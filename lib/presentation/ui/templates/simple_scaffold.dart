import 'package:flutter/material.dart';

class SimpleScaffold extends StatelessWidget {
  const SimpleScaffold({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: child,
      ),
    );
  }
}
