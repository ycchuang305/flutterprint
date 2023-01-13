import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_failure.freezed.dart';

@freezed
class ApiFailure with _$ApiFailure {
  const ApiFailure._();
  const factory ApiFailure.apiAgreementConflict() = _ApiAgreementConflict;
  const factory ApiFailure.badRequest({String? message}) = _BadRequest;
  const factory ApiFailure.forbidden({String? message}) = _Forbidden;
  const factory ApiFailure.socket({String? message}) = _Socket;
  const factory ApiFailure.notFound({String? message}) = _NotFound;
  const factory ApiFailure.serviceUnavailable({String? message}) =
      _ServiceUnavailable;
  const factory ApiFailure.timeout({String? message}) = _Timeout;
  const factory ApiFailure.unauthorized({String? message}) = _Unauthorized;
  const factory ApiFailure.undefined(
      {required int statusCode, String? message}) = _Undefined;
}
