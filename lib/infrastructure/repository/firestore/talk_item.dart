import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/domain/repository/talk_item.dart';

class FirestoreTalkItemRepository implements TalkItemRepository {
  @override
  Future<List<TalkItem>> fetchSavedItems() async {
    // TODO(MyTalkTeam): 実装
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
}
