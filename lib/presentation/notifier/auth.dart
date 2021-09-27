import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pop_talk/domain/model/authed_user.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/domain/repository/authed_user.dart';
import 'package:pop_talk/infrastructure/tracking.dart';

class AuthNotifier with ChangeNotifier {
  AuthNotifier(this._repository);

  final AuthedUserRepository _repository;

  AuthedUser? currentUser;
  String? errorMessage;

  Future<void> implicitLogin() async {
    currentUser = await _repository.implicitLogin();
    await Tracking().setUserId(currentUser!.id);
    notifyListeners();
  }

  Future<bool> signUpWithGoogle() async {
    try {
      final googleUser = await _repository.signUpWithGoogle();
      if (googleUser == null) {
        return false;
      }
      currentUser = googleUser;
      notifyListeners();
    } on PopTalkException catch (e) {
      errorMessage = e.message;
      notifyListeners();
      return false;
    }
    Tracking().logEvent(eventType: EventType.signUp);
    return true;
  }

  Future<bool> signInWithGoogle() async {
    try {
      final googleUser = await _repository.signInWithGoogle();
      if (googleUser == null) {
        return false;
      }
      currentUser = googleUser;
      notifyListeners();
    } on PopTalkException catch (e) {
      errorMessage = e.message;
      notifyListeners();
      return false;
    }
    await Tracking().setUserId(currentUser!.id);
    return true;
  }

  Future<bool> signUpWithApple() async {
    try {
      final appleUser = await _repository.signUpWithApple();
      if (appleUser == null) {
        return false;
      }
      currentUser = appleUser;
      notifyListeners();
    } on PopTalkException catch (e) {
      errorMessage = e.message;
      notifyListeners();
      return false;
    }
    Tracking().logEvent(eventType: EventType.signUp);
    return true;
  }

  Future<bool> signInWithApple() async {
    try {
      final appleUser = await _repository.signUpWithApple();
      if (appleUser == null) {
        return false;
      }
      currentUser = appleUser;
      notifyListeners();
    } on PopTalkException catch (e) {
      errorMessage = e.message;
      notifyListeners();
      return false;
    }
    await Tracking().setUserId(currentUser!.id);
    return true;
  }

  Future<void> signOut() async {
    // 今のところ、UIで使用しない
    await _repository.signOut();
    currentUser = await _repository.implicitLogin();
    notifyListeners();
  }

  Future<void> likeTalk(TalkItem talk) async {
    if (currentUser == null) {
      return;
    }
    currentUser!.likeTalk(talk.id);
    await _repository.likeTalk(currentUser!, talk.id);
    Tracking().logEvent(eventType: EventType.likeTalk);
    notifyListeners();
  }

  Future<void> followUser(TalkUser user) async {
    if (currentUser == null) {
      return;
    }
    currentUser!.followUser(user.id);
    await _repository.followUser(currentUser!, user.id);
    Tracking().logEvent(eventType: EventType.followUser);
    notifyListeners();
  }

  Future<void> changeUserName(AuthedUser authedUser, String newName) async {
    authedUser.changeUserName(newName);
    await _repository.changeUserName(authedUser.id, newName);
    notifyListeners();
  }

  Future<void> blockUser(String userId) async {
    currentUser!.blockUser(userId);
    await _repository.blockUser(currentUser!, userId);
    notifyListeners();
  }

}

final authProvider = ChangeNotifierProvider<AuthNotifier>(
  (ref) => AuthNotifier(
    GetIt.instance.get<AuthedUserRepository>(),
  ),
);
