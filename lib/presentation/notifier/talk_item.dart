import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/domain/repository/talk_item.dart';

class TalkItemNotifier with ChangeNotifier {
  TalkItemNotifier(this._repository) {
    fetchSavedItems();
  }

  final TalkItemRepository _repository;

  bool isLoading = false;
  List<TalkItem> talkItems = [];

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchSavedItems() async {
    startLoading();
    talkItems = await _repository.fetchSavedItems();
    endLoading();
  }
}

final talkItemProvider = ChangeNotifierProvider<TalkItemNotifier>(
  (ref) => TalkItemNotifier(
    GetIt.instance.get<TalkItemRepository>(),
  ),
);
