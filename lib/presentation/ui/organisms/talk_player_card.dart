import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/presentation/notifier/auth.dart';
import 'package:pop_talk/presentation/notifier/player.dart';
import 'package:pop_talk/presentation/ui/utils/functions.dart';

class TalkPlayerCard extends StatelessWidget {
  const TalkPlayerCard(
    this.talk,
    this.playerNotifier, {
    this.onPlay,
  });

  final TalkItem talk;
  final PlayerNotifier playerNotifier;
  final void Function(TalkItem talk)? onPlay;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _topicCard(),
            _aboutTopicItem(),
            _audioPlayer(context),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _followButton(),
                  const SizedBox(width: 15),
                  _likeButton(),
                  const SizedBox(width: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topicCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          color: Color(talk.colorCode),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Stack(
            children: [
              _userImage(),
              Center(
                child: Text(
                  talk.topicName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _userImage() {
    return Align(
      alignment: Alignment.topRight,
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
                image: NetworkImage(talk.createdUser.photoUrl),
              ),
            ),
          ),
          Text(
            talk.createdUser.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _aboutTopicItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          talk.title ?? '無題',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        // TODO(any): 詳細表示
        Text(
          talk.description ?? '',
        ),
      ],
    );
  }

  Widget _audioPlayer(
    BuildContext context,
  ) {
    final primaryColor = Theme.of(context).primaryColor;

    return Column(
      children: [
        _slider(context),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: playerNotifier.seekToPrevious,
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
              _playButton(context),
              InkWell(
                onTap: playerNotifier.seekToNext,
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

  Widget _slider(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final position = playerNotifier.position;
    final duration = playerNotifier.duration;

    return Column(
      children: [
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
      ],
    );
  }

  Widget _playButton(BuildContext context) {
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
            if (onPlay != null) {
              onPlay!(talk);
            }
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

  Widget _followButton() {
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

  Widget _likeButton() {
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
}
