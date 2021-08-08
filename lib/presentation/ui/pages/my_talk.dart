import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/presentation/ui/templates/my_talk/unauthorized_my_talk.dart';
import 'package:pop_talk/presentation/notifier/talk_item.dart';

class MyTalkPage extends StatelessWidget {
  const MyTalkPage({Key? key}) : super(key: key);

  static const routeName = '/my_talk';

  static const title = 'マイトーク';

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, __) {
        final _talkItemNotifier = watch(talkItemProvider);
        final _talkItems = _talkItemNotifier.talkItems;
        return _talkItemNotifier.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            // TODO(MyTalkTeam): ログイン状態で表示を分岐させる
            : UnauthorizedMyTalk(talkItems: _talkItems);
      },
    );
  }
}
