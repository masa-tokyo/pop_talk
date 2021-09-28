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
    photoUrl: '',
  );

  @override
  Future<AuthedUser> implicitLogin() async {
    return authedUser;
  }

  @override
  Future<AuthedUser> signUpWithGoogle() async {
    return authedUser;
  }

  @override
  Future<AuthedUser> signInWithGoogle() async {
    return authedUser;
  }

  @override
  Future<AuthedUser> signUpWithApple() async {
    return authedUser;
  }

  @override
  Future<AuthedUser> signInWithApple() async {
    return authedUser;
  }

  @override
  Future<void> signOut() async {
    return;
  }

  @override
  Future<void> likeTalk(AuthedUser user, String talkId) async {
    return;
  }

  @override
  Future<void> followUser(AuthedUser user, String userId) async {
    return;
  }

  @override
  Future<void> changeUserName(String id, String newName) async {
    authedUser.name = newName;
  }

  @override
  Future<void> blockUser(AuthedUser user, String userId) async {
    return;
  }
}
