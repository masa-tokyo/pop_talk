import 'package:flutter/material.dart';
import 'package:pop_talk/presentation/notifier/talk_list.dart';
import 'package:pop_talk/presentation/ui/organisms/listening_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikedTalksTabView extends StatefulWidget {

  @override
  _LikedTalksTabViewState createState() => _LikedTalksTabViewState();
}

class _LikedTalksTabViewState extends State<LikedTalksTabView> {
  @override
  Widget build(BuildContext context) {
    return  Consumer(
      builder: (context, watch, _) {
        final talkListNotifier = watch(talkListProvider);
        final talks = talkListNotifier.likeLists;
        if (talks == null) {
          return const Center(child: CircularProgressIndicator());
        }
        if (talks.isEmpty) {
          return const Center(child: Text('まだライクしたトークがありません.'));
        }
        return ListView.builder(
          itemCount: talks.length,
          itemBuilder: (BuildContext context, int i) {
            return Padding(
              padding: const EdgeInsets.all(10),
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
    final talks = notifier.likeLists;
    if (talks == null) {
      notifier.fetchLikeLists();
    }
    super.initState();
  }
}
