import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pop_talk/domain/model/authed_user.dart';
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
    await _repository.signUpWithGoogle();
  }

  Future<void> signInWithGoogle() async {
    await _repository.signInWithGoogle();
  }

  Future<void> signUpWithApple() async {
    await _repository.signUpWithApple();
  }

  Future<void> signInWithApple() async {
    await _repository.signInWithApple();
  }

  Future<void> addLikeTalk() async {}
}

final authProvider = ChangeNotifierProvider<AuthNotifier>(
  (ref) => AuthNotifier(
    GetIt.instance.get<AuthedUserRepository>(),
  ),
);
