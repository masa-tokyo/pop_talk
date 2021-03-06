import 'dart:io';
import 'package:pop_talk/domain/model/authed_user.dart';
import 'package:pop_talk/domain/model/talk_item.dart';

abstract class TalkItemRepository {
  Future<List<TalkItem>> fetchDraftItems(AuthedUser authedUser);

  Future<List<TalkItem>> fetchPublishItems(AuthedUser authedUser);

  Future<List<TalkItem>> fetchRecommendLists();

  Future<List<TalkItem>> fetchByIds(List<String> followUserIds);

  Future<List<TalkItem>> fetchByCreatedUserIds(List<String> createdUserIds);

  Future<void> postRecording({
    required String talkTopicId,
    required String title,
    required String description,
    required File audioFile,
    required int duration,
    required String createdUserId,
  });

  Future<void> saveDraft({
    required String talkTopicId,
    required String title,
    required String description,
    required String localPath,
    required int duration,
    required String createdUserId,
  });

  Future<void> deleteTalkItem(TalkItem talkItem);

  Future<void> draftTalk(TalkItem talkItem);

  Future<String?> publishTalk(TalkItem talkItem);

  Future<void> editTalk(
    TalkItem talkItem,
    String? newTitle,
    String? newDescription,
  );
}
