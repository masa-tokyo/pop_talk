import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pop_talk/domain/model/talk_topic.dart';
import 'package:pop_talk/presentation/ui/molecules/elevated_circle_button_with_icon.dart';
import 'package:pop_talk/presentation/ui/templates/talk/recording_preview_card.dart';

class AfterRecordingPage extends StatelessWidget {
  const AfterRecordingPage({
    required this.onAgainButtonPressed,
    required this.onEditButtonPressed,
    required this.talkTopic,
    required this.path});

  final VoidCallback onAgainButtonPressed;
  final VoidCallback onEditButtonPressed;
  final TalkTopic talkTopic;
  final String path;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 52,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: RecordingPreviewCard(talkTopic: talkTopic, path: path,),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedCircleButtonWithIcon(
                    icon: const FaIcon(
                      FontAwesomeIcons.redoAlt,
                      size: 42,
                    ),
                    label: '撮り直す',
                    onPressed: onAgainButtonPressed),
                ElevatedCircleButtonWithIcon(
                    icon: const FaIcon(
                      FontAwesomeIcons.arrowRight,
                      size: 42,
                    ),
                    label: '編集へ',
                    onPressed: onEditButtonPressed),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
