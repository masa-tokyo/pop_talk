import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/presentation/notifier/talk_topics.dart';
import 'package:pop_talk/presentation/ui/templates/talk/gacha.dart';
import 'package:pop_talk/presentation/ui/templates/talk/talk_topics.dart';

class TalkPage extends StatelessWidget {
  static const routeName = '/talk';

  static const title = '話す';

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, __) {
        final _talkTopicNotifier = watch(talkTopicProvider);
        if (_talkTopicNotifier.talkTopics.isEmpty) {
          return GachaView();
        } else {
          return TalkTopicsView(talkTopics: _talkTopicNotifier.talkTopics);
        }
      },
    );
  }

}
