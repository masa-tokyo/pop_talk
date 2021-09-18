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
    final result = await Future.wait<QuerySnapshot<Map<String, dynamic>>>([
      _firestore
          .collection('users')
          .where(FieldPath.documentId, whereIn: userIds.toSet().toList())
          .get(),
      _firestore
          .collection('talkTopics')
          .where(FieldPath.documentId, whereIn: topicIds.toSet().toList())
          .get(),
    ]);
    final firestoreUsers = result[0].docs;
    final firestoreTalkTopics = result[1].docs;
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
    // idの検索とorderByを同時に使用することができないので, orderはclient側で行う
    final snapshot = await _firestore
        .collection('talks')
        .where('isPublic', isEqualTo: true)
        .where(FieldPath.documentId, whereIn: ids)
        .get();
    return (await _createTalkItems(snapshot.docs))
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
    final snapshot = await _firestore
        .collection('talks')
        .where('isPublic', isEqualTo: true)
        .where('createdUserId', whereIn: createdUserIds)
        .orderBy('publishedAt', descending: true)
        .get();
    return _createTalkItems(snapshot.docs);
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
  Future<void> deleteTalkItemById(String talkId) async {
    await _firestore.collection('talks').doc(talkId).delete();
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
