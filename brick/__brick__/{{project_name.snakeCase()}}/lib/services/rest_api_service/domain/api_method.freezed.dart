// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_method.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ApiMethod {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() get,
    required TResult Function() post,
    required TResult Function() put,
    required TResult Function() patch,
    required TResult Function() delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? get,
    TResult? Function()? post,
    TResult? Function()? put,
    TResult? Function()? patch,
    TResult? Function()? delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? get,
    TResult Function()? post,
    TResult Function()? put,
    TResult Function()? patch,
    TResult Function()? delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Get value) get,
    required TResult Function(_Post value) post,
    required TResult Function(_Put value) put,
    required TResult Function(_Patch value) patch,
    required TResult Function(_Delete value) delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Get value)? get,
    TResult? Function(_Post value)? post,
    TResult? Function(_Put value)? put,
    TResult? Function(_Patch value)? patch,
    TResult? Function(_Delete value)? delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Get value)? get,
    TResult Function(_Post value)? post,
    TResult Function(_Put value)? put,
    TResult Function(_Patch value)? patch,
    TResult Function(_Delete value)? delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiMethodCopyWith<$Res> {
  factory $ApiMethodCopyWith(ApiMethod value, $Res Function(ApiMethod) then) =
      _$ApiMethodCopyWithImpl<$Res, ApiMethod>;
}

/// @nodoc
class _$ApiMethodCopyWithImpl<$Res, $Val extends ApiMethod>
    implements $ApiMethodCopyWith<$Res> {
  _$ApiMethodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_GetCopyWith<$Res> {
  factory _$$_GetCopyWith(_$_Get value, $Res Function(_$_Get) then) =
      __$$_GetCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_GetCopyWithImpl<$Res> extends _$ApiMethodCopyWithImpl<$Res, _$_Get>
    implements _$$_GetCopyWith<$Res> {
  __$$_GetCopyWithImpl(_$_Get _value, $Res Function(_$_Get) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Get implements _Get {
  const _$_Get();

  @override
  String toString() {
    return 'ApiMethod.get()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Get);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() get,
    required TResult Function() post,
    required TResult Function() put,
    required TResult Function() patch,
    required TResult Function() delete,
  }) {
    return get();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? get,
    TResult? Function()? post,
    TResult? Function()? put,
    TResult? Function()? patch,
    TResult? Function()? delete,
  }) {
    return get?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? get,
    TResult Function()? post,
    TResult Function()? put,
    TResult Function()? patch,
    TResult Function()? delete,
    required TResult orElse(),
  }) {
    if (get != null) {
      return get();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Get value) get,
    required TResult Function(_Post value) post,
    required TResult Function(_Put value) put,
    required TResult Function(_Patch value) patch,
    required TResult Function(_Delete value) delete,
  }) {
    return get(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Get value)? get,
    TResult? Function(_Post value)? post,
    TResult? Function(_Put value)? put,
    TResult? Function(_Patch value)? patch,
    TResult? Function(_Delete value)? delete,
  }) {
    return get?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Get value)? get,
    TResult Function(_Post value)? post,
    TResult Function(_Put value)? put,
    TResult Function(_Patch value)? patch,
    TResult Function(_Delete value)? delete,
    required TResult orElse(),
  }) {
    if (get != null) {
      return get(this);
    }
    return orElse();
  }
}

abstract class _Get implements ApiMethod {
  const factory _Get() = _$_Get;
}

/// @nodoc
abstract class _$$_PostCopyWith<$Res> {
  factory _$$_PostCopyWith(_$_Post value, $Res Function(_$_Post) then) =
      __$$_PostCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_PostCopyWithImpl<$Res> extends _$ApiMethodCopyWithImpl<$Res, _$_Post>
    implements _$$_PostCopyWith<$Res> {
  __$$_PostCopyWithImpl(_$_Post _value, $Res Function(_$_Post) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Post implements _Post {
  const _$_Post();

  @override
  String toString() {
    return 'ApiMethod.post()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Post);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() get,
    required TResult Function() post,
    required TResult Function() put,
    required TResult Function() patch,
    required TResult Function() delete,
  }) {
    return post();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? get,
    TResult? Function()? post,
    TResult? Function()? put,
    TResult? Function()? patch,
    TResult? Function()? delete,
  }) {
    return post?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? get,
    TResult Function()? post,
    TResult Function()? put,
    TResult Function()? patch,
    TResult Function()? delete,
    required TResult orElse(),
  }) {
    if (post != null) {
      return post();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Get value) get,
    required TResult Function(_Post value) post,
    required TResult Function(_Put value) put,
    required TResult Function(_Patch value) patch,
    required TResult Function(_Delete value) delete,
  }) {
    return post(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Get value)? get,
    TResult? Function(_Post value)? post,
    TResult? Function(_Put value)? put,
    TResult? Function(_Patch value)? patch,
    TResult? Function(_Delete value)? delete,
  }) {
    return post?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Get value)? get,
    TResult Function(_Post value)? post,
    TResult Function(_Put value)? put,
    TResult Function(_Patch value)? patch,
    TResult Function(_Delete value)? delete,
    required TResult orElse(),
  }) {
    if (post != null) {
      return post(this);
    }
    return orElse();
  }
}

abstract class _Post implements ApiMethod {
  const factory _Post() = _$_Post;
}

