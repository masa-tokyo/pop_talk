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
  List<TalkItem> draftTalkItems = [];
  List<TalkItem> publishTalkItems = [];

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
    draftTalkItems = await _repository.fetchSavedItems(_authedUser);
  }

  Future<void> fetchPostedItems() async {
    publishTalkItems = await _repository.fetchPostedItems(_authedUser);
  }

  Future<void> deleteTalkItem({required TalkItem talkItem}) async {
    final localUrl = talkItem.localUrl;
    if (localUrl != null) {
      await File(localUrl).delete();
    }
    draftTalkItems.removeWhere((value) => value.id == talkItem.id);
    publishTalkItems.removeWhere((value) => value.id == talkItem.id);
    await _repository.deleteTalkItem(talkItem);
    notifyListeners();
  }

  Future<void> draftTalk({required TalkItem talkItem}) async {
    final draftTalkItem =
        publishTalkItems.firstWhere((talk) => talk.id == talkItem.id)..draft();
    draftTalkItems = [...draftTalkItems, draftTalkItem];
    publishTalkItems.removeWhere((talk) => talk.id == talkItem.id);
    await _repository.draftTalk(talkItem);
    notifyListeners();
  }

  Future<void> publishTalk({required TalkItem talkItem}) async {
    final newUrl = await _repository.publishTalk(talkItem);
    final localUrl = talkItem.localUrl;
    final publishTalkItem = draftTalkItems
        .firstWhere((talk) => talk.id == talkItem.id)
      ..publish(newUrl);
    publishTalkItems = [...publishTalkItems, publishTalkItem];
    draftTalkItems.removeWhere((talk) => talk.id == talkItem.id);
    if (localUrl != null) {
      await File(localUrl).delete();
    }
    notifyListeners();
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
