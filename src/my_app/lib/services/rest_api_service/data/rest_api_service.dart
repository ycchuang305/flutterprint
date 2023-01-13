import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterprint/services/rest_api_service/rest_api_service.dart';

final restApiServiceProvider = Provider<RestApiService>((ref) {
  final client = ref.read(httpClientProvider);
  final restApiService = RestApiServiceImpl(ref, httpClient: client);
  return restApiService;
});

/// A service class that makes HTTP REST API requests
/// and returns either an ApiFailure object or a successful result of generic type T
abstract class RestApiService {
  /// Sends an HTTP GET request with the given headers to the given [url]
  ///
  /// {@macro rest_api_request_helper}
  Future<Either<ApiFailure, T>> get<T>({
    required Uri url,
    required T Function(String) dataParser,
    Map<String, String>? customHeaders,
    TokenType tokenType = TokenType.account,
  });

  /// Sends an HTTP POST request with the given [body] and headers to the given [url]
  ///
  /// {@macro rest_api_request_helper}
  Future<Either<ApiFailure, T>> post<T>({
    required Uri url,
    required T Function(String) dataParser,
    Map<String, String>? customHeaders,
    TokenType tokenType = TokenType.account,
    required Object body,
  });

  /// Sends an HTTP PATCH request with the given [body] and headers to the given [url]
  ///
  /// {@macro rest_api_request_helper}
  Future<Either<ApiFailure, T>> patch<T>({
    required Uri url,
    required T Function(String) dataParser,
    Map<String, String>? customHeaders,
    TokenType tokenType = TokenType.account,
    Object? body,
  });

  /// Sends an HTTP PUT request with the given [body] and headers to the given [url]
  ///
  /// {@macro rest_api_request_helper}
  Future<Either<ApiFailure, T>> put<T>({
    required Uri url,
    required T Function(String) dataParser,
    Map<String, String>? customHeaders,
    TokenType tokenType = TokenType.account,
    Object? body,
  });

  /// Sends an HTTP DELETE request with the given headers to the given [url]
  ///
  /// {@macro rest_api_request_helper}
  Future<Either<ApiFailure, T>> delete<T>({
    required Uri url,
    required T Function(String) dataParser,
    Map<String, String>? customHeaders,
    TokenType tokenType = TokenType.account,
  });
}