/// @nodoc
abstract class _$$_PutCopyWith<$Res> {
  factory _$$_PutCopyWith(_$_Put value, $Res Function(_$_Put) then) =
      __$$_PutCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_PutCopyWithImpl<$Res> extends _$ApiMethodCopyWithImpl<$Res, _$_Put>
    implements _$$_PutCopyWith<$Res> {
  __$$_PutCopyWithImpl(_$_Put _value, $Res Function(_$_Put) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Put implements _Put {
  const _$_Put();

  @override
  String toString() {
    return 'ApiMethod.put()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Put);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() get,
    required TResult Function() post,
    required TResult Function() put,
    required TResult Function() patch,
    required TResult Function() delete,
  }) {
    return put();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? get,
    TResult? Function()? post,
    TResult? Function()? put,
    TResult? Function()? patch,
    TResult? Function()? delete,
  }) {
    return put?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? get,
    TResult Function()? post,
    TResult Function()? put,
    TResult Function()? patch,
    TResult Function()? delete,
    required TResult orElse(),
  }) {
    if (put != null) {
      return put();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Get value) get,
    required TResult Function(_Post value) post,
    required TResult Function(_Put value) put,
    required TResult Function(_Patch value) patch,
    required TResult Function(_Delete value) delete,
  }) {
    return put(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Get value)? get,
    TResult? Function(_Post value)? post,
    TResult? Function(_Put value)? put,
    TResult? Function(_Patch value)? patch,
    TResult? Function(_Delete value)? delete,
  }) {
    return put?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Get value)? get,
    TResult Function(_Post value)? post,
    TResult Function(_Put value)? put,
    TResult Function(_Patch value)? patch,
    TResult Function(_Delete value)? delete,
    required TResult orElse(),
  }) {
    if (put != null) {
      return put(this);
    }
    return orElse();
  }
}

abstract class _Put implements ApiMethod {
  const factory _Put() = _$_Put;
}

/// @nodoc
abstract class _$$_PatchCopyWith<$Res> {
  factory _$$_PatchCopyWith(_$_Patch value, $Res Function(_$_Patch) then) =
      __$$_PatchCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_PatchCopyWithImpl<$Res>
    extends _$ApiMethodCopyWithImpl<$Res, _$_Patch>
    implements _$$_PatchCopyWith<$Res> {
  __$$_PatchCopyWithImpl(_$_Patch _value, $Res Function(_$_Patch) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Patch implements _Patch {
  const _$_Patch();

  @override
  String toString() {
    return 'ApiMethod.patch()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Patch);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() get,
    required TResult Function() post,
    required TResult Function() put,
    required TResult Function() patch,
    required TResult Function() delete,
  }) {
    return patch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? get,
    TResult? Function()? post,
    TResult? Function()? put,
    TResult? Function()? patch,
    TResult? Function()? delete,
  }) {
    return patch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? get,
    TResult Function()? post,
    TResult Function()? put,
    TResult Function()? patch,
    TResult Function()? delete,
    required TResult orElse(),
  }) {
    if (patch != null) {
      return patch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Get value) get,
    required TResult Function(_Post value) post,
    required TResult Function(_Put value) put,
    required TResult Function(_Patch value) patch,
    required TResult Function(_Delete value) delete,
  }) {
    return patch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Get value)? get,
    TResult? Function(_Post value)? post,
    TResult? Function(_Put value)? put,
    TResult? Function(_Patch value)? patch,
    TResult? Function(_Delete value)? delete,
  }) {
    return patch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Get value)? get,
    TResult Function(_Post value)? post,
    TResult Function(_Put value)? put,
    TResult Function(_Patch value)? patch,
    TResult Function(_Delete value)? delete,
    required TResult orElse(),
  }) {
    if (patch != null) {
      return patch(this);
    }
    return orElse();
  }
}

abstract class _Patch implements ApiMethod {
  const factory _Patch() = _$_Patch;
}

/// @nodoc
abstract class _$$_DeleteCopyWith<$Res> {
  factory _$$_DeleteCopyWith(_$_Delete value, $Res Function(_$_Delete) then) =
      __$$_DeleteCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_DeleteCopyWithImpl<$Res>
    extends _$ApiMethodCopyWithImpl<$Res, _$_Delete>
    implements _$$_DeleteCopyWith<$Res> {
  __$$_DeleteCopyWithImpl(_$_Delete _value, $Res Function(_$_Delete) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Delete implements _Delete {
  const _$_Delete();

  @override
  String toString() {
    return 'ApiMethod.delete()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Delete);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() get,
    required TResult Function() post,
    required TResult Function() put,
    required TResult Function() patch,
    required TResult Function() delete,
  }) {
    return delete();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? get,
    TResult? Function()? post,
    TResult? Function()? put,
    TResult? Function()? patch,
    TResult? Function()? delete,
  }) {
    return delete?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? get,
    TResult Function()? post,
    TResult Function()? put,
    TResult Function()? patch,
    TResult Function()? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Get value) get,
    required TResult Function(_Post value) post,
    required TResult Function(_Put value) put,
    required TResult Function(_Patch value) patch,
    required TResult Function(_Delete value) delete,
  }) {
    return delete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Get value)? get,
    TResult? Function(_Post value)? post,
    TResult? Function(_Put value)? put,
    TResult? Function(_Patch value)? patch,
    TResult? Function(_Delete value)? delete,
  }) {
    return delete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Get value)? get,
    TResult Function(_Post value)? post,
    TResult Function(_Put value)? put,
    TResult Function(_Patch value)? patch,
    TResult Function(_Delete value)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(this);
    }
    return orElse();
  }
}

abstract class _Delete implements ApiMethod {
  const factory _Delete() = _$_Delete;
}
