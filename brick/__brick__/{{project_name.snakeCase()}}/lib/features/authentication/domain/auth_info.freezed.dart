// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthInfo {
  String get accessToken => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthInfoCopyWith<AuthInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthInfoCopyWith<$Res> {
  factory $AuthInfoCopyWith(AuthInfo value, $Res Function(AuthInfo) then) =
      _$AuthInfoCopyWithImpl<$Res, AuthInfo>;
  @useResult
  $Res call({String accessToken});
}

/// @nodoc
class _$AuthInfoCopyWithImpl<$Res, $Val extends AuthInfo>
    implements $AuthInfoCopyWith<$Res> {
  _$AuthInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
  }) {
    return _then(_value.copyWith(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AuthInfoCopyWith<$Res> implements $AuthInfoCopyWith<$Res> {
  factory _$$_AuthInfoCopyWith(
          _$_AuthInfo value, $Res Function(_$_AuthInfo) then) =
      __$$_AuthInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String accessToken});
}

/// @nodoc
class __$$_AuthInfoCopyWithImpl<$Res>
    extends _$AuthInfoCopyWithImpl<$Res, _$_AuthInfo>
    implements _$$_AuthInfoCopyWith<$Res> {
  __$$_AuthInfoCopyWithImpl(
      _$_AuthInfo _value, $Res Function(_$_AuthInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
  }) {
    return _then(_$_AuthInfo(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AuthInfo extends _AuthInfo {
  const _$_AuthInfo({required this.accessToken}) : super._();

  @override
  final String accessToken;

  @override
  String toString() {
    return 'AuthInfo(accessToken: $accessToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthInfo &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accessToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthInfoCopyWith<_$_AuthInfo> get copyWith =>
      __$$_AuthInfoCopyWithImpl<_$_AuthInfo>(this, _$identity);
}

abstract class _AuthInfo extends AuthInfo {
  const factory _AuthInfo({required final String accessToken}) = _$_AuthInfo;
  const _AuthInfo._() : super._();

  @override
  String get accessToken;
  @override
  @JsonKey(ignore: true)
  _$$_AuthInfoCopyWith<_$_AuthInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
