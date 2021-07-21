import 'package:pop_talk/domain/model/talk_topic.dart';

abstract class TalkTopicRepository {
  Future<List<TalkTopic>> getRandom({
    int limit = 6,
  });
}
