// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() authenticating,
    required TResult Function() unauthenticated,
    required TResult Function() unknown,
    required TResult Function() authenticated,
    required TResult Function(ApiFailure failure) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? authenticating,
    TResult? Function()? unauthenticated,
    TResult? Function()? unknown,
    TResult? Function()? authenticated,
    TResult? Function(ApiFailure failure)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? authenticating,
    TResult Function()? unauthenticated,
    TResult Function()? unknown,
    TResult Function()? authenticated,
    TResult Function(ApiFailure failure)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Authenticating value) authenticating,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Unknown value) unknown,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Failure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Authenticating value)? authenticating,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Unknown value)? unknown,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Failure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Authenticating value)? authenticating,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Unknown value)? unknown,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_AuthenticatingCopyWith<$Res> {
  factory _$$_AuthenticatingCopyWith(
          _$_Authenticating value, $Res Function(_$_Authenticating) then) =
      __$$_AuthenticatingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_AuthenticatingCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$_Authenticating>
    implements _$$_AuthenticatingCopyWith<$Res> {
  __$$_AuthenticatingCopyWithImpl(
      _$_Authenticating _value, $Res Function(_$_Authenticating) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Authenticating implements _Authenticating {
  const _$_Authenticating();

  @override
  String toString() {
    return 'AuthState.authenticating()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Authenticating);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() authenticating,
    required TResult Function() unauthenticated,
    required TResult Function() unknown,
    required TResult Function() authenticated,
    required TResult Function(ApiFailure failure) failure,
  }) {
    return authenticating();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? authenticating,
    TResult? Function()? unauthenticated,
    TResult? Function()? unknown,
    TResult? Function()? authenticated,
    TResult? Function(ApiFailure failure)? failure,
  }) {
    return authenticating?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? authenticating,
    TResult Function()? unauthenticated,
    TResult Function()? unknown,
    TResult Function()? authenticated,
    TResult Function(ApiFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (authenticating != null) {
      return authenticating();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Authenticating value) authenticating,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Unknown value) unknown,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Failure value) failure,
  }) {
    return authenticating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Authenticating value)? authenticating,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Unknown value)? unknown,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Failure value)? failure,
  }) {
    return authenticating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Authenticating value)? authenticating,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Unknown value)? unknown,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (authenticating != null) {
      return authenticating(this);
    }
    return orElse();
  }
}

abstract class _Authenticating implements AuthState {
  const factory _Authenticating() = _$_Authenticating;
}

/// @nodoc
abstract class _$$_UnauthenticatedCopyWith<$Res> {
  factory _$$_UnauthenticatedCopyWith(
          _$_Unauthenticated value, $Res Function(_$_Unauthenticated) then) =
      __$$_UnauthenticatedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_UnauthenticatedCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$_Unauthenticated>
    implements _$$_UnauthenticatedCopyWith<$Res> {
  __$$_UnauthenticatedCopyWithImpl(
      _$_Unauthenticated _value, $Res Function(_$_Unauthenticated) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Unauthenticated implements _Unauthenticated {
  const _$_Unauthenticated();

  @override
  String toString() {
    return 'AuthState.unauthenticated()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Unauthenticated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() authenticating,
    required TResult Function() unauthenticated,
    required TResult Function() unknown,
    required TResult Function() authenticated,
    required TResult Function(ApiFailure failure) failure,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? authenticating,
    TResult? Function()? unauthenticated,
    TResult? Function()? unknown,
    TResult? Function()? authenticated,
    TResult? Function(ApiFailure failure)? failure,
  }) {
    return unauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? authenticating,
    TResult Function()? unauthenticated,
    TResult Function()? unknown,
    TResult Function()? authenticated,
    TResult Function(ApiFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Authenticating value) authenticating,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Unknown value) unknown,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Failure value) failure,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Authenticating value)? authenticating,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Unknown value)? unknown,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Failure value)? failure,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Authenticating value)? authenticating,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Unknown value)? unknown,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class _Unauthenticated implements AuthState {
  const factory _Unauthenticated() = _$_Unauthenticated;
}

