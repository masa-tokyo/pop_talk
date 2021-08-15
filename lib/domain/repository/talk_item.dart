import 'package:pop_talk/domain/model/talk_item.dart';

abstract class TalkItemRepository {
  Future<List<TalkItem>> fetchSavedItems();
  Future<List<TalkItem>> fetchPostedItems();
  Future<List<TalkItem>> fetchRecommendLists();
  Future<List<TalkItem>> fetchFollowIds(List<String> followUserIds);
  Future<List<TalkItem>> fetchLikeIds(List<String> ids);
  Future<List<TalkItem>> fetchPlayerLists();
}
