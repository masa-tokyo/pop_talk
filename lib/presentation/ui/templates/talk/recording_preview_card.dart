import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pop_talk/domain/model/talk_topic.dart';
import 'package:pop_talk/presentation/notifier/player.dart';
import 'package:pop_talk/presentation/ui/utils/functions.dart';

class RecordingPreviewCard extends StatelessWidget {
  const RecordingPreviewCard({required this.talkTopic, required this.path});

  final TalkTopic talkTopic;
  final String path;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Container(
      decoration: _decoration(primaryColor),
      child: Column(
        children: [
          _topicCard(context),
          const SizedBox(
            height: 24,
          ),
          _player(context),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
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

  Widget _topicCard(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Container(
        height: height * 0.25,
        width: width * 0.75,
        decoration: BoxDecoration(
          color: Color(talkTopic.colorCode),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                talkTopic.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Theme.of(context).textTheme.headline2!.fontSize),
              ),
            )
          ],
        ),
      ),
    );
  }

  Consumer _player(BuildContext context) {
    return Consumer(
      builder: (_, watch, __) {
        final playerNotifier = watch(playerProvider);
        return Column(
          children: [
            _slider(context, playerNotifier),
            _playButton(context, playerNotifier),
          ],
        );
      },
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
                CircleBorder(side: BorderSide(color: primaryColor)))),
        child: icon,
      ),
    );
  }
}
