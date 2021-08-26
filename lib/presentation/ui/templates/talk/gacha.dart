import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/presentation/notifier/talk_topics.dart';

class GachaView extends StatefulWidget {
  @override
  _GachaViewState createState() => _GachaViewState();
}

class _GachaViewState extends State<GachaView> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    final _talkTopicNotifier = context.read(talkTopicProvider);
    final imageWidget = Container(
      width: 150,
      height: 150,
      color: Colors.orange,
    );
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isTapped
              ? ShakeAnimation(
                  onEndAnimation: () async {
                    await _talkTopicNotifier.nextThemes();
                    setState(() {
                      isTapped = false;
                    });
                  },
                  child: imageWidget,
                )
              : imageWidget,
          const SizedBox(
            height: 100,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isTapped = true;
              });
            },
            child: Text(
              'トークテーマを選ぶ',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline2!.fontSize,
              ),
            ),
          ),
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
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward().then((_) => widget.onEndAnimation());
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final offsetAnimation = Tween(begin: 0.0, end: 24.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller)
          ..addStatusListener(
            (status) {
              if (status == AnimationStatus.completed) {
                controller.reverse();
              }
            },
          );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AnimatedBuilder(
          animation: offsetAnimation,
          builder: (buildContext, child) {
            return Container(
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(horizontal: 24.0),
              padding: EdgeInsets.only(
                  left: offsetAnimation.value + 24.0,
                  right: 24.0 - offsetAnimation.value),
              child: widget.child,
            );
          },
        ),
      ],
    );
  }
}
