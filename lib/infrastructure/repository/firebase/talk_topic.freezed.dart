// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'talk_topic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FirestoreTalkTopic _$FirestoreTalkTopicFromJson(Map<String, dynamic> json) {
  return _FirestoreTalkTopic.fromJson(json);
}

/// @nodoc
class _$FirestoreTalkTopicTearOff {
  const _$FirestoreTalkTopicTearOff();

  _FirestoreTalkTopic call(
      {required String id, required String name, required String colorCode}) {
    return _FirestoreTalkTopic(
      id: id,
      name: name,
      colorCode: colorCode,
    );
  }

  FirestoreTalkTopic fromJson(Map<String, Object> json) {
    return FirestoreTalkTopic.fromJson(json);
  }
}

/// @nodoc
const $FirestoreTalkTopic = _$FirestoreTalkTopicTearOff();

/// @nodoc
mixin _$FirestoreTalkTopic {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get colorCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirestoreTalkTopicCopyWith<FirestoreTalkTopic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirestoreTalkTopicCopyWith<$Res> {
  factory $FirestoreTalkTopicCopyWith(
          FirestoreTalkTopic value, $Res Function(FirestoreTalkTopic) then) =
      _$FirestoreTalkTopicCopyWithImpl<$Res>;
  $Res call({String id, String name, String colorCode});
}

/// @nodoc
class _$FirestoreTalkTopicCopyWithImpl<$Res>
    implements $FirestoreTalkTopicCopyWith<$Res> {
  _$FirestoreTalkTopicCopyWithImpl(this._value, this._then);

  final FirestoreTalkTopic _value;
  // ignore: unused_field
  final $Res Function(FirestoreTalkTopic) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? colorCode = freezed,
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
      colorCode: colorCode == freezed
          ? _value.colorCode
          : colorCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$FirestoreTalkTopicCopyWith<$Res>
    implements $FirestoreTalkTopicCopyWith<$Res> {
  factory _$FirestoreTalkTopicCopyWith(
          _FirestoreTalkTopic value, $Res Function(_FirestoreTalkTopic) then) =
      __$FirestoreTalkTopicCopyWithImpl<$Res>;
  @override
  $Res call({String id, String name, String colorCode});
}

/// @nodoc
class __$FirestoreTalkTopicCopyWithImpl<$Res>
    extends _$FirestoreTalkTopicCopyWithImpl<$Res>
    implements _$FirestoreTalkTopicCopyWith<$Res> {
  __$FirestoreTalkTopicCopyWithImpl(
      _FirestoreTalkTopic _value, $Res Function(_FirestoreTalkTopic) _then)
      : super(_value, (v) => _then(v as _FirestoreTalkTopic));

  @override
  _FirestoreTalkTopic get _value => super._value as _FirestoreTalkTopic;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? colorCode = freezed,
  }) {
    return _then(_FirestoreTalkTopic(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      colorCode: colorCode == freezed
          ? _value.colorCode
          : colorCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_FirestoreTalkTopic implements _FirestoreTalkTopic {
  const _$_FirestoreTalkTopic(
      {required this.id, required this.name, required this.colorCode});

  factory _$_FirestoreTalkTopic.fromJson(Map<String, dynamic> json) =>
      _$_$_FirestoreTalkTopicFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String colorCode;

  @override
  String toString() {
    return 'FirestoreTalkTopic(id: $id, name: $name, colorCode: $colorCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FirestoreTalkTopic &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.colorCode, colorCode) ||
                const DeepCollectionEquality()
                    .equals(other.colorCode, colorCode)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(colorCode);

  @JsonKey(ignore: true)
  @override
  _$FirestoreTalkTopicCopyWith<_FirestoreTalkTopic> get copyWith =>
      __$FirestoreTalkTopicCopyWithImpl<_FirestoreTalkTopic>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_FirestoreTalkTopicToJson(this);
  }
}

abstract class _FirestoreTalkTopic implements FirestoreTalkTopic {
  const factory _FirestoreTalkTopic(
      {required String id,
      required String name,
      required String colorCode}) = _$_FirestoreTalkTopic;

  factory _FirestoreTalkTopic.fromJson(Map<String, dynamic> json) =
      _$_FirestoreTalkTopic.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get colorCode => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FirestoreTalkTopicCopyWith<_FirestoreTalkTopic> get copyWith =>
      throw _privateConstructorUsedError;
}
