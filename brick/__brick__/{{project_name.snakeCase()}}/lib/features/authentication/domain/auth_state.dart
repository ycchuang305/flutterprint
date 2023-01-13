import 'package:{{project_name.snakeCase()}}/services/rest_api_service/domain/api_failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.authenticating() = _Authenticating;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.unknown() = _Unknown;
  const factory AuthState.authenticated() = _Authenticated;
  const factory AuthState.failure(ApiFailure failure) = _Failure;
}
