import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/domain/repository/talk_item.dart';
import 'package:uuid/uuid.dart';

class FirestoreTalkItemRepository implements TalkItemRepository {
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  @override
  Future<List<TalkItem>> fetchSavedItems() async {
    return [
      // TalkItem(
      //   id: '1',
      //   talkTopic: '面白かったコト',
      //   title: '近所のおじさん',
      //   description: '僕の近所に住んでいるおじさんの話です！クスッと笑えると思うので、一度聴いてみてください。',
      //   time: 5,
      //   recordedAt: DateTime(2021, 7, 26, 00, 00),
      //   colorCode: 0xFF80C3C5,
      //   isPublic: false,
      //   createdUser: TalkUser(
      //       id: '1',
      //       name: '金子太郎',
      //       photoUrl: 'https://picsum.photos/250?image=9'),
      // ),
      // TalkItem(
      //   id: '2',
      //   talkTopic: '最近ハマっているYouTuber',
      //   title: 'ヒカル',
      //   description: '最近よく見るYouTuberヒカルさんの話です！',
      //   time: 8,
      //   recordedAt: DateTime(2021, 7, 28, 00, 00),
      //   colorCode: 0xFFEFD9A7,
      //   isPublic: false,
      //   createdUser: TalkUser(
      //       id: '1',
      //       name: '金子太郎',
      //       photoUrl: 'https://picsum.photos/250?image=9'),
      // ),
      // TalkItem(
      //   id: '3',
      //   talkTopic: '後悔していること',
      //   title: '前歯骨折',
      //   description: '今でも後悔している話です。前歯は大切にしましょう。',
      //   time: 10,
      //   recordedAt: DateTime(2021, 7, 30, 00, 00),
      //   colorCode: 0xFFF1BF89,
      //   isPublic: false,
      //   createdUser: TalkUser(
      //       id: '1',
      //       name: '金子太郎',
      //       photoUrl: 'https://picsum.photos/250?image=9'),
      // ),
      // TalkItem(
      //   id: '4',
      //   talkTopic: '好きで仕方ないもの',
      //   title: '寿司',
      //   description: '僕の好きで仕方ないものの話です。寿司好きの人は必見です！',
      //   time: 2,
      //   recordedAt: DateTime(2021, 8, 1, 00, 00),
      //   colorCode: 0xFF9FCF70,
      //   isPublic: false,
      //   createdUser: TalkUser(
      //       id: '1',
      //       name: '金子太郎',
      //       photoUrl: 'https://picsum.photos/250?image=9'),
      // ),
    ];
  }

  @override
  Future<List<TalkItem>> fetchPostedItems() async {
    return [
      //
      // TalkItem(
      //   id: '5',
      //   talkTopic: 'マイブーム',
      //   title: 'サプリメント',
      //   description: '僕の最近のマイブームは海外の面白いサプリを取り寄せて効果を試すことです！怪しい薬ではないので安心してください！笑',
      //   time: 8,
      //   recordedAt: DateTime(2021, 8, 8, 00, 00),
      //   colorCode: 0xFFD77986,
      //   isPublic: true,
      //   like: 120,
      //   view: 400,
      //   createdUser: TalkUser(
      //       id: '1',
      //       name: '金子太郎',
      //       photoUrl: 'https://picsum.photos/250?image=9'),
      // ),
      // TalkItem(
      //   id: '6',
      //   talkTopic: '将来の夢',
      //   title: '逆玉の輿',
      //   description: '僕の将来の夢は逆玉の輿に乗ることです！誰か乗らせてください！',
      //   time: 10,
      //   recordedAt: DateTime(2021, 8, 6, 00, 00),
      //   colorCode: 0xFFF4B63A,
      //   isPublic: true,
      //   like: 80,
      //   view: 50,
      //   createdUser: TalkUser(
      //       id: '1',
      //       name: '金子太郎',
      //       photoUrl: 'https://picsum.photos/250?image=9'),
      // ),
      // TalkItem(
      //   id: '7',
      //   talkTopic: '一番最初の記憶',
      //   title: '4歳くらい？',
      //   description: '一番最初の記憶は幼稚園の時にクワガタに指を挟まれて泣いたことです！ちなみにメスでした！',
      //   time: 4,
      //   recordedAt: DateTime(2021, 8, 2, 00, 00),
      //   colorCode: 0xFFF3C4B4,
      //   isPublic: true,
      //   like: 300,
      //   view: 900,
      //   createdUser: TalkUser(
      //       id: '1',
      //       name: '金子太郎',
      //       photoUrl: 'https://picsum.photos/250?image=9'),
      // ),
      // TalkItem(
      //   id: '8',
      //   talkTopic: '1つだけ超能力が手に入るとしたら',
      //   title: '瞬間移動',
      //   description: '瞬間移動できたら世界のいろんなところに行ってみたいです！',
      //   time: 5,
      //   recordedAt: DateTime(2021, 7, 30, 00, 00),
      //   colorCode: 0xFF89D3BC,
      //   isPublic: true,
      //   like: 500,
      //   view: 1000,
      //   createdUser: TalkUser(
      //       id: '1',
      //       name: '金子太郎',
      //       photoUrl: 'https://picsum.photos/250?image=9'),
      // ),
    ];
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
    await _db.collection('talks').doc(id).set(<String, dynamic>{
      //todo [check] need id?
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
