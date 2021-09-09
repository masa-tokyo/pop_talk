import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pop_talk/presentation/ui/molecules/elevated_circle_button_with_icon.dart';

class AfterRecordingPage extends StatelessWidget {
  const AfterRecordingPage({
    required this.onAgainButtonPressed,
    required this.onEditButtonPressed,
    required this.talkTopicName});

  final VoidCallback onAgainButtonPressed;
  final VoidCallback onEditButtonPressed;
  final String talkTopicName;

  @override
  Widget build(BuildContext context) {
    const _currentValue = 0.3;

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
              SizedBox(
                width: 80,
                height: 80,
                child: ElevatedButton(
                    onPressed: () {
                      return;
                    },
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.deepOrangeAccent),
                        shape: MaterialStateProperty.all(const CircleBorder(
                            side: BorderSide(color: Colors.deepOrangeAccent)))),
                    child: const FaIcon( FontAwesomeIcons.play,
                      size: 24,
                    )),
              ),
              const SizedBox(
                height: 24,
              ),
              //todo update the value
              Slider(
                value: _currentValue,
                onChanged: (value) {
                  return;
                },
                activeColor: Colors.deepOrangeAccent,
                inactiveColor: Colors.grey[300],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '2:12',
                      style: TextStyle(
                          fontSize:
                          Theme.of(context).textTheme.headline5!.fontSize),
                    ),
                    Text(
                      '12:02',
                      style: TextStyle(
                          fontSize:
                          Theme.of(context).textTheme.headline5!.fontSize),
                    )
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
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
