import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pop_talk/domain/model/authed_user.dart';
import 'package:pop_talk/domain/repository/authed_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'authed_user.freezed.dart';

part 'authed_user.g.dart';

class FirestoreAuthedUserRepository implements AuthedUserRepository {
  final _auth = FirebaseAuth.instance;
  final _userCollection = FirebaseFirestore.instance.collection('users');

  final googleSignIn = GoogleSignIn();

  @override
  Future<AuthedUser> implicitLogin() async {
    final firebaseUser =
        _auth.currentUser ?? (await _auth.signInAnonymously()).user;
    if (firebaseUser == null) {
      throw Exception('userの情報が何らかの理由で取得できませんでした.');
    }
    var firestoreUser = await _userCollection.doc(firebaseUser.uid).get();
    if (!firestoreUser.exists) {
      await _userCollection.doc(firebaseUser.uid).set(<String, dynamic>{
        'name': 'ゲストユーザー',
        'photoUrl': RandomPhotoUrl().getRandom(),
        'likeTalkIds': <dynamic>[],
        'followingUserIds': <dynamic>[],
        'followerNumber': 0,
        'likeNumber': 0,
        'blockUserIds': <dynamic>[],
      });
      firestoreUser = await _userCollection.doc(firebaseUser.uid).get();
    }
    return _toAuthedUser(<String, dynamic>{
      'id': firebaseUser.uid,
      'isAnonymous': firebaseUser.isAnonymous,
      ...firestoreUser.data()!,
    });
  }

  @override
  Future<void> likeTalk(AuthedUser user, String talkId) async {
    await _userCollection.doc(user.id).update({
      'likeTalkIds': FieldValue.arrayUnion(<dynamic>[talkId]),
    });
  }

  @override
  Future<void> followUser(AuthedUser user, String userId) async {
    await _userCollection.doc(user.id).update({
      'followingUserIds': FieldValue.arrayUnion(<dynamic>[userId]),
    });
  }

  AuthedUser _toAuthedUser(Map<String, dynamic> json) {
    final firestoreUser = FirestoreAuthedUser.fromJson(json);
    return AuthedUser(
      id: firestoreUser.id,
      name: firestoreUser.name,
      isAnonymous: firestoreUser.isAnonymous,
      followingUserIds: firestoreUser.followingUserIds,
      likeTalkIds: firestoreUser.likeTalkIds,
      followerNumber: firestoreUser.followerNumber,
      likeNumber: firestoreUser.likeNumber,
      photoUrl: firestoreUser.photoUrl,
      blockUserIds: firestoreUser.blockUserIds,
    );
  }

  @override
  Future<AuthedUser?> signUpWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      } else {
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _auth.currentUser!.linkWithCredential(credential);
        return _getFirebaseUser();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'credential-already-in-use') {
        throw PopTalkException('すでにアカウントが存在します');
      }
      // } on FirebaseAuthException {
    }
  }

  @override
  Future<AuthedUser?> signInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      } else {
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _auth.signInWithCredential(credential);
        return _getFirebaseUser();
      }
    } on Exception catch (e) {
      return null;
    }
  }

  @override
  Future<AuthedUser?> signUpWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oAuthProvider = OAuthProvider('apple.com');
      final credential = oAuthProvider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      await _auth.currentUser!.linkWithCredential(credential);
      return _getFirebaseUser();
      // } on FirebaseAuthException catch (e) {
      //   print(e);
      //   return null;
      // }
    } on SignInWithAppleAuthorizationException {
      // if (e.code == 'AuthorizationErrorCode.unknown') {
      //   return null;
      // }
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'credential-already-in-use') {
        throw PopTalkException('すでにアカウントが存在します');
      }
    }
  }

  @override
  Future<AuthedUser?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oAuthProvider = OAuthProvider('apple.com');
      final credential = oAuthProvider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      await _auth.signInWithCredential(credential);
      return _getFirebaseUser();
    } on SignInWithAppleAuthorizationException {
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    return _auth.signOut();
  }

  Future<AuthedUser> _getFirebaseUser() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser == null) {
      throw Exception('userの情報が何らかの理由で取得できませんでした.');
    }
    final firestoreUser = await _userCollection.doc(firebaseUser.uid).get();
    return _toAuthedUser(<String, dynamic>{
      'id': firebaseUser.uid,
      'isAnonymous': firebaseUser.isAnonymous,
      ...firestoreUser.data()!,
    });
  }

  @override
  Future<void> changeUserName(String id, String newName) async {
    await _userCollection.doc(id).update({
      'name': newName,
    });
  }

  @override
  Future<void> blockUser(AuthedUser user, String userId) async {
    await _userCollection.doc(user.id).update({
      'blockUserIds': FieldValue.arrayUnion(<dynamic>[userId]),
    });
  }
}

@freezed
class FirestoreAuthedUser with _$FirestoreAuthedUser {
  const factory FirestoreAuthedUser({
    required String id,
    required String name,
    required bool isAnonymous,
    required List<String> followingUserIds,
    required List<String> likeTalkIds,
    required int followerNumber,
    required int likeNumber,
    required String photoUrl,
    List<String>? blockUserIds,
  }) = _FirestoreAuthedUser;

  factory FirestoreAuthedUser.fromJson(Map<String, dynamic> json) =>
      _$FirestoreAuthedUserFromJson(json);
}

class RandomPhotoUrl {
  final List<String> _urls = [
    '''https://firebasestorage.googleapis.com/v0/b/poptalk-production.appspot.com/o/icon%2FIcon%20%E2%80%93%201.png?alt=media&token=5bdaad63-b7f8-420f-962f-e0f92a1ddfb6''',
    '''https://firebasestorage.googleapis.com/v0/b/poptalk-production.appspot.com/o/icon%2FIcon%20%E2%80%93%202.png?alt=media&token=55bcf401-38d8-432d-aee6-365fcff23d7b''',
    '''https://firebasestorage.googleapis.com/v0/b/poptalk-production.appspot.com/o/icon%2FIcon%20%E2%80%93%203.png?alt=media&token=1eb6647c-7ab3-4eb1-90c1-19394072d259''',
    '''https://firebasestorage.googleapis.com/v0/b/poptalk-production.appspot.com/o/icon%2FIcon%20%E2%80%93%204.png?alt=media&token=d9ab7fa0-fd09-407b-ac61-e0dd819c25fd''',
    '''https://firebasestorage.googleapis.com/v0/b/poptalk-production.appspot.com/o/icon%2FIcon%20%E2%80%93%205.png?alt=media&token=1be6a191-6695-4690-9428-ba38bf7d82d6''',
    '''https://firebasestorage.googleapis.com/v0/b/poptalk-production.appspot.com/o/icon%2FIcon%20%E2%80%93%206.png?alt=media&token=4a53e256-9c5b-4d02-bb2b-421365f71640''',
  ];

  String getRandom() {
    return (_urls..shuffle()).first;
  }
}
