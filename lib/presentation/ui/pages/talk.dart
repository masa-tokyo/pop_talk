//import 'dart:math' as math;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:pop_talk/presentation/notifier/talk_topics.dart';
import 'package:pop_talk/presentation/ui/pages/talk_select.dart';

class TalkPage extends StatefulWidget {
  static const routeName = '/talk';

  static const title = '話す';

  @override
  _TalkPageState createState() => _TalkPageState();
}

class _TalkPageState extends State<TalkPage>
    with SingleTickerProviderStateMixin {
  final firstImage = Image.asset('assets/images/pop.png');
  final secondImage = Image.asset('assets/images/pop_move.png');
  CrossFadeState crossFadeStateValue = CrossFadeState.showFirst;
  //Timer crossFadeTimer;
  bool tap = false;
  double _test = 0;
  int tapcount = 0;
  //final _authNotifier = context.read(authorizedUserProvider);

  late AnimationController _controller;
  late SequenceAnimation _sequenceAnimation;
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    //_controller = AnimationController(vsync: this);
    // _sequenceAnimation = SequenceAnimationBuilder()
    //     .addAnimatable(
    //         animatable: ColorTween(begin: Colors.red, end: Colors.amber),
    //         from: const Duration(seconds: 0),
    //         to: const Duration(seconds: 4),
    //         curve: Curves.easeInOut,
    //         tag: 'color')
    //     .addAnimatable(
    //         animatable: Tween<double>(begin: 50, end: 200),
    //         from: const Duration(milliseconds: 0),
    //         to: const Duration(milliseconds: 2000),
    //         curve: Curves.easeInOut,
    //         tag: 'width')
    //     .addAnimatable(
    //         animatable: CurveTween(curve: Curves.ease),
    //         from: const Duration(milliseconds: 2000),
    //         to: const Duration(milliseconds: 3800),
    //         curve: Curves.easeInOut,
    //         tag: 'height')
    //     .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //return Consumer(builder: (context, watch, __) {
    final _talkTopicNotifier = context.read(talkTopicProvider);
    //return Consumer(builder: (context, watch, __) {
    return Scaffold(
      body: Column(
        //mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: () async {
                if (tap == false) {
                  tap = true;
                  await _talkTopicNotifier.nextThemes();

                  // await Future<void>.delayed(
                  //   const Duration(seconds: 4),
                  // );
                  //
                  // tapcount = 1;
                  //
                  // await Future<void>.delayed(
                  //   const Duration(seconds: 4),
                  // );

                  await Navigator.of(context).push<void>(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return TalkSelectPage();
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        final double begin = 0.0;
                        final double end = 1.0;
                        final Animatable<double> tween =
                            Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: Curves.easeInBack));
                        final Animation<double> doubleAnimation =
                            animation.drive(tween);
                        return FadeTransition(
                          opacity: doubleAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                }
              },
              child: AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget? child) {
                    if (tap == true) {
                      if (tapcount == 0) {
                        return Transform.rotate(
                          angle:
                              math.sin(_controller.value * 15 * math.pi) / 60,
                          child: firstImage,
                        );
                      } else {
                        //tapcount == 1
                        return Transform.rotate(
                          angle: math.sin(_controller.value * 2 * math.pi),
                          child: firstImage,
                        );
                      }
                    } else {
                      return firstImage;
                    }
                  }),
            ),
          ),
          const Text("タップしてね"),
          // Expanded(
          //   child: GridView.count(
          //     crossAxisCount: 2,
          //     children: _talkTopicNotifier.talkTopics.map((topic) {
          //       return Padding(
          //         padding: const EdgeInsets.all(10),
          //         child: Card(
          //           child: Center(child: Text(topic.name)),
          //         ),
          //       );
          //     }).toList(),
          //   ),
          // ),
        ],
      ),
    );

    //},
    //);
    //});
    //});
  }
}
