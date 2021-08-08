import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pop_talk/presentation/ui/molecules/elevated_circle_button_with_icon.dart';

class BeforeRecordingPage extends StatelessWidget {
  const BeforeRecordingPage({required this.onRecordingButtonPressed});

  final VoidCallback onRecordingButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              //todo pass the data of the topic
              Text('最近ハマってるYouTuberは？',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline2!.fontSize,
                  )),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: ElevatedCircleButtonWithIcon(
              icon: const FaIcon(
                FontAwesomeIcons.comments,
                size: 36,
              ),
              label: 'トーク開始',
              onPressed: onRecordingButtonPressed,
            ),
          ),
        ],
      ),
    );

  }
}
