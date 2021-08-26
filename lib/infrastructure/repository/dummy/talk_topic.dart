import 'package:pop_talk/domain/model/talk_topic.dart';
import 'package:pop_talk/domain/repository/talk_topic.dart';

final _talkTopics = [
  TalkTopic(id: '1', colorCode: '0xFF80C3C5', name: '夢占いの話'),
  TalkTopic(id: '2', colorCode: '0xFFEFD9A7', name: '目玉焼きの話'),
  TalkTopic(id: '3', colorCode: '0xFFF1BF89', name: 'ご飯派、パン派の話'),
  TalkTopic(id: '4', colorCode: '0xFF9FCF70', name: '最近のやってみた話'),
  TalkTopic(id: '5', colorCode: '0xFFD77986', name: 'おすすめアプリの話'),
  TalkTopic(id: '6', colorCode: '0xFFF4B63A', name: '学生時代の話'),
  TalkTopic(id: '7', colorCode: '0xFFF3C4B4', name: 'ハマったゲームの話'),
  TalkTopic(id: '8', colorCode: '0xFF89D3BC', name: '好きな季節の話'),
  TalkTopic(id: '9', colorCode: '0xFFE3DE90', name: '料理で失敗したの話'),
  TalkTopic(id: '10', colorCode: '0xFF85BAD4', name: '推しの話'),
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
