import 'package:firebase_auth/firebase_auth.dart';
import 'package:pop_talk/domain/model/authed_user.dart';
import 'package:pop_talk/domain/repository/authed_user.dart';

class FirestoreAuthedUserRepository implements AuthedUserRepository {
  @override
  Future<AuthedUser> implicitLogin() async {
    final firebaseUser = await FirebaseAuth.instance.signInAnonymously();
    return AuthedUser(
      id: firebaseUser.user!.uid,
      name:
          firebaseUser.user!.displayName ?? 'ゲストユーザー${firebaseUser.user!.uid}',
      isAnonymous: firebaseUser.user!.isAnonymous,
      followingUserIds: [],
      likeTalkIds: [],
    );
  }
}
