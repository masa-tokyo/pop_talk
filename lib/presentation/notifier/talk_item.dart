import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pop_talk/domain/model/authed_user.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/domain/repository/talk_item.dart';
import 'package:pop_talk/presentation/notifier/auth.dart';

class TalkItemNotifier with ChangeNotifier {
  TalkItemNotifier(this._repository, this._authedUser) {
    init();
  }

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
}

final talkItemProvider = ChangeNotifierProvider<TalkItemNotifier>(
  (ref) {
    final authNotifier = ref.watch(authProvider);
    if (authNotifier.currentUser == null) {
      throw ArgumentError('currentUserが作成される前にtalkListProviderを作成できません.');
    }
    return TalkItemNotifier(
      GetIt.instance.get<TalkItemRepository>(),
      authNotifier.currentUser!,
    );
  },
);