/// @nodoc
abstract class _$$_UnknownCopyWith<$Res> {
  factory _$$_UnknownCopyWith(
          _$_Unknown value, $Res Function(_$_Unknown) then) =
      __$$_UnknownCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_UnknownCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$_Unknown>
    implements _$$_UnknownCopyWith<$Res> {
  __$$_UnknownCopyWithImpl(_$_Unknown _value, $Res Function(_$_Unknown) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Unknown implements _Unknown {
  const _$_Unknown();

  @override
  String toString() {
    return 'AuthState.unknown()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Unknown);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() authenticating,
    required TResult Function() unauthenticated,
    required TResult Function() unknown,
    required TResult Function() authenticated,
    required TResult Function(ApiFailure failure) failure,
  }) {
    return unknown();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? authenticating,
    TResult? Function()? unauthenticated,
    TResult? Function()? unknown,
    TResult? Function()? authenticated,
    TResult? Function(ApiFailure failure)? failure,
  }) {
    return unknown?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? authenticating,
    TResult Function()? unauthenticated,
    TResult Function()? unknown,
    TResult Function()? authenticated,
    TResult Function(ApiFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Authenticating value) authenticating,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Unknown value) unknown,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Failure value) failure,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Authenticating value)? authenticating,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Unknown value)? unknown,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Failure value)? failure,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Authenticating value)? authenticating,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Unknown value)? unknown,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class _Unknown implements AuthState {
  const factory _Unknown() = _$_Unknown;
}

/// @nodoc
abstract class _$$_AuthenticatedCopyWith<$Res> {
  factory _$$_AuthenticatedCopyWith(
          _$_Authenticated value, $Res Function(_$_Authenticated) then) =
      __$$_AuthenticatedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_AuthenticatedCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$_Authenticated>
    implements _$$_AuthenticatedCopyWith<$Res> {
  __$$_AuthenticatedCopyWithImpl(
      _$_Authenticated _value, $Res Function(_$_Authenticated) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Authenticated implements _Authenticated {
  const _$_Authenticated();

  @override
  String toString() {
    return 'AuthState.authenticated()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Authenticated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() authenticating,
    required TResult Function() unauthenticated,
    required TResult Function() unknown,
    required TResult Function() authenticated,
    required TResult Function(ApiFailure failure) failure,
  }) {
    return authenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? authenticating,
    TResult? Function()? unauthenticated,
    TResult? Function()? unknown,
    TResult? Function()? authenticated,
    TResult? Function(ApiFailure failure)? failure,
  }) {
    return authenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? authenticating,
    TResult Function()? unauthenticated,
    TResult Function()? unknown,
    TResult Function()? authenticated,
    TResult Function(ApiFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Authenticating value) authenticating,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Unknown value) unknown,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Failure value) failure,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Authenticating value)? authenticating,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Unknown value)? unknown,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Failure value)? failure,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Authenticating value)? authenticating,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Unknown value)? unknown,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class _Authenticated implements AuthState {
  const factory _Authenticated() = _$_Authenticated;
}

/// @nodoc
abstract class _$$_FailureCopyWith<$Res> {
  factory _$$_FailureCopyWith(
          _$_Failure value, $Res Function(_$_Failure) then) =
      __$$_FailureCopyWithImpl<$Res>;
  @useResult
  $Res call({ApiFailure failure});

  $ApiFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$_FailureCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$_Failure>
    implements _$$_FailureCopyWith<$Res> {
  __$$_FailureCopyWithImpl(_$_Failure _value, $Res Function(_$_Failure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$_Failure(
      null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as ApiFailure,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ApiFailureCopyWith<$Res> get failure {
    return $ApiFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$_Failure implements _Failure {
  const _$_Failure(this.failure);

  @override
  final ApiFailure failure;

  @override
  String toString() {
    return 'AuthState.failure(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Failure &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FailureCopyWith<_$_Failure> get copyWith =>
      __$$_FailureCopyWithImpl<_$_Failure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() authenticating,
    required TResult Function() unauthenticated,
    required TResult Function() unknown,
    required TResult Function() authenticated,
    required TResult Function(ApiFailure failure) failure,
  }) {
    return failure(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? authenticating,
    TResult? Function()? unauthenticated,
    TResult? Function()? unknown,
    TResult? Function()? authenticated,
    TResult? Function(ApiFailure failure)? failure,
  }) {
    return failure?.call(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? authenticating,
    TResult Function()? unauthenticated,
    TResult Function()? unknown,
    TResult Function()? authenticated,
    TResult Function(ApiFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this.failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Authenticating value) authenticating,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Unknown value) unknown,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Failure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Authenticating value)? authenticating,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Unknown value)? unknown,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Failure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Authenticating value)? authenticating,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Unknown value)? unknown,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure implements AuthState {
  const factory _Failure(final ApiFailure failure) = _$_Failure;

  ApiFailure get failure;
  @JsonKey(ignore: true)
  _$$_FailureCopyWith<_$_Failure> get copyWith =>
      throw _privateConstructorUsedError;
}
