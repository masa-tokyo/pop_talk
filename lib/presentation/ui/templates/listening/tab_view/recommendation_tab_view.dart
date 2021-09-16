import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/presentation/notifier/auth.dart';
import 'package:pop_talk/presentation/notifier/player.dart';
import 'package:pop_talk/presentation/notifier/talk_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/presentation/ui/utils/functions.dart';

class RecommendationTabView extends StatefulWidget {
  const RecommendationTabView({Key? key}) : super(key: key);

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
    final primaryColor = Theme.of(context).primaryColor;

    return Consumer(
      builder: (_, watch, __) {
        final talkListNotifier = watch(talkListProvider);
        final playerNotifier = watch(playerProvider);

        if (talkListNotifier.recommendLists == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final talkItem =
            talkListNotifier.recommendLists![playerNotifier.currentIndex];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(26),
              child: Container(
                decoration: _decoration(primaryColor),
                child: Column(
                  children: [
                    _topicCard(context, talkItem),
                    _aboutTopicItem(talkItem),
                    _audioPlayer(context, playerNotifier, talkListNotifier),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _followButton(talkItem),
                          const SizedBox(width: 15),
                          _likeButton(talkItem),
                          const SizedBox(width: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //_miniPlayer(),
          ],
        );
      },
    );
  }

  BoxDecoration _decoration(Color primaryColor) {
    return BoxDecoration(
      border: Border.all(width: 3, color: primaryColor),
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          // changes position of shadow
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  Widget _topicCard(BuildContext context, TalkItem talkItem) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Container(
        height: height * 0.25,
        width: width * 0.75,
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            _userImage(talkItem),
            Center(
              child: Text(
                talkItem.topicName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _userImage(TalkItem talkItem) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(talkItem.createdUser.photoUrl),
                ),
              ),
            ),
            Text(
              talkItem.createdUser.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _aboutTopicItem(TalkItem talkItem) {
    return Column(
      children: [
        Center(
            child: Text(
          talkItem.title ?? '無題',
          style: const TextStyle(fontWeight: FontWeight.bold),
        )),
        const SizedBox(
          height: 10,
        ),
        // TODO(any): 詳細表示
        Center(
            child: Text(
          talkItem.description ?? '',
        )),
      ],
    );
  }

  Widget _audioPlayer(
    BuildContext context,
    PlayerNotifier playerNotifier,
    TalkListNotifier talkListNotifier,
  ) {
    final primaryColor = Theme.of(context).primaryColor;

    return Column(
      children: [
        _slider(context, playerNotifier),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  playerNotifier.seekToPrevious();
                },
                // なぜかarrow_back_iosを使うと左に寄るのでforwardを180度反転
                child: RotatedBox(
                  quarterTurns: 2,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 50,
                    color: playerNotifier.hasPrevious()
                        ? primaryColor
                        : Colors.grey,
                  ),
                ),
              ),
              _playButton(context, playerNotifier),
              InkWell(
                onTap: () {
                  playerNotifier.seekToNext();
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 50,
                  color: playerNotifier.hasNext() ? primaryColor : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _slider(BuildContext context, PlayerNotifier playerNotifier) {
    final primaryColor = Theme.of(context).primaryColor;
    final position = playerNotifier.position;
    final duration = playerNotifier.duration;

    return Column(children: [
      Slider(
        value: duration.inSeconds == 0
            ? 0
            : position.inSeconds / duration.inSeconds,
        onChanged: (value) {
          final newPosition = value * duration.inSeconds;
          playerNotifier.seek(newPosition.toInt());
        },
        activeColor: primaryColor,
        inactiveColor: Colors.grey[300],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              convertDurationToString(position),
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline5!.fontSize),
            ),
            Text(
              convertDurationToString(duration),
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline5!.fontSize),
            ),
          ],
        ),
      )
    ]);
  }

  Widget _playButton(BuildContext context, PlayerNotifier playerNotifier) {
    final buttonState = playerNotifier.playerButtonState;
    final primaryColor = Theme.of(context).primaryColor;

    Widget icon;
    switch (buttonState) {
      case PlayerButtonState.loading:
        icon = const SizedBox(
          width: 24,
          height: 24,
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        );
        break;
      case PlayerButtonState.playing:
        icon = const FaIcon(
          FontAwesomeIcons.pause,
          size: 24,
        );
        break;
      case PlayerButtonState.paused:
        icon = const FaIcon(
          FontAwesomeIcons.play,
          size: 24,
        );
    }

    return SizedBox(
      width: 80,
      height: 80,
      child: ElevatedButton(
        onPressed: () {
          if (buttonState == PlayerButtonState.paused) {
            playerNotifier.play();
          } else if (buttonState == PlayerButtonState.playing) {
            playerNotifier.pause();
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
          shape: MaterialStateProperty.all(
              CircleBorder(side: BorderSide(color: primaryColor))),
        ),
        child: icon,
      ),
    );
  }

  Widget _followButton(TalkItem talk) {
    return Consumer(
      builder: (context, watch, _) {
        final _authNotifier = watch(authProvider);
        return _authNotifier.currentUser!.alreadyFollowUser(talk.createdUser.id)
            ? ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                label: const Text('フォロー中'),
                icon: const Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
              )
            : OutlinedButton.icon(
                onPressed: () async {
                  await _authNotifier.followUser(talk.createdUser);
                  await context.read(talkListProvider).fetchFollowLists();
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    width: 1,
                    color: Colors.grey[800]!,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  primary: Colors.grey[800],
                ),
                label: const Text('フォロー'),
                icon: Icon(
                  Icons.person_add,
                  color: Colors.grey[800],
                ),
              );
      },
    );
  }

  Widget _likeButton(TalkItem talk) {
    return Consumer(
      builder: (context, watch, _) {
        final _authNotifier = watch(authProvider);
        return _authNotifier.currentUser!.alreadyLikeTalk(talk.id)
            ? ElevatedButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                label: const Text('いいね'),
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
              )
            : OutlinedButton.icon(
                onPressed: () async {
                  await _authNotifier.likeTalk(talk);
                  await context.read(talkListProvider).fetchLikeLists();
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    width: 1,
                    color: Colors.grey[800]!,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Colors.grey[800],
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                label: const Text('いいね'),
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.grey[800],
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

    final playerNotifier = context.read(playerProvider);
    await playerNotifier.initPlayer(
      talks: talkListNotifier.recommendLists!,
    );
  }
}
