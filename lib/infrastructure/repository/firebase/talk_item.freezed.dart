// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'talk_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FirestoreTalk _$FirestoreTalkFromJson(Map<String, dynamic> json) {
  return _FirestoreTalk.fromJson(json);
}

/// @nodoc
class _$FirestoreTalkTearOff {
  const _$FirestoreTalkTearOff();

  _FirestoreTalk call(
      {required String id,
      required String createdUserId,
      required String talkTopicId,
      String? title,
      String? description,
      String? url,
      String? localUrl,
      required int duration,
      required DateTime createdAt,
      required DateTime publishedAt,
      required bool isPublic,
      required int playNumber,
      required int likeNumber}) {
    return _FirestoreTalk(
      id: id,
      createdUserId: createdUserId,
      talkTopicId: talkTopicId,
      title: title,
      description: description,
      url: url,
      localUrl: localUrl,
      duration: duration,
      createdAt: createdAt,
      publishedAt: publishedAt,
      isPublic: isPublic,
      playNumber: playNumber,
      likeNumber: likeNumber,
    );
  }

  FirestoreTalk fromJson(Map<String, Object> json) {
    return FirestoreTalk.fromJson(json);
  }
}

/// @nodoc
const $FirestoreTalk = _$FirestoreTalkTearOff();

/// @nodoc
mixin _$FirestoreTalk {
  String get id => throw _privateConstructorUsedError;
  String get createdUserId => throw _privateConstructorUsedError;
  String get talkTopicId => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get localUrl => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get publishedAt => throw _privateConstructorUsedError;
  bool get isPublic => throw _privateConstructorUsedError;
  int get playNumber => throw _privateConstructorUsedError;
  int get likeNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirestoreTalkCopyWith<FirestoreTalk> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirestoreTalkCopyWith<$Res> {
  factory $FirestoreTalkCopyWith(
          FirestoreTalk value, $Res Function(FirestoreTalk) then) =
      _$FirestoreTalkCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String createdUserId,
      String talkTopicId,
      String? title,
      String? description,
      String? url,
      String? localUrl,
      int duration,
      DateTime createdAt,
      DateTime publishedAt,
      bool isPublic,
      int playNumber,
      int likeNumber});
}

/// @nodoc
class _$FirestoreTalkCopyWithImpl<$Res>
    implements $FirestoreTalkCopyWith<$Res> {
  _$FirestoreTalkCopyWithImpl(this._value, this._then);

  final FirestoreTalk _value;
  // ignore: unused_field
  final $Res Function(FirestoreTalk) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? createdUserId = freezed,
    Object? talkTopicId = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? url = freezed,
    Object? localUrl = freezed,
    Object? duration = freezed,
    Object? createdAt = freezed,
    Object? publishedAt = freezed,
    Object? isPublic = freezed,
    Object? playNumber = freezed,
    Object? likeNumber = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdUserId: createdUserId == freezed
          ? _value.createdUserId
          : createdUserId // ignore: cast_nullable_to_non_nullable
              as String,
      talkTopicId: talkTopicId == freezed
          ? _value.talkTopicId
          : talkTopicId // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      localUrl: localUrl == freezed
          ? _value.localUrl
          : localUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      publishedAt: publishedAt == freezed
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isPublic: isPublic == freezed
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      playNumber: playNumber == freezed
          ? _value.playNumber
          : playNumber // ignore: cast_nullable_to_non_nullable
              as int,
      likeNumber: likeNumber == freezed
          ? _value.likeNumber
          : likeNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$FirestoreTalkCopyWith<$Res>
    implements $FirestoreTalkCopyWith<$Res> {
  factory _$FirestoreTalkCopyWith(
          _FirestoreTalk value, $Res Function(_FirestoreTalk) then) =
      __$FirestoreTalkCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String createdUserId,
      String talkTopicId,
      String? title,
      String? description,
      String? url,
      String? localUrl,
      int duration,
      DateTime createdAt,
      DateTime publishedAt,
      bool isPublic,
      int playNumber,
      int likeNumber});
}

