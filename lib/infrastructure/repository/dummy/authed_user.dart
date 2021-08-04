import 'package:pop_talk/domain/model/authed_user.dart';
import 'package:pop_talk/domain/repository/authed_user.dart';

class DummyAuthedUserRepository implements AuthedUserRepository {
  @override
  Future<AuthedUser> implicitLogin() async {
    return AuthedUser(
      id: '1',
      name: 'テスト太郎',
      isAnonymous: false,
    );
  }
}
