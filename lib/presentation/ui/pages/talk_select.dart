import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/presentation/notifier/talk_topics.dart';
import 'package:pop_talk/presentation/ui/pages/talk.dart';

class TalkSelectPage extends StatefulWidget {
  static const routeName = '/talk/select';

  static const title = '話す';

  @override
  _TalkSelectPageState createState() => _TalkSelectPageState();
}

class _TalkSelectPageState extends State<TalkSelectPage> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 3;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, __) {
        final _talkTopicNotifier = watch(talkTopicProvider);
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: _talkTopicNotifier.talkTopics.map(
                    (topic) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(
                                  int.parse('0xff804B3A'),
                                ),
                                width: 10),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Stack(
                            children: [
                              CustomPaint(
                                painter: CirclePainter(),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(topic.name),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // child: Center(1,2.
                        //   child: Text(topic.name),
                        // ),
                      );
                    },
                  ).toList(),
                ),
              ),
              CountdownTimer(
                endTime: endTime,
                widgetBuilder: (_, CurrentRemainingTime? time) {
                  if (time == null) {
                    return Container();
                  } else {
                    return Text(
                      '${(time.hours == null) ? "00" : time.hours}:${(time.min == null) ? "00" : time.min}:${(time.sec == null) ? "00" : time.sec}',
                    );
                  }
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute(
                  builder: (context) => TalkPage(),
                ),
              );
            },
          ),
        );
      },
    );
  }
  //
  // Widget _buildRow(Animation animation) {
  //   return FadeTransition(
  //     opacity: animation,
  //     child: Transform(
  //       transform: _generateMatrix(animation),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Text('Animation'),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Animation _createAnimation(int delay) {
  //   assert(delay < 10);
  //
  //   final actualDelay = 0.1 * delay;
  //
  //   return Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
  //       parent: _animationController,
  //       curve: Interval(actualDelay, 1.0, curve: Curves.fastOutSlowIn)));
  // }
  //
  // Matrix4 _generateMatrix(Animation animation) {
  //   final value = lerpDouble(30.0, 0, animation.value);
  //   return Matrix4.translationValues(0.0, value, 0.0);
  // }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(
        int.parse('0xffFF934E'),
      );
    canvas.drawCircle(const Offset(20, 30), 10, paint); //左の円
    canvas.drawCircle(const Offset(130, 130), 10, paint); //右の円
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
