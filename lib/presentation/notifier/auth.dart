import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pop_talk/domain/model/authed_user.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/domain/repository/authed_user.dart';

class AuthNotifier with ChangeNotifier {
  AuthNotifier(this._repository);

  final AuthedUserRepository _repository;

  AuthedUser? currentUser;
  String errorMessage = '';

  Future<void> implicitLogin() async {
    currentUser = await _repository.implicitLogin();
    notifyListeners();
  }

  Future<bool> signUpWithGoogle() async {
    final googleUser = await _repository.signUpWithGoogle();
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
    notifyListeners();
  }

  Future<void> followUser(TalkUser user) async {
    if (currentUser == null) {
      return;
    }
    currentUser!.followUser(user.id);
    await _repository.followUser(currentUser!, user.id);
    notifyListeners();
  }
}

final authProvider = ChangeNotifierProvider<AuthNotifier>(
  (ref) => AuthNotifier(
    GetIt.instance.get<AuthedUserRepository>(),
  ),
);
