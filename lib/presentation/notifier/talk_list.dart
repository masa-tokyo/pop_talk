import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pop_talk/domain/model/authed_user.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/domain/repository/talk_item.dart';
import 'package:pop_talk/presentation/notifier/auth.dart';

class TalkListNotifier with ChangeNotifier {
  TalkListNotifier(this._repository, this._authedUser) {
    init();
  }

  final AuthedUser? _authedUser;
  final TalkItemRepository _repository;

  bool isLoading = false;
  List<TalkItem> recommendLists = [];
  List<TalkItem> followLists = [];
  List<TalkItem> likeLists = [];

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
    await fetchRecommendLists();
    await fetchLikeLists();
    await fetchFollowLists();
    endLoading();
  }

  Future<void> fetchRecommendLists() async {
    recommendLists = await _repository.fetchRecommendLists();
  }

  Future<void> fetchFollowLists() async {
    if (_authedUser == null) {
      return;
    }
    final followUserIds = _authedUser!.followUserIds;
    followLists = await _repository.fetchByIds(followUserIds);
  }

  Future<void> fetchLikeLists() async {
    if (_authedUser == null) {
      return;
    }
    final likeTalkIds = _authedUser!.likeTalkIds;
    likeLists = await _repository.fetchByIds(likeTalkIds);
  }
}

final talkListProvider = ChangeNotifierProvider<TalkListNotifier>(
  (ref) {
    final authNotifier = ref.watch(authProvider);
    return TalkListNotifier(
      GetIt.instance.get<TalkItemRepository>(),
      authNotifier.currentUser,
    );
  },
);
