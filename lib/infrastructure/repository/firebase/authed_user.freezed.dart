// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'authed_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FirestoreAuthedUser _$FirestoreAuthedUserFromJson(Map<String, dynamic> json) {
  return _FirestoreAuthedUser.fromJson(json);
}

/// @nodoc
class _$FirestoreAuthedUserTearOff {
  const _$FirestoreAuthedUserTearOff();

  _FirestoreAuthedUser call(
      {required String id,
      required String name,
      required bool isAnonymous,
      required List<String> followingUserIds,
      required List<String> likeTalkIds,
      required int followerNumber,
      required int likeNumber,
      required String photoUrl,
      List<String>? blockUserIds}) {
    return _FirestoreAuthedUser(
      id: id,
      name: name,
      isAnonymous: isAnonymous,
      followingUserIds: followingUserIds,
      likeTalkIds: likeTalkIds,
      followerNumber: followerNumber,
      likeNumber: likeNumber,
      photoUrl: photoUrl,
      blockUserIds: blockUserIds,
    );
  }

  FirestoreAuthedUser fromJson(Map<String, Object> json) {
    return FirestoreAuthedUser.fromJson(json);
  }
}

/// @nodoc
const $FirestoreAuthedUser = _$FirestoreAuthedUserTearOff();

/// @nodoc
mixin _$FirestoreAuthedUser {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isAnonymous => throw _privateConstructorUsedError;
  List<String> get followingUserIds => throw _privateConstructorUsedError;
  List<String> get likeTalkIds => throw _privateConstructorUsedError;
  int get followerNumber => throw _privateConstructorUsedError;
  int get likeNumber => throw _privateConstructorUsedError;
  String get photoUrl => throw _privateConstructorUsedError;
  List<String>? get blockUserIds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirestoreAuthedUserCopyWith<FirestoreAuthedUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirestoreAuthedUserCopyWith<$Res> {
  factory $FirestoreAuthedUserCopyWith(
          FirestoreAuthedUser value, $Res Function(FirestoreAuthedUser) then) =
      _$FirestoreAuthedUserCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String name,
      bool isAnonymous,
      List<String> followingUserIds,
      List<String> likeTalkIds,
      int followerNumber,
      int likeNumber,
      String photoUrl,
      List<String>? blockUserIds});
}

/// @nodoc
class _$FirestoreAuthedUserCopyWithImpl<$Res>
    implements $FirestoreAuthedUserCopyWith<$Res> {
  _$FirestoreAuthedUserCopyWithImpl(this._value, this._then);

  final FirestoreAuthedUser _value;
  // ignore: unused_field
  final $Res Function(FirestoreAuthedUser) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? isAnonymous = freezed,
    Object? followingUserIds = freezed,
    Object? likeTalkIds = freezed,
    Object? followerNumber = freezed,
    Object? likeNumber = freezed,
    Object? photoUrl = freezed,
    Object? blockUserIds = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isAnonymous: isAnonymous == freezed
          ? _value.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool,
      followingUserIds: followingUserIds == freezed
          ? _value.followingUserIds
          : followingUserIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      likeTalkIds: likeTalkIds == freezed
          ? _value.likeTalkIds
          : likeTalkIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      followerNumber: followerNumber == freezed
          ? _value.followerNumber
          : followerNumber // ignore: cast_nullable_to_non_nullable
              as int,
      likeNumber: likeNumber == freezed
          ? _value.likeNumber
          : likeNumber // ignore: cast_nullable_to_non_nullable
              as int,
      photoUrl: photoUrl == freezed
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      blockUserIds: blockUserIds == freezed
          ? _value.blockUserIds
          : blockUserIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
abstract class _$FirestoreAuthedUserCopyWith<$Res>
    implements $FirestoreAuthedUserCopyWith<$Res> {
  factory _$FirestoreAuthedUserCopyWith(_FirestoreAuthedUser value,
          $Res Function(_FirestoreAuthedUser) then) =
      __$FirestoreAuthedUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String name,
      bool isAnonymous,
      List<String> followingUserIds,
      List<String> likeTalkIds,
      int followerNumber,
      int likeNumber,
      String photoUrl,
      List<String>? blockUserIds});
}

