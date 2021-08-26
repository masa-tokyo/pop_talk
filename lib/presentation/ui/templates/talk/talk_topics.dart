import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pop_talk/domain/model/talk_topic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/presentation/notifier/gacha_timer.dart';
import 'package:pop_talk/presentation/notifier/talk_topics.dart';
import 'package:pop_talk/presentation/ui/pages/talk/post_recording_screen.dart';

class TalkTopicsView extends StatelessWidget {
  const TalkTopicsView({
    required this.talkTopics,
  });

  final List<TalkTopic> talkTopics;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PopCornGridView(talkTopics: talkTopics),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Consumer(builder: (context, watch, __) {
                final _gachaTimerNotifier = watch(gachaTimerProvider);
                final _remainMinutesString =
                    (_gachaTimerNotifier.remainSeconds ~/ 60)
                        .toString()
                        .padLeft(2, '0');
                final _remainSecondsString =
                    (_gachaTimerNotifier.remainSeconds % 60)
                        .toInt()
                        .toString()
                        .padLeft(2, '0');
                return Column(
                  children: [
                    Stack(
                      children: [
                        FloatingActionButton(
                          onPressed: _gachaTimerNotifier.remainingCount == 0
                              ? null
                              : () {
                                  _gachaTimerNotifier.play();
                                  context.read(talkTopicProvider).reset();
                                },
                          backgroundColor: Colors.white,
                          child: SvgPicture.asset(
                            'assets/images/poptalk_logo.svg',
                            fit: BoxFit.cover,
                            height: 36,
                            width: 36,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 100,
                      height: 30,
                      child: _gachaTimerNotifier.remainingCount != 0
                          ? Center(
                              child: Text(
                                'あと${_gachaTimerNotifier.remainingCount}回',
                              ),
                            )
                          : Center(
                              child: Text(
                                '''回復まで$_remainMinutesString:$_remainSecondsString''',
                              ),
                            ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}

class PopCornGridView extends StatefulWidget {
  const PopCornGridView({
    Key? key,
    required this.talkTopics,
  }) : super(key: key);

  final List<TalkTopic> talkTopics;

  @override
  _PopCornGridViewState createState() => _PopCornGridViewState();
}

class _PopCornGridViewState extends State<PopCornGridView>
    with SingleTickerProviderStateMixin {
  static const randomDelays = [0.0, 0.2, 0.4, 0.6];
  late final List<Animation<double>> animations;

  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..forward();
    animations = widget.talkTopics.map((_) {
      final randomDelay = ([...randomDelays]..shuffle()).first;
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(randomDelay, randomDelay + 0.3, curve: Curves.linear),
        ),
      );
    }).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: widget.talkTopics.asMap().entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: FadeTransition(
            opacity: animations[entry.key],
            child: InkWell(
              onTap: () => _openPostRecordingScreen(context),
              child: Card(
                child: Center(
                  child: Text(entry.value.name),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _openPostRecordingScreen(BuildContext context) {
    //todo show the screen from the bottom
    Navigator.push(context,
        MaterialPageRoute<void>(builder: (_) => const PostRecordingScreen()));
  }
}
