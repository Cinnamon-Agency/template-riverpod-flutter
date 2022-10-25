// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'api_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ApiError<T> _$ApiErrorFromJson<T>(Map<String, dynamic> json) {
  return _ApiError<T>.fromJson(json);
}

/// @nodoc
mixin _$ApiError<T> {
  @JsonKey(name: 'status_message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'code')
  int? get code => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiErrorCopyWith<T, ApiError<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiErrorCopyWith<T, $Res> {
  factory $ApiErrorCopyWith(
          ApiError<T> value, $Res Function(ApiError<T>) then) =
      _$ApiErrorCopyWithImpl<T, $Res, ApiError<T>>;
  @useResult
  $Res call(
      {@JsonKey(name: 'status_message') String message,
      @JsonKey(name: 'code') int? code});
}

/// @nodoc
class _$ApiErrorCopyWithImpl<T, $Res, $Val extends ApiError<T>>
    implements $ApiErrorCopyWith<T, $Res> {
  _$ApiErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? code = freezed,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ApiErrorCopyWith<T, $Res>
    implements $ApiErrorCopyWith<T, $Res> {
  factory _$$_ApiErrorCopyWith(
          _$_ApiError<T> value, $Res Function(_$_ApiError<T>) then) =
      __$$_ApiErrorCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'status_message') String message,
      @JsonKey(name: 'code') int? code});
}

/// @nodoc
class __$$_ApiErrorCopyWithImpl<T, $Res>
    extends _$ApiErrorCopyWithImpl<T, $Res, _$_ApiError<T>>
    implements _$$_ApiErrorCopyWith<T, $Res> {
  __$$_ApiErrorCopyWithImpl(
      _$_ApiError<T> _value, $Res Function(_$_ApiError<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? code = freezed,
  }) {
    return _then(_$_ApiError<T>(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ApiError<T> implements _ApiError<T> {
  _$_ApiError(
      {@JsonKey(name: 'status_message') required this.message,
      @JsonKey(name: 'code') this.code});

  factory _$_ApiError.fromJson(Map<String, dynamic> json) =>
      _$$_ApiErrorFromJson(json);

  @override
  @JsonKey(name: 'status_message')
  final String message;
  @override
  @JsonKey(name: 'code')
  final int? code;

  @override
  String toString() {
    return 'ApiError<$T>(message: $message, code: $code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ApiError<T> &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message, code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ApiErrorCopyWith<T, _$_ApiError<T>> get copyWith =>
      __$$_ApiErrorCopyWithImpl<T, _$_ApiError<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ApiErrorToJson<T>(
      this,
    );
  }
}

abstract class _ApiError<T> implements ApiError<T> {
  factory _ApiError(
      {@JsonKey(name: 'status_message') required final String message,
      @JsonKey(name: 'code') final int? code}) = _$_ApiError<T>;

  factory _ApiError.fromJson(Map<String, dynamic> json) =
      _$_ApiError<T>.fromJson;

  @override
  @JsonKey(name: 'status_message')
  String get message;
  @override
  @JsonKey(name: 'code')
  int? get code;
  @override
  @JsonKey(ignore: true)
  _$$_ApiErrorCopyWith<T, _$_ApiError<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
