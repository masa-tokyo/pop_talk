import 'dart:io';

import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pop_talk/domain/model/authed_user.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/domain/repository/talk_item.dart';
import 'package:pop_talk/infrastructure/repository/firebase/timestamp_converter.dart';
import 'package:uuid/uuid.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'talk_item.freezed.dart';

part 'talk_item.g.dart';

class FirestoreTalkItemRepository implements TalkItemRepository {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  @override
  Future<List<TalkItem>> fetchSavedItems(AuthedUser authedUser) async {
    final snapshot = await _firestore
        .collection('talks')
        .where('isPublic', isEqualTo: false)
        .where('createdUserId', isEqualTo: authedUser.id)
        .orderBy('createdAt', descending: true)
        .get();
    return _createTalkItems(snapshot.docs);
  }

  @override
  Future<List<TalkItem>> fetchPostedItems(AuthedUser authedUser) async {
    final snapshot = await _firestore
        .collection('talks')
        .where('isPublic', isEqualTo: true)
        .where('createdUserId', isEqualTo: authedUser.id)
        .orderBy('publishedAt', descending: true)
        .get();
    return _createTalkItems(snapshot.docs);
  }

  TalkItem _toTalkItem({
    required DocumentSnapshot<Map<String, dynamic>> talkTopic,
    required DocumentSnapshot<Map<String, dynamic>> createdUser,
    required FirestoreTalk firestoreTalk,
  }) {
    return TalkItem(
      id: firestoreTalk.id,
      topicName: talkTopic['name'].toString(),
      title: firestoreTalk.title,
      description: firestoreTalk.description,
      url: firestoreTalk.url,
      localUrl: firestoreTalk.localUrl,
      duration: firestoreTalk.duration,
      createdAt: firestoreTalk.createdAt!,
      publishedAt: firestoreTalk.publishedAt,
      isPublic: firestoreTalk.isPublic,
      colorCode: int.parse(talkTopic['colorCode'].toString()),
      createdUser: TalkUser(
        id: createdUser.id.toString(),
        name: createdUser['name'].toString(),
        photoUrl: createdUser['photoUrl'].toString(),
      ),
    );
  }

  Future<List<TalkItem>> _createTalkItems(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> talkDocs,
  ) async {
    final userIds = <String>[];
    final topicIds = <String>[];
    final firestoreTalks = talkDocs.map((doc) {
      final firestoreTalk = FirestoreTalk.fromJson(
        <String, dynamic>{'id': doc.id, ...doc.data()},
      );
      userIds.add(firestoreTalk.createdUserId);
      topicIds.add(firestoreTalk.talkTopicId);
      return firestoreTalk;
    }).toList();
    if (firestoreTalks.isEmpty) {
      return [];
    }
    final firestoreUsers = <QueryDocumentSnapshot<Map<String, dynamic>>>[];
    // whereInで10個以上指定するとエラーが出るのでchunkしてクライアントで合わせる
    (await Future.wait(
      userIds.splitBetweenIndexed((index, _, __) => index % 10 == 0).map(
        (chunkUserIds) {
          return _firestore
              .collection('users')
              .where(
                FieldPath.documentId,
                whereIn: chunkUserIds.toSet().toList(),
              )
              .get();
        },
      ).toList(),
    ))
        .forEach((snapshot) => firestoreUsers.addAll(snapshot.docs));

    final firestoreTalkTopics = <QueryDocumentSnapshot<Map<String, dynamic>>>[];
    (await Future.wait(
      topicIds.splitBetweenIndexed((index, _, __) => index % 10 == 0).map(
        (chunkTopicIds) {
          return _firestore
              .collection('talkTopics')
              .where(
                FieldPath.documentId,
                whereIn: chunkTopicIds.toSet().toList(),
              )
              .get();
        },
      ).toList(),
    ))
        .forEach((snapshot) => firestoreTalkTopics.addAll(snapshot.docs));

    return firestoreTalks
        .map<TalkItem?>((talks) {
          // TODO(yano): 現状対象のuserが見つからないパターンがあるのでそれを除外している必ずuserが作られるようになったら変更したい
          final user = firestoreUsers
              .where((user) => user.id == talks.createdUserId)
              .firstOrNull;
          if (user == null) {
            return null;
          }
          return _toTalkItem(
            talkTopic: firestoreTalkTopics
                .where((topic) => topic.id == talks.talkTopicId)
                .first,
            createdUser: firestoreUsers
                .where((user) => user.id == talks.createdUserId)
                .first,
            firestoreTalk: talks,
          );
        })
        .whereType<TalkItem>()
        .toList();
  }

  @override
  Future<List<TalkItem>> fetchByIds(List<String> ids) async {
    if (ids.isEmpty) {
      return [];
    }
    final documents = <QueryDocumentSnapshot<Map<String, dynamic>>>[];
    // whereInで10個以上指定するとエラーが出るのでchunkしてクライアントで合わせる
    (await Future.wait(
      ids.splitBetweenIndexed((index, _, __) => index % 10 == 0).map(
        (chunkIds) {
          return _firestore
              .collection('talks')
              .where('isPublic', isEqualTo: true)
              .where(FieldPath.documentId, whereIn: chunkIds)
              .get();
        },
      ).toList(),
    ))
        .forEach((snapshot) => documents.addAll(snapshot.docs));

    // idの検索とorderByを同時に使用することができないので, orderはclient側で行う
    return (await _createTalkItems(documents))
      ..sort((a, b) => b.publishedAt!.difference(a.publishedAt!).inSeconds);
  }

