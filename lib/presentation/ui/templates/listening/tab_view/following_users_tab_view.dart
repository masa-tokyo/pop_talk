import 'package:flutter/material.dart';
import 'package:pop_talk/presentation/notifier/talk_list.dart';
import 'package:pop_talk/presentation/ui/organisms/listening_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FollowingUsersTabView extends StatefulWidget {

  @override
  _FollowingUsersTabViewState createState() => _FollowingUsersTabViewState();
}

class _FollowingUsersTabViewState extends State<FollowingUsersTabView> {
  @override
  Widget build(BuildContext context) {
    return  Consumer(
      builder: (context, watch, _) {
        final talkListNotifier = watch(talkListProvider);
        final talks = talkListNotifier.followLists;
        if (talks == null) {
          return const Center(child: CircularProgressIndicator());
        }
        if (talks.isEmpty) {
          return const Center(child: Text('まだフォローしたユーザーのトークがありません.'));
        }
        return ListView.builder(
          itemCount: talks.length,
          itemBuilder: (BuildContext context, int i) {
            return Padding(
              padding: const EdgeInsets.all(6),
              child: ListeningTile(
                talkItem: talks[i],
              ),
            );
          },
        );
      }
    );
  }

  @override
  void initState() {
    final notifier = context.read(talkListProvider);
    final talks = notifier.followLists;
    if (talks == null) {
      notifier.fetchFollowLists();
    }
    super.initState();
  }
}
