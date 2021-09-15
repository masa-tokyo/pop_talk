import 'package:pop_talk/domain/model/authed_user.dart';

abstract class AuthedUserRepository {
  Future<AuthedUser> implicitLogin();
  Future<void> likeTalk(AuthedUser user, String talkId);
  Future<void> followUser(AuthedUser user, String userId);
}
