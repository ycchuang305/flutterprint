import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_method.freezed.dart';

@freezed
class ApiMethod with _$ApiMethod {
  const factory ApiMethod.get() = _Get;
  const factory ApiMethod.post() = _Post;
  const factory ApiMethod.put() = _Put;
  const factory ApiMethod.patch() = _Patch;
  const factory ApiMethod.delete() = _Delete;
}
