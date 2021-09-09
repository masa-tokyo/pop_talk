import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pop_talk/domain/model/authed_user.dart';
import 'package:pop_talk/domain/repository/talk_item.dart';
import 'package:pop_talk/presentation/notifier/auth.dart';

class RecordingNotifier extends ChangeNotifier {
  RecordingNotifier({this.repository, this.authedUser});

  final TalkItemRepository? repository;
  final AuthedUser? authedUser;

  Future<void> postRecording({
    required String title,
    required String description,
    required String path,
    required Duration duration,
    required String talkTopicId,
  }) async {
    final durationInt = duration.inSeconds;
    final audioFile = File(path);

    await repository!.postRecording(
        talkTopicId: talkTopicId,
        title: title,
        description: description,
        audioFile: audioFile,
        duration: durationInt,
        createdUserId: authedUser != null ? authedUser!.id : 'unknownUser');
  }

  Future<void> saveDraft({
    required String title,
    required String description,
    required String path,
    required Duration duration,
    required String talkTopicId,
  }) async {
    final durationInt = duration.inSeconds;

    await repository!.saveDraft(
      talkTopicId: talkTopicId,
      title: title,
      description: description,
      localPath: path,
      duration: durationInt,
      createdUserId: authedUser != null ? authedUser!.id : 'unknownUser'
    );

  }
}

final recordingProvider = ChangeNotifierProvider<RecordingNotifier>((ref) {
  final authNotifier = ref.watch(authProvider);
  return RecordingNotifier(
    repository: GetIt.instance.get<TalkItemRepository>(),
    authedUser: authNotifier.currentUser,
  );
});
