import 'package:pop_talk/domain/model/talk_topic.dart';
import 'package:pop_talk/domain/repository/talk_topic.dart';

final _talkTopics = [
  TalkTopic(id: '1', name: '夢占いの話'),
  TalkTopic(id: '2', name: '目玉焼きの話'),
  TalkTopic(id: '3', name: 'ご飯派、パン派の話'),
  TalkTopic(id: '4', name: '最近のやってみた話'),
  TalkTopic(id: '5', name: 'おすすめアプリの話'),
  TalkTopic(id: '6', name: '学生時代の話'),
  TalkTopic(id: '7', name: 'ハマったゲームの話'),
  TalkTopic(id: '8', name: '好きな季節の話'),
  TalkTopic(id: '9', name: '料理で失敗したの話'),
  TalkTopic(id: '10', name: '推しの話'),
];

class DummyTalkTopicRepository implements TalkTopicRepository {
  @override
  Future<List<TalkTopic>> getRandom({
    int limit = 6,
  }) async {
    _talkTopics.shuffle();
    return _talkTopics.take(limit).toList();
  }
}
