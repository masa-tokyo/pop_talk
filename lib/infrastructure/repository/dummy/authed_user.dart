import 'package:pop_talk/domain/model/authed_user.dart';
import 'package:pop_talk/domain/repository/authed_user.dart';

class DummyAuthedUserRepository implements AuthedUserRepository {
  @override
  Future<AuthedUser> implicitLogin() async {
    return AuthedUser(
      id: '1',
      name: 'テスト太郎',
      isAnonymous: false,
      followingUserIds: ['5', '2', '8'],
      likeTalkIds: ['1', '3', '5', '6'],
      likeNumber: 5,
      followerNumber: 2,
    );
  }

  @override
  Future<void> likeTalk(AuthedUser user, String talkId) async {
    return;
  }

  @override
  Future<void> followUser(AuthedUser user, String userId) async {
    return;
  }

}
