import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pop_talk/presentation/ui/molecules/elevated_circle_button_with_icon.dart';

class DuringRecordingPage extends StatelessWidget {
  const DuringRecordingPage({
    required this.onStopButtonPressed,
    required this.stream,
    required this.talkTopicName});
  final VoidCallback onStopButtonPressed;
  final Stream<RecordingDisposition> stream;
  final String talkTopicName;

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
              Text(talkTopicName,
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
          Column(
            children: [
              StreamBuilder<RecordingDisposition>(
                initialData: RecordingDisposition.zero(),
                stream: stream,
                  builder: (context, snapshot){
                  final txt = snapshot.data!.duration.toString().substring(2,7);
                  return Text(
                    txt,
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodyText1!.fontSize
                    ),
                  );
                  }),
              const SizedBox(
                height: 24,
              ),
              ElevatedCircleButtonWithIcon(
                  icon: const FaIcon(
                    FontAwesomeIcons.stop,
                    size: 40,
                  ),
                  label: '終了する',
                  onPressed: onStopButtonPressed),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.report_problem_rounded,
                    color: Colors.yellow[700],
                    size: 20,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '録音中は画面を閉じないで下さい',
                    style: TextStyle(
                        fontSize:
                        Theme.of(context).textTheme.headline5!.fontSize),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
