import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pop_talk/domain/model/authed_user.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/domain/repository/talk_item.dart';
import 'package:pop_talk/presentation/notifier/auth.dart';

class MyTalkNotifier with ChangeNotifier {
  MyTalkNotifier(this._repository, this._authedUser);

  final AuthedUser _authedUser;
  final TalkItemRepository _repository;

  bool isLoading = false;
  List<TalkItem> savedTalkItems = [];
  List<TalkItem> postedTalkItems = [];

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future<void> init() async {
    startLoading();
    await fetchSavedItems();
    await fetchPostedItems();
    endLoading();
  }

  Future<void> fetchSavedItems() async {
    savedTalkItems = await _repository.fetchSavedItems(_authedUser);
  }

  Future<void> fetchPostedItems() async {
    postedTalkItems = await _repository.fetchPostedItems(_authedUser);
  }

  Future<void> deleteTalkItem({required TalkItem talkItem}) async {
    final localUrl = talkItem.localUrl;
    if (localUrl != null) {
      await File(localUrl).delete();
    }
    savedTalkItems.removeWhere((value) => value.id == talkItem.id);
    postedTalkItems.removeWhere((value) => value.id == talkItem.id);
    await _repository.deleteTalkItem(talkItem);
    notifyListeners();
  }

  Future<void> stopPostingTalk({required TalkItem talkItem}) async {
    await _repository.stopPostingTalk(talkItem);
    await init();
  }

  Future<void> postSavedTalk({required TalkItem talkItem}) async {
    final localUrl = talkItem.localUrl;
    await _repository.postSavedTalk(talkItem);
    if (localUrl != null) {
      await File(localUrl).delete();
    }
    await init();
  }
}

final myTalkProvider = ChangeNotifierProvider.autoDispose<MyTalkNotifier>(
  (ref) {
    final authNotifier = ref.read(authProvider);
    if (authNotifier.currentUser == null) {
      throw ArgumentError('currentUserが作成される前にtalkListProviderを作成できません.');
    }
    return MyTalkNotifier(
      GetIt.instance.get<TalkItemRepository>(),
      authNotifier.currentUser!,
    )..init();
  },
);
