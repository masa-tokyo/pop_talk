import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/presentation/notifier/player.dart';
import 'package:pop_talk/presentation/notifier/talk_list.dart';
import 'package:pop_talk/presentation/ui/atoms/circular_progress_indicator.dart';
import 'package:pop_talk/presentation/ui/organisms/talk_player_card.dart';

class RecommendationTabView extends StatefulWidget {
  const RecommendationTabView({Key? key}) : super(key: key);

  static const playerProviderName = 'recommend';

  @override
  _RecommendationTabViewState createState() => _RecommendationTabViewState();
}

class _RecommendationTabViewState extends State<RecommendationTabView> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, watch, __) {
        final talkListNotifier = watch(talkListProvider);
        final recommendPlayerNotifier = watch(
          playerFamilyProvider(RecommendationTabView.playerProviderName),
        );

        if (talkListNotifier.recommendLists == null  ||
         recommendPlayerNotifier.currentTalk == null) {
          return const Center(child: PopTalkCircularProgressIndicator());
        }
        return RefreshIndicator(
          color: Theme.of(context).primaryColor,
          onRefresh: () async {
            await talkListNotifier.fetchRecommendLists();
            final playerNotifier = context.read(
              playerFamilyProvider(RecommendationTabView.playerProviderName),
            );
            await playerNotifier.reset();
            await playerNotifier.initPlayer(
              AudioPlayType.playlist,
              talks: talkListNotifier.recommendLists,
            );
          },
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(26),
                  child: FittedBox(
                    child: TalkPlayerCard(
                      recommendPlayerNotifier.currentTalk!,
                      recommendPlayerNotifier,
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

  Future<void> _init() async {
    final talkListNotifier = context.read(talkListProvider);
    final recommendedTalks = talkListNotifier.recommendLists;
    if (recommendedTalks == null) {
      await talkListNotifier.fetchRecommendLists();
    }

    final playerNotifier = context.read(
      playerFamilyProvider(RecommendationTabView.playerProviderName),
    );
    if (!playerNotifier.hasPlayer()) {
      await playerNotifier.initPlayer(
        AudioPlayType.playlist,
        talks: talkListNotifier.recommendLists,
      );
    }
  }
}
