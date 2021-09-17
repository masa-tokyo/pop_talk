import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
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
        // TODO(yano): ランダムで画像出すURLにしているがpoptalkで作成したurlを設定する
        'photoUrl':
            'https://i.picsum.photos/id/344/200/300.jpg?hmac=hFZM-uJoRMyNATe_kjGvS2NGGP60jqqP64vpGQ98VAo',
        'likeTalkIds': <dynamic>[],
        'followingUserIds': <dynamic>[],
        'followerNumber': 0,
        'likeNumber': 0,
      });
      firestoreUser = await _userCollection.doc(firebaseUser.uid).get();
    }
    return _toAuthedUser(<String, dynamic>{
      'id': firebaseUser.uid,
      'isAnonymous': firebaseUser.isAnonymous,
      ...firestoreUser.data()!,
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
    );
  }

  @override
  Future signUpWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.currentUser!.linkWithCredential(credential);
      await implicitLogin();
    }
  }

  @override
  Future signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      await implicitLogin();
    }
  }

  @override
  Future signUpWithApple() async {
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
    await implicitLogin();
  }

  @override
  Future signInWithApple() async {
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
    await implicitLogin();
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
  }) = _FirestoreAuthedUser;

  factory FirestoreAuthedUser.fromJson(Map<String, dynamic> json) =>
      _$FirestoreAuthedUserFromJson(json);
}
