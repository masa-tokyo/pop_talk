import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/presentation/notifier/auth.dart';
import 'package:pop_talk/presentation/notifier/my_talk.dart';
import 'package:pop_talk/presentation/ui/templates/my_talk/authorized_my_talk_page.dart';
import 'package:pop_talk/presentation/ui/templates/my_talk/unauthorized_my_talk_page.dart';

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
        final _talkItemNotifier = watch(myTalkProvider);
        final _draftTalkItems = _talkItemNotifier.draftTalkItems;
        final _publishTalkItems = _talkItemNotifier.publishTalkItems;
        if (_authNotifier.currentUser!.isAnonymous) {
          return UnauthorizedMyTalkPage(draftTalkItems: _draftTalkItems);
        } else {
          return AuthorizedMyTalkPage(
            draftTalkItems: _draftTalkItems,
            publishTalkItems: _publishTalkItems,
            userData: _authNotifier.currentUser!,
          );
        }
      },
    );
  }
}
