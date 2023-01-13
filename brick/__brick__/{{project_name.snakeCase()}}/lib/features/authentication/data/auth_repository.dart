import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/features/authentication/authentication.dart';
import 'package:{{project_name.snakeCase()}}/features/authentication/data/fake_auth_repository.dart';
import 'package:{{project_name.snakeCase()}}/features/backend_environment/backend_environment.dart';
import 'package:{{project_name.snakeCase()}}/services/rest_api_service/rest_api_service.dart';

final authRepoProvider = Provider<AuthRepository>((ref) {
  return const FakeAuthRepository();
  // TODO: Replace the repository with AuthRepositoryImpl for real implementation
  // final restApiService = ref.watch(restApiServiceProvider);
  // return AuthRepositoryImpl(restApiService, ref);
});

abstract class AuthRepository {
  Future<Either<ApiFailure, AuthInfo>> signIn({
    required String username,
    required String password,
  });

  Future<Either<ApiFailure, AuthInfo>> refreshToken();
}

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this.restApiService, this.ref);

  final RestApiService restApiService;
  final Ref ref;

  @override
  Future<Either<ApiFailure, AuthInfo>> signIn({
    required String username,
    required String password,
  }) =>
      restApiService.post(
        url: ref.read(hostControllerProvider).getUri(Endpoint.signIn),
        tokenType: TokenType.none,
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
        dataParser: _authInfoParser,
      );

  @override
  Future<Either<ApiFailure, AuthInfo>> refreshToken() => restApiService.put(
        url: ref.read(hostControllerProvider).getUri(Endpoint.refreshToken),
        tokenType: TokenType.account,
        dataParser: _authInfoParser,
      );

  AuthInfo _authInfoParser(String body) {
    final jsonResponse = jsonDecode(body);
    return AuthInfo.fromJson(jsonResponse as Map<String, dynamic>);
  }
}
