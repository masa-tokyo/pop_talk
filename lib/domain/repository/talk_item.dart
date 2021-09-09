import 'dart:io';
import 'package:pop_talk/domain/model/talk_item.dart';

abstract class TalkItemRepository {
  Future<List<TalkItem>> fetchSavedItems();

  Future<List<TalkItem>> fetchPostedItems();

  Future<List<TalkItem>> fetchRecommendLists();

  Future<List<TalkItem>> fetchByIds(List<String> followUserIds);

  Future<List<TalkItem>> fetchByCreatedUserIds(List<String> createdUserIds);

  Future<List<TalkItem>> fetchPlayerLists();

  Future<void> postRecording({
    required String talkTopicId,
    required String title,
    required String description,
    required File audioFile,
    required int duration,
    required String createdUserId,
  });

  Future<void> saveDraft(
  {required String talkTopicId,
  required String title,
  required String description,
  required String localPath,
  required int duration,
  required String createdUserId,}
      );
}
