import 'package:pop_talk/domain/model/talk_topic.dart';
import 'package:pop_talk/domain/repository/talk_topic.dart';

class FirestoreTalkTopicRepository implements TalkTopicRepository {

  @override
  Future<List<TalkTopic>> getRandom({int limit = 6}) async {
    // TODO(any): 実装
    return [
      TalkTopic(id: '1', name: '夢占いの話'),
      TalkTopic(id: '2', name: '目玉焼きの話'),
      TalkTopic(id: '3', name: 'ご飯派、パン派の話'),
      TalkTopic(id: '4', name: '最近のやってみた話'),
      TalkTopic(id: '5', name: 'おすすめアプリの話'),
      TalkTopic(id: '6', name: '学生時代の話'),
    ];
  }
}
