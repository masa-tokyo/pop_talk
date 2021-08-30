import 'dart:io';

import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/domain/repository/talk_item.dart';

final _talkItems = [
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
        id: '5', name: '金子太郎', photoUrl: 'https://picsum.photos/250?image=9'),
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
        id: '8', name: '中尾太郎', photoUrl: 'https://picsum.photos/250?image=9'),
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
        id: '2', name: '矢野太郎', photoUrl: 'https://picsum.photos/250?image=9'),
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
        id: '4', name: '福岡太郎', photoUrl: 'https://picsum.photos/250?image=9'),
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
    isPublic: true,
    likeNumber: 120,
    playNumber: 400,
    createdUser: TalkUser(
        id: '11', name: '原太郎', photoUrl: 'https://picsum.photos/250?image=9'),
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
    isPublic: true,
    likeNumber: 80,
    playNumber: 50,
    createdUser: TalkUser(
        id: '6', name: '山本太郎', photoUrl: 'https://picsum.photos/250?image=9'),
  ),
  TalkItem(
    id: '7',
    localUrl: '',
    url: '',
    topicName: '一番最初の記憶',
    title: '4歳くらい？',
    description: '一番最初の記憶は幼稚園の時にクワガタに指を挟まれて泣いたことです！ちなみにメスでした！',
    duration: 4,
    publishedAt: DateTime(2021, 7, 30, 00, 00),
    createdAt: DateTime(2021, 7, 30, 00, 00),
    colorCode: 0xFFF3C4B4,
    isPublic: true,
    likeNumber: 300,
    playNumber: 900,
    createdUser: TalkUser(
        id: '7', name: '今野太郎', photoUrl: 'https://picsum.photos/250?image=9'),
  ),
  TalkItem(
    id: '8',
    localUrl: '',
    url: '',
    topicName: '1つだけ超能力が手に入るとしたら',
    title: '瞬間移動',
    description: '瞬間移動できたら世界のいろんなところに行ってみたいです！',
    duration: 5,
    publishedAt: DateTime(2021, 7, 30, 00, 00),
    createdAt: DateTime(2021, 7, 30, 00, 00),
    colorCode: 0xFF89D3BC,
    isPublic: true,
    likeNumber: 500,
    playNumber: 1000,
    createdUser: TalkUser(
        id: '12',
        name: 'ジェームス太郎',
        photoUrl: 'https://picsum.photos/250?image=9'),
  ),
];

class DummyTalkItemRepository implements TalkItemRepository {
  @override
  Future<List<TalkItem>> fetchSavedItems() async {
    return _talkItems.where((item) => item.isPublic == false).toList();
  }

  @override
  Future<List<TalkItem>> fetchPostedItems() async {
    return _talkItems.where((item) => item.isPublic == true).toList();
  }

  @override
  Future<List<TalkItem>> fetchRecommendLists() async {
    return _talkItems.toList();
  }

  @override
  Future<List<TalkItem>> fetchByIds(List<String> ids) async {
    return _talkItems.where((item) => ids.contains(item.id)).toList();
  }

  @override
  Future<List<TalkItem>> fetchByCreatedUserIds(
      List<String> createdUserIds) async {
    return _talkItems
        .where((item) => createdUserIds.contains(item.createdUser.id))
        .toList();
  }

  @override
  Future<List<TalkItem>> fetchPlayerLists() {
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
  }) {
    throw UnimplementedError();
  }
}
