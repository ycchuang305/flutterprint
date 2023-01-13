// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'host.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Host {
  BackendEnv? get backendEnv => throw _privateConstructorUsedError;
  String get localHost => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HostCopyWith<Host> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HostCopyWith<$Res> {
  factory $HostCopyWith(Host value, $Res Function(Host) then) =
      _$HostCopyWithImpl<$Res, Host>;
  @useResult
  $Res call({BackendEnv? backendEnv, String localHost});
}

/// @nodoc
class _$HostCopyWithImpl<$Res, $Val extends Host>
    implements $HostCopyWith<$Res> {
  _$HostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backendEnv = freezed,
    Object? localHost = null,
  }) {
    return _then(_value.copyWith(
      backendEnv: freezed == backendEnv
          ? _value.backendEnv
          : backendEnv // ignore: cast_nullable_to_non_nullable
              as BackendEnv?,
      localHost: null == localHost
          ? _value.localHost
          : localHost // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HostCopyWith<$Res> implements $HostCopyWith<$Res> {
  factory _$$_HostCopyWith(_$_Host value, $Res Function(_$_Host) then) =
      __$$_HostCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BackendEnv? backendEnv, String localHost});
}

/// @nodoc
class __$$_HostCopyWithImpl<$Res> extends _$HostCopyWithImpl<$Res, _$_Host>
    implements _$$_HostCopyWith<$Res> {
  __$$_HostCopyWithImpl(_$_Host _value, $Res Function(_$_Host) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backendEnv = freezed,
    Object? localHost = null,
  }) {
    return _then(_$_Host(
      backendEnv: freezed == backendEnv
          ? _value.backendEnv
          : backendEnv // ignore: cast_nullable_to_non_nullable
              as BackendEnv?,
      localHost: null == localHost
          ? _value.localHost
          : localHost // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Host extends _Host {
  const _$_Host({this.backendEnv, this.localHost = ''}) : super._();

  @override
  final BackendEnv? backendEnv;
  @override
  @JsonKey()
  final String localHost;

  @override
  String toString() {
    return 'Host(backendEnv: $backendEnv, localHost: $localHost)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Host &&
            (identical(other.backendEnv, backendEnv) ||
                other.backendEnv == backendEnv) &&
            (identical(other.localHost, localHost) ||
                other.localHost == localHost));
  }

  @override
  int get hashCode => Object.hash(runtimeType, backendEnv, localHost);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HostCopyWith<_$_Host> get copyWith =>
      __$$_HostCopyWithImpl<_$_Host>(this, _$identity);
}

abstract class _Host extends Host {
  const factory _Host({final BackendEnv? backendEnv, final String localHost}) =
      _$_Host;
  const _Host._() : super._();

  @override
  BackendEnv? get backendEnv;
  @override
  String get localHost;
  @override
  @JsonKey(ignore: true)
  _$$_HostCopyWith<_$_Host> get copyWith => throw _privateConstructorUsedError;
}
