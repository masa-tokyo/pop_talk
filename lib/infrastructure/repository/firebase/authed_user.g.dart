// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authed_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FirestoreAuthedUser _$_$_FirestoreAuthedUserFromJson(
    Map<String, dynamic> json) {
  return _$_FirestoreAuthedUser(
    id: json['id'] as String,
    name: json['name'] as String,
    isAnonymous: json['isAnonymous'] as bool,
    followingUserIds: (json['followingUserIds'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    likeTalkIds:
        (json['likeTalkIds'] as List<dynamic>).map((e) => e as String).toList(),
    followerNumber: json['followerNumber'] as int,
    likeNumber: json['likeNumber'] as int,
  );
}

Map<String, dynamic> _$_$_FirestoreAuthedUserToJson(
        _$_FirestoreAuthedUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isAnonymous': instance.isAnonymous,
      'followingUserIds': instance.followingUserIds,
      'likeTalkIds': instance.likeTalkIds,
      'followerNumber': instance.followerNumber,
      'likeNumber': instance.likeNumber,
    };
