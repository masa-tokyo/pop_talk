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

  Future<void> implicitLogin() async {
    currentUser = await _repository.implicitLogin();
    notifyListeners();
  }

  Future<void> signUpWithGoogle() async {
    final googleUser = await _repository.signUpWithGoogle();
    if (googleUser == null) {
      return;
    }
    currentUser = googleUser;
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    final googleUser = await _repository.signInWithGoogle();
    if (googleUser == null) {
      return;
    }
    currentUser = googleUser;
    notifyListeners();
  }

  Future<void> signUpWithApple() async {
    final appleUser = await _repository.signUpWithApple();
    if (appleUser == null) {
      return;
    }
    currentUser = appleUser;
    notifyListeners();
  }

  Future<void> signInWithApple() async {
    final appleUser = await _repository.signInWithApple();
    if (appleUser == null) {
      return;
    }
    currentUser = appleUser;
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
