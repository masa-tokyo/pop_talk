import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/domain/repository/talk_item.dart';
import 'package:uuid/uuid.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'talk_item.freezed.dart';

part 'talk_item.g.dart';

class FirestoreTalkItemRepository implements TalkItemRepository {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  @override
  Future<List<TalkItem>> fetchSavedItems() async {
    return [
      TalkItem(
        colorCode: 0xFF80C3C5,
        localUrl: '',
        url: '',
        id: '1',
        topicName: '面白かったコト',
        title: '近所のおじさん',
        description: '僕の近所に住んでいるおじさんの話です！クスッと笑えると思うので、一度聴いてみてください。',
        duration: 50,
        createdAt: DateTime(2021, 8, 1, 00, 00),
        publishedAt: DateTime(2021, 8, 1, 00, 00),
        isPublic: false,
        createdUser: TalkUser(
            id: '5',
            name: '金子太郎',
            photoUrl: 'https://picsum.photos/250?image=9'),
      ),
      TalkItem(
        id: '2',
        localUrl: '',
        url: '',
        duration: 60,
        topicName: '最近ハマっているYouTuber',
        title: 'ヒカル',
        description: '最近よく見るYouTuberヒカルさんの話です！',
        publishedAt: DateTime(2021, 7, 30, 00, 00),
        createdAt: DateTime(2021, 7, 30, 00, 00),
        colorCode: 0xFFEFD9A7,
        isPublic: false,
        createdUser: TalkUser(
            id: '8',
            name: '中尾太郎',
            photoUrl: 'https://picsum.photos/250?image=9'),
      ),
      TalkItem(
        id: '3',
        localUrl: '',
        url: '',
        topicName: '後悔していること',
        title: '前歯骨折',
        description: '今でも後悔している話です。前歯は大切にしましょう。',
        duration: 10,
        publishedAt: DateTime(2021, 7, 30, 00, 00),
        createdAt: DateTime(2021, 7, 30, 00, 00),
        colorCode: 0xFFF1BF89,
        isPublic: false,
        createdUser: TalkUser(
            id: '2',
            name: '矢野太郎',
            photoUrl: 'https://picsum.photos/250?image=9'),
      ),
      TalkItem(
        id: '4',
        localUrl: '',
        url: '',
        topicName: '人生最後の晩餐',
        title: '寿司',
        description: '僕は人生最後の食事は寿司を食べると決めています。',
        duration: 2,
        publishedAt: DateTime(2021, 7, 30, 00, 00),
        createdAt: DateTime(2021, 7, 30, 00, 00),
        colorCode: 0xFF9FCF70,
        isPublic: false,
        createdUser: TalkUser(
            id: '4',
            name: '福岡太郎',
            photoUrl: 'https://picsum.photos/250?image=9'),
      ),
      TalkItem(
        id: '5',
        localUrl: '',
        url: '',
        topicName: 'マイブーム',
        title: 'サプリメント',
        description: '僕の最近のマイブームは海外の面白いサプリを取り寄せて効果を試すことです！怪しい薬ではないので安心してください！笑',
        duration: 8,
        publishedAt: DateTime(2021, 7, 30, 00, 00),
        createdAt: DateTime(2021, 7, 30, 00, 00),
        colorCode: 0xFFD77986,
        isPublic: false,
        likeNumber: 120,
        playNumber: 400,
        createdUser: TalkUser(
            id: '11',
            name: '原太郎',
            photoUrl: 'https://picsum.photos/250?image=9'),
      ),
      TalkItem(
        id: '6',
        localUrl: '',
        url: '',
        topicName: '将来の夢',
        title: '逆玉の輿',
        description: '僕の将来の夢は逆玉の輿に乗ることです！誰か乗らせてください！',
        duration: 10,
        publishedAt: DateTime(2021, 7, 30, 00, 00),
        createdAt: DateTime(2021, 7, 30, 00, 00),
        colorCode: 0xFFF4B63A,
        isPublic: false,
        likeNumber: 80,
        playNumber: 50,
        createdUser: TalkUser(
            id: '6',
            name: '山本太郎',
            photoUrl: 'https://picsum.photos/250?image=9'),
      ),
    ];
  }

  @override
  Future<List<TalkItem>> fetchPostedItems() async {
    final talkItems = <TalkItem>[];

    //todo currentUserの投稿除外
    //todo [check] limit()はデータの並び順反映される？
    await _firestore
        .collection('talks')
        .where('isPublic', isEqualTo: true)
        .orderBy('publishedAt', descending: true)
        .limit(50)
        .get()
        .then((value) async {
      //todo [check] 非同期処理なくて大丈夫？ cf.Future.forEach
      value.docs.map((doc) async {
        final firestoreTalk = FirestoreTalk.fromJson(
            <String, dynamic>{'id': doc.id, ...doc.data()});

        //fetch data form talkTopics collection
        final talkTopic = await _firestore
            .collection('talkTopics')
            .doc(firestoreTalk.talkTopicId)
            .get();

        //fetch data form users collection
        final user = await _firestore
            .collection('users')
            .doc(firestoreTalk.createdUserId)
            .get();

        talkItems.add(_toTalkItem(
            talkTopic: talkTopic,
            createdUser: user,
            firestoreTalk: firestoreTalk));
      });
    });

    return talkItems;
  }

  TalkItem _toTalkItem(
      {required DocumentSnapshot<Map<String, dynamic>> talkTopic,
      required DocumentSnapshot<Map<String, dynamic>> createdUser,
      required FirestoreTalk firestoreTalk}) {
    return TalkItem(
        id: firestoreTalk.id,
        topicName: talkTopic['name'].toString(),
        title: firestoreTalk.title,
        description: firestoreTalk.description,
        url: firestoreTalk.url,
        localUrl: firestoreTalk.localUrl,
        duration: firestoreTalk.duration,
        createdAt: firestoreTalk.createdAt,
        publishedAt: firestoreTalk.publishedAt,
        isPublic: firestoreTalk.isPublic,
        colorCode: int.parse(talkTopic['colorCode'].toString()),
        createdUser: TalkUser(
            id: createdUser.id.toString(),
            name: createdUser['name'].toString(),
            photoUrl: createdUser['photoUrl'].toString()));
  }

  @override
  Future<List<TalkItem>> fetchByIds(List<String> ids) {
    throw UnimplementedError();
  }

  @override
  Future<List<TalkItem>> fetchPlayerLists() {
    throw UnimplementedError();
  }

  @override
  Future<List<TalkItem>> fetchRecommendLists() {
    throw UnimplementedError();
  }

  @override
  Future<List<TalkItem>> fetchByCreatedUserIds(List<String> createdUserIds) {
    throw UnimplementedError();
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
    required DateTime createdAt,
    required DateTime publishedAt,
    required bool isPublic,
    required int playNumber,
    required int likeNumber,
  }) = _FirestoreTalk;

  factory FirestoreTalk.fromJson(Map<String, dynamic> json) =>
      _$FirestoreTalkFromJson(json);
}
