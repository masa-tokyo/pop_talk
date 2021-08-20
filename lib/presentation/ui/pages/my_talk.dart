import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/presentation/ui/templates/my_talk/unauthorized_my_talk.dart';
import 'package:pop_talk/presentation/ui/templates/my_talk/authorized_my_talk.dart';
import 'package:pop_talk/presentation/notifier/talk_item.dart';
import 'package:pop_talk/presentation/notifier/auth.dart';

class MyTalkPage extends StatelessWidget {
  const MyTalkPage({Key? key}) : super(key: key);

  static const routeName = '/my_talk';

  static const title = 'マイトーク';

// Googleサインイン等は未実装なので匿名ログインを使って仮実装している状態
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, __) {
        final _authNotifier = watch(authProvider);
        final _talkItemNotifier = watch(talkItemProvider);
        final _savedTalkItems = _talkItemNotifier.savedTalkItems;
        final _postedTalkItems = _talkItemNotifier.postedTalkItems;
        if (_talkItemNotifier.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (_authNotifier.currentUser == null) {
          return UnauthorizedMyTalk(savedTalkItems: _savedTalkItems);
        } else {
          return AuthorizedMyTalk(
            savedTalkItems: _savedTalkItems,
            postedTalkItems: _postedTalkItems,
            userData: _authNotifier.currentUser!,
          );
        }
      },
    );
  }
}