/// @nodoc
class __$FirestoreTalkCopyWithImpl<$Res>
    extends _$FirestoreTalkCopyWithImpl<$Res>
    implements _$FirestoreTalkCopyWith<$Res> {
  __$FirestoreTalkCopyWithImpl(
      _FirestoreTalk _value, $Res Function(_FirestoreTalk) _then)
      : super(_value, (v) => _then(v as _FirestoreTalk));

  @override
  _FirestoreTalk get _value => super._value as _FirestoreTalk;

  @override
  $Res call({
    Object? id = freezed,
    Object? createdUserId = freezed,
    Object? talkTopicId = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? url = freezed,
    Object? localUrl = freezed,
    Object? duration = freezed,
    Object? createdAt = freezed,
    Object? publishedAt = freezed,
    Object? isPublic = freezed,
    Object? playNumber = freezed,
    Object? likeNumber = freezed,
  }) {
    return _then(_FirestoreTalk(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdUserId: createdUserId == freezed
          ? _value.createdUserId
          : createdUserId // ignore: cast_nullable_to_non_nullable
              as String,
      talkTopicId: talkTopicId == freezed
          ? _value.talkTopicId
          : talkTopicId // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      localUrl: localUrl == freezed
          ? _value.localUrl
          : localUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      publishedAt: publishedAt == freezed
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isPublic: isPublic == freezed
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      playNumber: playNumber == freezed
          ? _value.playNumber
          : playNumber // ignore: cast_nullable_to_non_nullable
              as int,
      likeNumber: likeNumber == freezed
          ? _value.likeNumber
          : likeNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_FirestoreTalk with DiagnosticableTreeMixin implements _FirestoreTalk {
  const _$_FirestoreTalk(
      {required this.id,
      required this.createdUserId,
      required this.talkTopicId,
      this.title,
      this.description,
      this.url,
      this.localUrl,
      required this.duration,
      required this.createdAt,
      required this.publishedAt,
      required this.isPublic,
      required this.playNumber,
      required this.likeNumber});

  factory _$_FirestoreTalk.fromJson(Map<String, dynamic> json) =>
      _$_$_FirestoreTalkFromJson(json);

  @override
  final String id;
  @override
  final String createdUserId;
  @override
  final String talkTopicId;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? url;
  @override
  final String? localUrl;
  @override
  final int duration;
  @override
  final DateTime createdAt;
  @override
  final DateTime publishedAt;
  @override
  final bool isPublic;
  @override
  final int playNumber;
  @override
  final int likeNumber;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FirestoreTalk(id: $id, createdUserId: $createdUserId, talkTopicId: $talkTopicId, title: $title, description: $description, url: $url, localUrl: $localUrl, duration: $duration, createdAt: $createdAt, publishedAt: $publishedAt, isPublic: $isPublic, playNumber: $playNumber, likeNumber: $likeNumber)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FirestoreTalk'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('createdUserId', createdUserId))
      ..add(DiagnosticsProperty('talkTopicId', talkTopicId))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('url', url))
      ..add(DiagnosticsProperty('localUrl', localUrl))
      ..add(DiagnosticsProperty('duration', duration))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('publishedAt', publishedAt))
      ..add(DiagnosticsProperty('isPublic', isPublic))
      ..add(DiagnosticsProperty('playNumber', playNumber))
      ..add(DiagnosticsProperty('likeNumber', likeNumber));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FirestoreTalk &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.createdUserId, createdUserId) ||
                const DeepCollectionEquality()
                    .equals(other.createdUserId, createdUserId)) &&
            (identical(other.talkTopicId, talkTopicId) ||
                const DeepCollectionEquality()
                    .equals(other.talkTopicId, talkTopicId)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.localUrl, localUrl) ||
                const DeepCollectionEquality()
                    .equals(other.localUrl, localUrl)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality()
                    .equals(other.duration, duration)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.publishedAt, publishedAt) ||
                const DeepCollectionEquality()
                    .equals(other.publishedAt, publishedAt)) &&
            (identical(other.isPublic, isPublic) ||
                const DeepCollectionEquality()
                    .equals(other.isPublic, isPublic)) &&
            (identical(other.playNumber, playNumber) ||
                const DeepCollectionEquality()
                    .equals(other.playNumber, playNumber)) &&
            (identical(other.likeNumber, likeNumber) ||
                const DeepCollectionEquality()
                    .equals(other.likeNumber, likeNumber)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdUserId) ^
      const DeepCollectionEquality().hash(talkTopicId) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(localUrl) ^
      const DeepCollectionEquality().hash(duration) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(publishedAt) ^
      const DeepCollectionEquality().hash(isPublic) ^
      const DeepCollectionEquality().hash(playNumber) ^
      const DeepCollectionEquality().hash(likeNumber);

  @JsonKey(ignore: true)
  @override
  _$FirestoreTalkCopyWith<_FirestoreTalk> get copyWith =>
      __$FirestoreTalkCopyWithImpl<_FirestoreTalk>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_FirestoreTalkToJson(this);
  }
}

abstract class _FirestoreTalk implements FirestoreTalk {
  const factory _FirestoreTalk(
      {required String id,
      required String createdUserId,
      required String talkTopicId,
      String? title,
      String? description,
      String? url,
      String? localUrl,
      required int duration,
      required DateTime createdAt,
      required DateTime publishedAt,
      required bool isPublic,
      required int playNumber,
      required int likeNumber}) = _$_FirestoreTalk;

  factory _FirestoreTalk.fromJson(Map<String, dynamic> json) =
      _$_FirestoreTalk.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get createdUserId => throw _privateConstructorUsedError;
  @override
  String get talkTopicId => throw _privateConstructorUsedError;
  @override
  String? get title => throw _privateConstructorUsedError;
  @override
  String? get description => throw _privateConstructorUsedError;
  @override
  String? get url => throw _privateConstructorUsedError;
  @override
  String? get localUrl => throw _privateConstructorUsedError;
  @override
  int get duration => throw _privateConstructorUsedError;
  @override
  DateTime get createdAt => throw _privateConstructorUsedError;
  @override
  DateTime get publishedAt => throw _privateConstructorUsedError;
  @override
  bool get isPublic => throw _privateConstructorUsedError;
  @override
  int get playNumber => throw _privateConstructorUsedError;
  @override
  int get likeNumber => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FirestoreTalkCopyWith<_FirestoreTalk> get copyWith =>
      throw _privateConstructorUsedError;
}
