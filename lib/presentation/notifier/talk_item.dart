import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/domain/repository/talk_item.dart';

class TalkItemNotifier with ChangeNotifier {
  TalkItemNotifier(this._repository) {
    init();
  }

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
    savedTalkItems = await _repository.fetchSavedItems();
  }

  Future<void> fetchPostedItems() async {
    postedTalkItems = await _repository.fetchPostedItems();
  }
}

final talkItemProvider = ChangeNotifierProvider<TalkItemNotifier>(
  (ref) => TalkItemNotifier(
    GetIt.instance.get<TalkItemRepository>(),
  ),
);
