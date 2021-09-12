import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/presentation/notifier/talk_list.dart';
import 'package:pop_talk/presentation/ui/templates/listening/listening.dart';

class ListeningPage extends StatelessWidget {
  static const routeName = '/listening';

  static const title = 'リスニング';

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, __) {
        final _talkListProvider = watch(talkListProvider);
        final _recommendLists = _talkListProvider.recommendLists;
        final _followLists = _talkListProvider.followLists;
        final _likeLists = _talkListProvider.likeLists;
        if (_talkListProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListeningTemplate(
            recommendLists: _recommendLists,
            followLists: _followLists,
            likeLists: _likeLists,
          );
        }
      },
    );
  }
}
