import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pop_talk/domain/model/authed_user.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/domain/repository/talk_item.dart';
import 'package:pop_talk/presentation/notifier/auth.dart';

class TalkListNotifier with ChangeNotifier {
  TalkListNotifier(this._repository, this._authedUser);

  final AuthedUser _authedUser;
  final TalkItemRepository _repository;

  List<TalkItem>? recommendLists;
  List<TalkItem>? followLists;
  List<TalkItem>? likeLists;

  Future<void> fetchRecommendLists() async {
    recommendLists = await _repository.fetchRecommendLists();
    notifyListeners();
  }

  Future<void> fetchFollowLists() async {
    final followUserIds = _authedUser.followingUserIds;
    followLists = await _repository.fetchByCreatedUserIds(followUserIds);
    notifyListeners();
  }

  Future<void> fetchLikeLists() async {
    final likeTalkIds = _authedUser.likeTalkIds;
    likeLists = await _repository.fetchByIds(likeTalkIds);
    notifyListeners();
  }

}

final talkListProvider = ChangeNotifierProvider<TalkListNotifier>(
  (ref) {
    final authNotifier = ref.read(authProvider);
    if (authNotifier.currentUser == null) {
      throw ArgumentError('currentUserが作成される前にtalkListProviderを作成できません.');
    }
    return TalkListNotifier(
      GetIt.instance.get<TalkItemRepository>(),
      authNotifier.currentUser!,
    );
  },
);
