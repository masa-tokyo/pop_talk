import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/presentation/notifier/player.dart';
import 'package:pop_talk/presentation/notifier/talk_list.dart';
import 'package:pop_talk/presentation/ui/atoms/circular_progress_indicator.dart';
import 'package:pop_talk/presentation/ui/organisms/talk_player_card.dart';

class RecommendPlayer {
  RecommendPlayer(this._talkListNotifier, this.playerNotifier);

  static const playerProviderName = 'recommend';

  final TalkListNotifier _talkListNotifier;
  final PlayerNotifier playerNotifier;

  TalkItem? get currentTalk => playerNotifier.currentTalk;

  Future<void> refresh() async {
    return _talkListNotifier.fetchRecommendLists();
  }
}

final _recommendProvider = Provider.autoDispose<RecommendPlayer>((ref) {
  final talkListNotifier = ref.watch(talkListProvider);
  final recommendPlayerNotifier = ref.watch(
    playerFamilyProvider(RecommendPlayer.playerProviderName),
  );
  final talks = talkListNotifier.recommendLists;
  // talkがない時はtalkを取得
  if (talks == null) {
    talkListNotifier.fetchRecommendLists();
    return RecommendPlayer(talkListNotifier, recommendPlayerNotifier);
  }

  // talkがあってplayerがないならplayerを初期化
  // 両方ある時にそれぞれのtalkに差異がある時はplayerを初期化
  if (!recommendPlayerNotifier.hasPlayer() ||
      !listEquals(
        talks.map((e) => e.id).toList(),
        recommendPlayerNotifier.playList!.map((e) => e.id).toList(),
      )) {
    recommendPlayerNotifier.initPlayer(AudioPlayType.playlist, talks: talks);
  }

  return RecommendPlayer(talkListNotifier, recommendPlayerNotifier);
});

class RecommendationTabView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, watch, __) {
        final recommendPlayer = watch(_recommendProvider);
        if (recommendPlayer.currentTalk == null) {
          return const Center(child: PopTalkCircularProgressIndicator());
        }
        return RefreshIndicator(
          color: Theme.of(context).primaryColor,
          onRefresh: () async {
            await recommendPlayer.refresh();
          },
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(26),
                  child: FittedBox(
                    child: TalkPlayerCard(
                      recommendPlayer.currentTalk!,
                      recommendPlayer.playerNotifier,
                      onPlay: (_) {
                        context.read(playerProvider).reset();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
