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

  List<String> urls = <String>[];

  int currentIndex = 0;

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

  Future<List<String>> returnUrls() async{
    recommendLists!.forEach((element) {
      if(element.url == null) {
        ArgumentError('url is null');
      } else {
        urls.add(element.url!);
      }
    });
    return urls;
  }

  Future<void> toNextTalk() async{
    if(currentIndex < recommendLists!.length - 1){
      currentIndex ++;
      notifyListeners();
    }

  }

  Future<void> toPreviousTalk() async{
    if(currentIndex > 0) {
      currentIndex = currentIndex - 1;
      notifyListeners();
    }
  }

  Future<void> updateCurrentIndex(int index) async{
    currentIndex = index;
    notifyListeners();
  }

}

final talkListProvider = ChangeNotifierProvider<TalkListNotifier>(
  (ref) {
    final authNotifier = ref.watch(authProvider);
    if (authNotifier.currentUser == null) {
      throw ArgumentError('currentUserが作成される前にtalkListProviderを作成できません.');
    }
    return TalkListNotifier(
      GetIt.instance.get<TalkItemRepository>(),
      authNotifier.currentUser!,
    );
  },
);
