import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/presentation/notifier/talk_topics.dart';
import 'package:pop_talk/presentation/ui/pages/talk/post_recording_screen.dart';

class TalkPage extends StatelessWidget {
  static const routeName = '/talk';

  static const title = '話す';

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, __) {
      final _talkTopicNotifier = watch(talkTopicProvider);
      return Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: _talkTopicNotifier.nextThemes,
              child: Text(
                'トークテーマを選ぶ',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline2!.fontSize,
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: _talkTopicNotifier.talkTopics.map((topic) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () => _openPostRecordingScreen(context, topic.id),
                    child: Card(
                      child: Center(child: Text(topic.name)),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      );
    });
  }

  void _openPostRecordingScreen(BuildContext context, String id) {

    Navigator.push(context, MaterialPageRoute<void>
      (builder: (_) => PostRecordingScreen(talkTopicId: id,)
    ));
  }
}
