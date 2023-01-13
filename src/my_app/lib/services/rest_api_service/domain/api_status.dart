import 'package:flutterprint/services/rest_api_service/domain/api_failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_status.freezed.dart';

@freezed
class ApiStatus with _$ApiStatus {
  const factory ApiStatus.loading() = _Loading;
  const factory ApiStatus.success() = _Success;
  const factory ApiStatus.failure(ApiFailure apiFailure) = _ApiFailure;
}
