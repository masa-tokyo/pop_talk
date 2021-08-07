import 'package:pop_talk/domain/model/talk_item.dart';

abstract class TalkItemRepository {
  Future<List<TalkItem>> fetchSavedItems();
}
