import 'package:pop_talk/domain/model/authed_user.dart';

abstract class AuthedUserRepository {
  Future<AuthedUser> implicitLogin();
  Future<AuthedUser?> signUpWithGoogle();
  Future<AuthedUser?> signInWithGoogle();
  Future<AuthedUser?> signUpWithApple();
  Future<AuthedUser?> signInWithApple();
  Future<void> likeTalk(AuthedUser user, String talkId);
  Future<void> followUser(AuthedUser user, String userId);
  Future<void> signOut();
  Future<void> changeUserName(String id, String newName);
  Future<void> blockUser(AuthedUser user, String userId);
}

class PopTalkException implements Exception {
  PopTalkException(this.message);
  final String message;
}