/// @nodoc
class __$FirestoreAuthedUserCopyWithImpl<$Res>
    extends _$FirestoreAuthedUserCopyWithImpl<$Res>
    implements _$FirestoreAuthedUserCopyWith<$Res> {
  __$FirestoreAuthedUserCopyWithImpl(
      _FirestoreAuthedUser _value, $Res Function(_FirestoreAuthedUser) _then)
      : super(_value, (v) => _then(v as _FirestoreAuthedUser));

  @override
  _FirestoreAuthedUser get _value => super._value as _FirestoreAuthedUser;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? isAnonymous = freezed,
    Object? followingUserIds = freezed,
    Object? likeTalkIds = freezed,
    Object? followerNumber = freezed,
    Object? likeNumber = freezed,
    Object? photoUrl = freezed,
    Object? blockUserIds = freezed,
  }) {
    return _then(_FirestoreAuthedUser(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isAnonymous: isAnonymous == freezed
          ? _value.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool,
      followingUserIds: followingUserIds == freezed
          ? _value.followingUserIds
          : followingUserIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      likeTalkIds: likeTalkIds == freezed
          ? _value.likeTalkIds
          : likeTalkIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      followerNumber: followerNumber == freezed
          ? _value.followerNumber
          : followerNumber // ignore: cast_nullable_to_non_nullable
              as int,
      likeNumber: likeNumber == freezed
          ? _value.likeNumber
          : likeNumber // ignore: cast_nullable_to_non_nullable
              as int,
      photoUrl: photoUrl == freezed
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      blockUserIds: blockUserIds == freezed
          ? _value.blockUserIds
          : blockUserIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_FirestoreAuthedUser implements _FirestoreAuthedUser {
  const _$_FirestoreAuthedUser(
      {required this.id,
      required this.name,
      required this.isAnonymous,
      required this.followingUserIds,
      required this.likeTalkIds,
      required this.followerNumber,
      required this.likeNumber,
      required this.photoUrl,
      this.blockUserIds});

  factory _$_FirestoreAuthedUser.fromJson(Map<String, dynamic> json) =>
      _$_$_FirestoreAuthedUserFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final bool isAnonymous;
  @override
  final List<String> followingUserIds;
  @override
  final List<String> likeTalkIds;
  @override
  final int followerNumber;
  @override
  final int likeNumber;
  @override
  final String photoUrl;
  @override
  final List<String>? blockUserIds;

  @override
  String toString() {
    return 'FirestoreAuthedUser(id: $id, name: $name, isAnonymous: $isAnonymous, followingUserIds: $followingUserIds, likeTalkIds: $likeTalkIds, followerNumber: $followerNumber, likeNumber: $likeNumber, photoUrl: $photoUrl, blockUserIds: $blockUserIds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FirestoreAuthedUser &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.isAnonymous, isAnonymous) ||
                const DeepCollectionEquality()
                    .equals(other.isAnonymous, isAnonymous)) &&
            (identical(other.followingUserIds, followingUserIds) ||
                const DeepCollectionEquality()
                    .equals(other.followingUserIds, followingUserIds)) &&
            (identical(other.likeTalkIds, likeTalkIds) ||
                const DeepCollectionEquality()
                    .equals(other.likeTalkIds, likeTalkIds)) &&
            (identical(other.followerNumber, followerNumber) ||
                const DeepCollectionEquality()
                    .equals(other.followerNumber, followerNumber)) &&
            (identical(other.likeNumber, likeNumber) ||
                const DeepCollectionEquality()
                    .equals(other.likeNumber, likeNumber)) &&
            (identical(other.photoUrl, photoUrl) ||
                const DeepCollectionEquality()
                    .equals(other.photoUrl, photoUrl)) &&
            (identical(other.blockUserIds, blockUserIds) ||
                const DeepCollectionEquality()
                    .equals(other.blockUserIds, blockUserIds)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(isAnonymous) ^
      const DeepCollectionEquality().hash(followingUserIds) ^
      const DeepCollectionEquality().hash(likeTalkIds) ^
      const DeepCollectionEquality().hash(followerNumber) ^
      const DeepCollectionEquality().hash(likeNumber) ^
      const DeepCollectionEquality().hash(photoUrl) ^
      const DeepCollectionEquality().hash(blockUserIds);

  @JsonKey(ignore: true)
  @override
  _$FirestoreAuthedUserCopyWith<_FirestoreAuthedUser> get copyWith =>
      __$FirestoreAuthedUserCopyWithImpl<_FirestoreAuthedUser>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_FirestoreAuthedUserToJson(this);
  }
}

abstract class _FirestoreAuthedUser implements FirestoreAuthedUser {
  const factory _FirestoreAuthedUser(
      {required String id,
      required String name,
      required bool isAnonymous,
      required List<String> followingUserIds,
      required List<String> likeTalkIds,
      required int followerNumber,
      required int likeNumber,
      required String photoUrl,
      List<String>? blockUserIds}) = _$_FirestoreAuthedUser;

  factory _FirestoreAuthedUser.fromJson(Map<String, dynamic> json) =
      _$_FirestoreAuthedUser.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  bool get isAnonymous => throw _privateConstructorUsedError;
  @override
  List<String> get followingUserIds => throw _privateConstructorUsedError;
  @override
  List<String> get likeTalkIds => throw _privateConstructorUsedError;
  @override
  int get followerNumber => throw _privateConstructorUsedError;
  @override
  int get likeNumber => throw _privateConstructorUsedError;
  @override
  String get photoUrl => throw _privateConstructorUsedError;
  @override
  List<String>? get blockUserIds => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FirestoreAuthedUserCopyWith<_FirestoreAuthedUser> get copyWith =>
      throw _privateConstructorUsedError;
}