  @override
  Future<List<TalkItem>> fetchRecommendLists() async {
    // 現状単純な新着順
    final snapshot = await _firestore
        .collection('talks')
        .where('isPublic', isEqualTo: true)
        .orderBy('publishedAt', descending: true)
        .limit(50)
        .get();
    return _createTalkItems(snapshot.docs);
  }

  @override
  Future<List<TalkItem>> fetchByCreatedUserIds(
    List<String> createdUserIds,
  ) async {
    if (createdUserIds.isEmpty) {
      return [];
    }
    final documents = <QueryDocumentSnapshot<Map<String, dynamic>>>[];
    // whereInで10個以上指定するとエラーが出るのでchunkしてクライアントで合わせる
    (await Future.wait(
      createdUserIds.splitBetweenIndexed((index, _, __) => index % 10 == 0).map(
        (chunkUserIds) {
          return _firestore
              .collection('talks')
              .where('isPublic', isEqualTo: true)
              .where('createdUserId', whereIn: chunkUserIds)
              .get();
        },
      ).toList(),
    ))
        .forEach((snapshot) => documents.addAll(snapshot.docs));
    return (await _createTalkItems(documents))
      ..sort((a, b) => b.publishedAt!.difference(a.publishedAt!).inSeconds);
  }

  @override
  Future<void> postRecording({
    required String talkTopicId,
    required String title,
    required String description,
    required File audioFile,
    required int duration,
    required String createdUserId,
  }) async {
    //upload audioFile to Firebase Storage
    final storagePath = const Uuid().v1();

    final storageRef = _storage.ref().child(storagePath);
    final uploadTask = storageRef.putFile(
        audioFile,
        SettableMetadata(
          //Android側アップロード時に'audio/X-HX-AAC-ADTS'にならないように型指定
          contentType: 'audio/aac',
        ));
    final downloadUrl = await uploadTask
        .then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL());

    final id = const Uuid().v1();
    await _firestore.collection('talks').doc(id).set(<String, dynamic>{
      'talkTopicId': talkTopicId,
      'createdUserId': createdUserId,
      'createdAt': DateTime.now(),
      'publishedAt': DateTime.now(),
      'isPublic': true,
      'title': title,
      'description': description,
      'url': downloadUrl,
      'storagePath': storagePath,
      'localUrl': null,
      'duration': duration,
      'playNumber': 0,
      'likeNumber': 0,
    });
  }

  @override
  Future<void> saveDraft({
    required String talkTopicId,
    required String title,
    required String description,
    required String localPath,
    required int duration,
    required String createdUserId,
  }) async {
    final id = const Uuid().v1();
    await _firestore.collection('talks').doc(id).set(<String, dynamic>{
      'talkTopicId': talkTopicId,
      'createdUserId': createdUserId,
      'createdAt': DateTime.now(),
      'publishedAt': null,
      'isPublic': false,
      'title': title,
      'description': description,
      'url': null,
      'storagePath': null,
      'localUrl': localPath,
      'duration': duration,
      'playNumber': 0,
      'likeNumber': 0,
    });
  }

  @override
  Future<void> deleteTalkItem(TalkItem talkItem) async {
    final url = talkItem.url;
    if (url != null) {
      await _storage.refFromURL(url).delete();
    }
    await _firestore.collection('talks').doc(talkItem.id).delete();
  }

  @override
  Future<void> draftTalk(TalkItem talkItem) async {
    final docRef = _firestore.collection('talks').doc(talkItem.id);

    final newTalk = <String, dynamic>{
      'publishedAt': null,
      'isPublic': false,
    };
    await docRef.update(newTalk);
  }

  @override
  Future<void> publishTalk(TalkItem talkItem) async {
    final url = talkItem.url;
    final docRef = _firestore.collection('talks').doc(talkItem.id);

    if (url == null) {
      final storagePath = const Uuid().v1();

      final storageRef = _storage.ref().child(storagePath);
      final uploadTask = storageRef.putFile(
          File(talkItem.localUrl!),
          SettableMetadata(
            contentType: 'audio/aac',
          ));
      final downloadUrl = await uploadTask
          .then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL());

      final newTalk = <String, dynamic>{
        'publishedAt': DateTime.now(),
        'isPublic': true,
        'url': downloadUrl,
        'storagePath': storagePath,
        'localUrl': null,
      };
      await docRef.update(newTalk);
    } else {
      final newTalk = <String, dynamic>{
        'publishedAt': DateTime.now(),
        'isPublic': true,
      };
      await docRef.update(newTalk);
    }
  }
}

@freezed
class FirestoreTalk with _$FirestoreTalk {
  const factory FirestoreTalk({
    required String id,
    required String createdUserId,
    required String talkTopicId,
    String? title,
    String? description,
    String? url,
    String? localUrl,
    required int duration,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? publishedAt,
    required bool isPublic,
    required int playNumber,
    required int likeNumber,
  }) = _FirestoreTalk;

  factory FirestoreTalk.fromJson(Map<String, dynamic> json) =>
      _$FirestoreTalkFromJson(json);
}
