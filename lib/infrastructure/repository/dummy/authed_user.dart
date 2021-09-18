import 'package:pop_talk/domain/model/authed_user.dart';
import 'package:pop_talk/domain/repository/authed_user.dart';

class DummyAuthedUserRepository implements AuthedUserRepository {
  AuthedUser authedUser = AuthedUser(
    id: '1',
    name: 'テスト太郎',
    isAnonymous: false,
    followingUserIds: ['5', '2', '8'],
    likeTalkIds: ['1', '3', '5', '6'],
    likeNumber: 5,
    followerNumber: 2,
  );

  @override
  Future<AuthedUser> implicitLogin() async {
    return authedUser;
  }

  @override
  Future signUpWithGoogle() async {
    return authedUser;
  }

  @override
  Future signInWithGoogle() async {
    return authedUser;
  }

  @override
  Future signUpWithApple() async {
    return authedUser;
  }

  @override
  Future signInWithApple() async {
    return authedUser;
  }
}
