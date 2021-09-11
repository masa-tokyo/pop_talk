import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pop_talk/domain/model/talk_topic.dart';
import 'package:pop_talk/presentation/notifier/gacha_timer.dart';
import 'package:pop_talk/presentation/notifier/talk_topics.dart';
import 'package:pop_talk/presentation/ui/pages/talk/post_recording_screen.dart';
import 'package:pop_talk/presentation/ui/utils/routes.dart';

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
    with TickerProviderStateMixin {
  double fadedelayTime = 0;
  double expanddelayTime = 0;
  double shrinkdelayTime = 0;

  late final List<Animation<double>> fadeAnimations;
  late final List<Animation<double>> expandAnimations;
  late final List<Animation<double>> shrinkAnimations;
  late final List<Animation<double>> scaleAnimations;

  late final AnimationController fadeController;
  late final AnimationController expandcontroller;
  late final AnimationController shrinkcontroller;
  late final AnimationController controller2;
  late final AnimationController scalecontroller;

  @override
  void initState() {
    //フェードアニメーション
    fadeController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )
      ..forward()
      ..addStatusListener((status) {});

    fadeAnimations = widget.talkTopics.map((_) {
      fadedelayTime = fadedelayTime + 0.15;
      return Tween(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: fadeController,
          curve: Interval(fadedelayTime, fadedelayTime + 0.1,
              curve: Curves.linear),
        )..addStatusListener(
            (status) {
              if (status == AnimationStatus.completed) {
                setState(() {});
              }
            },
          ),
      );
    }).toList();

    //拡大アニメーション
    expandcontroller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..forward();

    expandAnimations = widget.talkTopics.map((_) {
      expanddelayTime = expanddelayTime + 0.15;

      return Tween(
        begin: 0.0,
        end: 1.3,
      ).animate(CurvedAnimation(
        parent: expandcontroller,
        curve: Interval(expanddelayTime, expanddelayTime + 0.1,
            curve: Curves.decelerate),
      )..addStatusListener(
          (status) {},
        ));
    }).toList();

    //縮小コントローラー
    shrinkcontroller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();

    shrinkAnimations = widget.talkTopics.map((_) {
      shrinkdelayTime = shrinkdelayTime + 0.15;
      return Tween(
        begin: 1.3,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: shrinkcontroller,
        curve: Interval(
          shrinkdelayTime,
          shrinkdelayTime + 0.1,
          curve: Curves.decelerate,
        ),
      )..addStatusListener(
          (status) {},
        ));
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
          child: InkWell(
            onTap: () => _openPostRecordingScreen(
                context,
                entry.value.id,
                entry.value.name),
            child: FadeTransition(
              opacity: fadeAnimations[entry.key],
              child: AnimatedBuilder(
                  animation: expandcontroller,
                  builder: (buildContext, child) {
                    return Transform.scale(
                      scale: expandAnimations[entry.key].value != 1.3
                          ? expandAnimations[entry.key].value
                          : shrinkAnimations[entry.key].value,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xff804B3A),
                            width: 10,
                          ),
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 20,
                              top: 20,
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffFF934E),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 20,
                              bottom: 20,
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  // ignore: lines_longer_than_80_chars
                                  color: Color(0xffFF934E),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(entry.value.name),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _openPostRecordingScreen(BuildContext context, String id, String name) {

    Navigator.push(context, createRouteFromBottom(context,
        PostRecordingScreen(talkTopicId: id, talkTopicName: name,)));
  }
}

