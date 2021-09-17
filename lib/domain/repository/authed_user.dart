import 'package:pop_talk/domain/model/authed_user.dart';

abstract class AuthedUserRepository {
  Future<AuthedUser> implicitLogin();
  Future signUpWithGoogle();
  Future signInWithGoogle();
  Future signUpWithApple();
  Future signInWithApple();
}
