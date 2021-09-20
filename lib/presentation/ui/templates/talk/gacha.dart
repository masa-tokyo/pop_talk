import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/presentation/notifier/talk_topics.dart';

final imageWidget = Image.asset('assets/images/pop.png');

class GachaView extends StatefulWidget {
  @override
  _GachaViewState createState() => _GachaViewState();
}

class _GachaViewState extends State<GachaView>
    with SingleTickerProviderStateMixin {
  late MediaQueryData _mediaQueryData;
  double? screenWidth;
  double? screenHeight;
  double? blockSizeHorizontal;
  double? blockSizeVertical;

  double? btnSizeHorizontal;
  double? btnSizeVertical;

  bool isTapped = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;

    btnSizeHorizontal = blockSizeHorizontal! * 60; //幅
    btnSizeVertical = blockSizeVertical! * 8; //高

    final _talkTopicNotifier = context.read(talkTopicProvider);
    return Center(
      child: isTapped
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShakeAnimation(
                  onEndAnimation: () async {
                    await _talkTopicNotifier.nextThemes();
                    setState(() {
                      isTapped = false;
                    });
                  },
                  child: imageWidget,
                ),
                SizedBox(
                  width: btnSizeHorizontal,
                  height: btnSizeVertical,
                ),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                imageWidget,
                LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return SizedBox(
                    width: btnSizeHorizontal,
                    height: btnSizeVertical,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        setState(() {
                          isTapped = true;
                        });
                      },
                      child: Text(
                        'トークテーマを選ぶ',
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.headline2!.fontSize,
                        ),
                      ),
                    ),
                  );
                })
              ],
            ),
    );
  }
}

class ShakeAnimation extends StatefulWidget {
  const ShakeAnimation({
    required this.child,
    required this.onEndAnimation,
  });
  final Widget child;
  final void Function() onEndAnimation;

  @override
  _ShakeAnimationState createState() => _ShakeAnimationState();
}

class _ShakeAnimationState extends State<ShakeAnimation>
    with TickerProviderStateMixin {
  late final AnimationController controller;

  int shakeCount = 0;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final offsetAnimation = Tween(
      begin: 0.0,
      end: 24.0,
    )
        .chain(
          CurveTween(curve: Curves.elasticIn),
        )
        .animate(
          controller,
        )..addStatusListener(
            (status) {
              if (shakeCount >= 3) {
                if (shakeCount == 3) {
                  controller.forward().then(
                        (value) => widget.onEndAnimation(),
                      );
                }
                return;
              }
              if (status == AnimationStatus.dismissed) {
                shakeCount++;
                controller.forward();
              }
              if (status == AnimationStatus.completed) {
                controller.reverse();
              }
            },
          );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            AnimatedBuilder(
              animation: offsetAnimation,
              builder: (buildContext, child) {
                if (shakeCount == 1) {
                  return Transform.rotate(
                    angle: math.sin(controller.value * 10 * math.pi) / 60,
                    child: widget.child,
                  );
                } else if (shakeCount == 2) {
                  return Transform.rotate(
                    angle: math.sin(controller.value * 5 * math.pi) / 10,
                    child: widget.child,
                  );
                } else {
                  shakeCount++;
                  return widget.child;
                }
              },
            ),
            AnimatedBuilder(
                animation: offsetAnimation,
                builder: (buildContext, child) {
                  if (shakeCount >= 3) {
                    return Transform.scale(
                      scale: controller.value * 10,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              spreadRadius: 50,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
      ],
    );
  }
}
