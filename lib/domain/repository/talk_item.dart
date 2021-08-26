import 'package:pop_talk/domain/model/talk_item.dart';

abstract class TalkItemRepository {
  Future<List<TalkItem>> fetchSavedItems();
  Future<List<TalkItem>> fetchPostedItems();
  Future<List<TalkItem>> fetchRecommendLists();
  Future<List<TalkItem>> fetchByIds(List<String> followUserIds);
  Future<List<TalkItem>> fetchByCreatedUserIds(List<String> createdUserIds);
  Future<List<TalkItem>> fetchPlayerLists();
}
