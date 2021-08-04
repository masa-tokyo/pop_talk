import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/presentation/notifier/auth.dart';

class MyTalkPage extends StatelessWidget {
  static const routeName = '/my_talk';

  static const title = 'マイトーク';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(child: Text(title)),
        Consumer(
          builder: (context, watch, __) {
            final _authNotifier = watch(authProvider);
            if (_authNotifier.currentUser == null) {
              return const Text('ログインしていません');
            }
            final currentUser = _authNotifier.currentUser!;
            return Column(
              children: [
                Text('ID: ${currentUser.id}'),
                Text('Name: ${currentUser.name}'),
              ],
            );
          },
        ),
      ],
    );
  }
}
