// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talk_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FirestoreTalk _$_$_FirestoreTalkFromJson(Map<String, dynamic> json) {
  return _$_FirestoreTalk(
    id: json['id'] as String,
    createdUserId: json['createdUserId'] as String,
    talkTopicId: json['talkTopicId'] as String,
    title: json['title'] as String?,
    description: json['description'] as String?,
    url: json['url'] as String?,
    localUrl: json['localUrl'] as String?,
    duration: json['duration'] as int,
    createdAt: DateTime.parse(json['createdAt'] as String),
    publishedAt: DateTime.parse(json['publishedAt'] as String),
    isPublic: json['isPublic'] as bool,
    playNumber: json['playNumber'] as int,
    likeNumber: json['likeNumber'] as int,
  );
}

Map<String, dynamic> _$_$_FirestoreTalkToJson(_$_FirestoreTalk instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdUserId': instance.createdUserId,
      'talkTopicId': instance.talkTopicId,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'localUrl': instance.localUrl,
      'duration': instance.duration,
      'createdAt': instance.createdAt.toIso8601String(),
      'publishedAt': instance.publishedAt.toIso8601String(),
      'isPublic': instance.isPublic,
      'playNumber': instance.playNumber,
      'likeNumber': instance.likeNumber,
    };
