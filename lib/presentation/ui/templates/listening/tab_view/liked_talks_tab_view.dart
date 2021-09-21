import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/presentation/notifier/player.dart';
import 'package:pop_talk/presentation/notifier/talk_list.dart';
import 'package:pop_talk/presentation/ui/atoms/circular_progress_indicator.dart';
import 'package:pop_talk/presentation/ui/organisms/listening_tile.dart';
import 'package:pop_talk/presentation/ui/templates/listening/tab_view/recommendation_tab_view.dart';

class LikedTalksTabView extends StatefulWidget {
  @override
  _LikedTalksTabViewState createState() => _LikedTalksTabViewState();
}

class _LikedTalksTabViewState extends State<LikedTalksTabView> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final talkListNotifier = watch(talkListProvider);
      final talks = talkListNotifier.likeLists;
      if (talks == null) {
        return const Center(child: PopTalkCircularProgressIndicator());
      }
      if (talks.isEmpty) {
        return const Center(child: Text('まだライクしたトークがありません.'));
      }
      return RefreshIndicator(
        color: Theme.of(context).primaryColor,
        onRefresh: () async {
          await talkListNotifier.fetchLikeLists();
        },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: talks.length,
          itemBuilder: (BuildContext context, int i) {
            return Padding(
              padding: const EdgeInsets.all(6),
              child: ListeningTile(
                talkItem: talks[i],
                onTap: (_) async {
                  await context
                      .read(
                        playerFamilyProvider(
                          RecommendationTabView.playerProviderName,
                        ),
                      )
                      .reset();
                  final playerNotifier = context.read(playerProvider);
                  await playerNotifier.initPlayer(
                    AudioPlayType.playlist,
                    talks: talks.skip(i).toList(),
                  );
                  await playerNotifier.play();
                },
              ),
            );
          },
        ),
      );
    });
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
