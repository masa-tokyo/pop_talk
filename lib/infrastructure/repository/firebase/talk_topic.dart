import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pop_talk/domain/model/talk_topic.dart';
import 'package:pop_talk/domain/repository/talk_topic.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'talk_topic.freezed.dart';
part 'talk_topic.g.dart';

class FirestoreTalkTopicRepository implements TalkTopicRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<TalkTopic>> getRandom({int limit = 6}) async {
    // TODO(any): この方法だとテーマが固定の50個からランダムに選ばれてしまうのでテーマが50個超えた場合は別の方法でランダムに取得する
    // @see https://stackoverflow.com/questions/46798981/firestore-how-to-get-random-documents-in-a-collection
    const firestoreLimit = 50;

    final snapshot =
        await firestore.collection('talkTopics').limit(firestoreLimit).get();
    final documents = snapshot.docs..shuffle();
    return documents.take(limit).map((doc) {
      return _firestoreToModel(
        FirestoreTalkTopic.fromJson(
          <String, dynamic>{'id': doc.id, ...doc.data()},
        ),
      );
    }).toList();
  }

  TalkTopic _firestoreToModel(FirestoreTalkTopic firestore) {
    return TalkTopic(
      id: firestore.id,
      name: firestore.name,
      colorCode: int.parse(firestore.colorCode),
    );
  }
}

@freezed
class FirestoreTalkTopic with _$FirestoreTalkTopic {
  const factory FirestoreTalkTopic({
    required String id,
    required String name,
    required String colorCode,
  }) = _FirestoreTalkTopic;

  factory FirestoreTalkTopic.fromJson(Map<String, dynamic> json) =>
      _$FirestoreTalkTopicFromJson(json);
}
