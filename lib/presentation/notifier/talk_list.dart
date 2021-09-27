import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pop_talk/domain/model/authed_user.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/domain/repository/talk_item.dart';
import 'package:pop_talk/domain/service/block_service.dart';
import 'package:pop_talk/presentation/notifier/auth.dart';

class TalkListNotifier with ChangeNotifier {
  TalkListNotifier(
    this._repository,
    this._authedUser,
    this._store,
    this._blockService,
  ) {
    init();
  }

  final AuthedUser _authedUser;
  final TalkItemRepository _repository;
  final _TalkStore _store;
  final BlockService _blockService;

  List<TalkItem>? get recommendLists => _store.recommendLists;
  List<TalkItem>? get followLists => _store.followLists;
  List<TalkItem>? get likeLists => _store.likeLists;

  void init() {
    if (_store.recommendLists != null) {
      _store.recommendLists = _blockService.filterTalks(_store.recommendLists!);
    }
    if (_store.followLists != null) {
      _store.followLists = _blockService.filterTalks(_store.followLists!);
    }
    if (_store.likeLists != null) {
      _store.likeLists = _blockService.filterTalks(_store.likeLists!);
    }
  }

  Future<void> fetchRecommendLists() async {
    _store.recommendLists = _blockService.filterTalks(
      await _repository.fetchRecommendLists(),
    );
    notifyListeners();
  }

  Future<void> fetchFollowLists() async {
    final followUserIds = _authedUser.followingUserIds;
    _store.followLists = _blockService.filterTalks(
      await _repository.fetchByCreatedUserIds(followUserIds),
    );
    notifyListeners();
  }

  Future<void> fetchLikeLists() async {
    final likeTalkIds = _authedUser.likeTalkIds;
    _store.likeLists = _blockService.filterTalks(
      await _repository.fetchByIds(likeTalkIds),
    );
    notifyListeners();
  }
}

class _TalkStore {
  List<TalkItem>? recommendLists;
  List<TalkItem>? followLists;
  List<TalkItem>? likeLists;
}

final _talkStoreProvider = Provider<_TalkStore>((ref) {
  return _TalkStore();
});

final talkListProvider = ChangeNotifierProvider.autoDispose<TalkListNotifier>(
  (ref) {
    final authNotifier = ref.watch(authProvider);
    if (authNotifier.currentUser == null) {
      throw ArgumentError('currentUserが作成される前にtalkListProviderを作成できません.');
    }
    final talkStore = ref.read(_talkStoreProvider);
    return TalkListNotifier(
      GetIt.instance.get<TalkItemRepository>(),
      authNotifier.currentUser!,
      talkStore,
      BlockService(authNotifier.currentUser!),
    );
  },
);
