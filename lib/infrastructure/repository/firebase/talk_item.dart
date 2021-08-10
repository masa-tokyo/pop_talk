import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/domain/repository/talk_item.dart';

class FirestoreTalkItemRepository implements TalkItemRepository {
  @override
  Future<List<TalkItem>> fetchSavedItems() async {
    return [
      TalkItem(
        id: '1',
        talkTopic: '面白かったコト',
        title: '近所のおじさん',
        description: '僕の近所に住んでいるおじさんの話です！クスッと笑えると思うので、一度聴いてみてください。',
        time: 5,
        recordedAt: DateTime(2021, 7, 26, 00, 00),
        colorCode: 0xFF80C3C5,
        isPublic: false,
      ),
      TalkItem(
        id: '2',
        talkTopic: '最近ハマっているYouTuber',
        title: 'ヒカル',
        description: '最近よく見るYouTuberヒカルさんの話です！',
        time: 8,
        recordedAt: DateTime(2021, 7, 28, 00, 00),
        colorCode: 0xFFEFD9A7,
        isPublic: false,
      ),
      TalkItem(
        id: '3',
        talkTopic: '後悔していること',
        title: '前歯骨折',
        description: '今でも後悔している話です。前歯は大切にしましょう。',
        time: 10,
        recordedAt: DateTime(2021, 7, 30, 00, 00),
        colorCode: 0xFFF1BF89,
        isPublic: false,
      ),
      TalkItem(
        id: '4',
        talkTopic: '好きで仕方ないもの',
        title: '寿司',
        description: '僕の好きで仕方ないものの話です。寿司好きの人は必見です！',
        time: 2,
        recordedAt: DateTime(2021, 8, 1, 00, 00),
        colorCode: 0xFF9FCF70,
        isPublic: false,
      ),
    ];
  }

  @override
  Future<List<TalkItem>> fetchPostedItems() async {
    return [
      TalkItem(
        id: '5',
        talkTopic: 'マイブーム',
        title: 'サプリメント',
        description: '僕の最近のマイブームは海外の面白いサプリを取り寄せて効果を試すことです！怪しい薬ではないので安心してください！笑',
        time: 8,
        recordedAt: DateTime(2021, 8, 8, 00, 00),
        colorCode: 0xFFD77986,
        isPublic: true,
        like: 120,
        view: 400,
      ),
      TalkItem(
        id: '6',
        talkTopic: '将来の夢',
        title: '逆玉の輿',
        description: '僕の将来の夢は逆玉の輿に乗ることです！誰か乗らせてください！',
        time: 10,
        recordedAt: DateTime(2021, 8, 6, 00, 00),
        colorCode: 0xFFF4B63A,
        isPublic: true,
        like: 80,
        view: 50,
      ),
      TalkItem(
        id: '7',
        talkTopic: '一番最初の記憶',
        title: '4歳くらい？',
        description: '一番最初の記憶は幼稚園の時にクワガタに指を挟まれて泣いたことです！ちなみにメスでした！',
        time: 4,
        recordedAt: DateTime(2021, 8, 2, 00, 00),
        colorCode: 0xFFF3C4B4,
        isPublic: true,
        like: 300,
        view: 900,
      ),
      TalkItem(
        id: '8',
        talkTopic: '1つだけ超能力が手に入るとしたら',
        title: '瞬間移動',
        description: '瞬間移動できたら世界のいろんなところに行ってみたいです！',
        time: 5,
        recordedAt: DateTime(2021, 7, 30, 00, 00),
        colorCode: 0xFF89D3BC,
        isPublic: true,
        like: 500,
        view: 1000,
      ),
    ];
  }
}
