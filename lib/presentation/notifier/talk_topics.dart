import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pop_talk/domain/model/talk_topic.dart';
import 'package:pop_talk/domain/repository/talk_topic.dart';

class TalkTopicNotifier with ChangeNotifier {
  TalkTopicNotifier(this._repository);

  final TalkTopicRepository _repository;

  List<TalkTopic> talkTopics = [];

  Future<void> nextThemes() async {
    // TODO(any): talkThemesがあるけどトークが終わってない等条件を満たしてない場合はテーマを作り直せないようにする
    talkTopics = await _repository.getRandom();
    notifyListeners();
  }
}

final talkTopicProvider = ChangeNotifierProvider<TalkTopicNotifier>(
  (ref) => TalkTopicNotifier(
    GetIt.instance.get<TalkTopicRepository>(),
  ),
);
