import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/services/rest_api_service/rest_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:stack_trace/stack_trace.dart';
import 'package:{{project_name.snakeCase()}}/features/authentication/authentication.dart';

final httpClientProvider = AutoDisposeProvider((ref) => http.Client());

/// An implementation of RestApiService by using the official http package
class RestApiServiceImpl implements RestApiService {
  RestApiServiceImpl(this._ref, {http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final Ref _ref;
  http.Client? _httpClient;

  static const requestTimeoutDuration = Duration(seconds: 15);
  static const defaultHeader = {
    'content-type': 'application/json',
  };

  String get _accountToken => _ref.read(accountTokenProvider) ?? '';

  Map<String, String> get accountHeaders => {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $_accountToken',
      };

  void _createClient() => _httpClient ??= http.Client();

  void closeClient() {
    _httpClient?.close();
    _httpClient = null;
  }

  @override
  Future<Either<ApiFailure, T>> post<T>({
    required Uri url,
    required T Function(String) dataParser,
    Map<String, String>? customHeaders,
    TokenType tokenType = TokenType.account,
    required Object body,
  }) =>
      _requestHelper(
        apiMethod: const ApiMethod.post(),
        url: url,
        body: body,
        dataParser: dataParser,
        customHeaders: customHeaders,
        tokenType: tokenType,
      );

  @override
  Future<Either<ApiFailure, T>> get<T>({
    required Uri url,
    required T Function(String) dataParser,
    Map<String, String>? customHeaders,
    TokenType tokenType = TokenType.account,
  }) =>
      _requestHelper(
        apiMethod: const ApiMethod.get(),
        url: url,
        dataParser: dataParser,
        customHeaders: customHeaders,
        tokenType: tokenType,
      );

  @override
  Future<Either<ApiFailure, T>> patch<T>({
    required Uri url,
    required T Function(String) dataParser,
    Map<String, String>? customHeaders,
    TokenType tokenType = TokenType.account,
    Object? body,
  }) =>
      _requestHelper(
        apiMethod: const ApiMethod.patch(),
        url: url,
        body: body,
        dataParser: dataParser,
        customHeaders: customHeaders,
        tokenType: tokenType,
      );

  @override
  Future<Either<ApiFailure, T>> put<T>({
    required Uri url,
    required T Function(String) dataParser,
    Map<String, String>? customHeaders,
    TokenType tokenType = TokenType.account,
    Object? body,
  }) =>
      _requestHelper(
        apiMethod: const ApiMethod.put(),
        url: url,
        body: body,
        dataParser: dataParser,
        customHeaders: customHeaders,
        tokenType: tokenType,
      );

  @override
  Future<Either<ApiFailure, T>> delete<T>({
    required Uri url,
    required T Function(String) dataParser,
    Map<String, String>? customHeaders,
    TokenType tokenType = TokenType.account,
  }) =>
      _requestHelper(
        apiMethod: const ApiMethod.delete(),
        url: url,
        dataParser: dataParser,
        customHeaders: customHeaders,
        tokenType: tokenType,
      );

  /// A helper method to send an HTTP request to the given [url]
  /// {@template rest_api_request_helper}
  ///
  /// The HTTP headers will be either [defaultHeader] or [accountHeaders] depend on [tokenType] if [customHeaders] is omitted
  ///
  /// Return the desired app entity of type [T] when the request is success with status code 200.
  ///
  /// Return [ApiFailure] on request failed, such as bad request, unauthorized, socket exception, timeout, etc.
  ///
  /// [dataParser] should be provided to deserialize the http response into desired data
  ///
  /// Return a ApiFailure.apiAgreementConflict() when the [dataParser] does not meet the API agreement
  /// {@endtemplate}
  Future<Either<ApiFailure, T>> _requestHelper<T>({
    required ApiMethod apiMethod,
    required Uri url,
    required T Function(String) dataParser,
    Map<String, String>? customHeaders,
    TokenType tokenType = TokenType.account,
    Object? body,
  }) async {
    // Use default/account headers if custom headers are not provided
    var headers = customHeaders;
    headers ??= (tokenType == TokenType.none) ? defaultHeader : accountHeaders;

    _createClient();
    try {
      final response = await apiMethod.when(
        get: () => _httpClient!
            .get(url, headers: headers)
            .timeout(requestTimeoutDuration),
        post: () => _httpClient!
            .post(url, headers: headers, body: body)
            .timeout(requestTimeoutDuration),
        put: () => _httpClient!
            .put(url, headers: headers, body: body)
            .timeout(requestTimeoutDuration),
        patch: () => _httpClient!
            .patch(url, headers: headers, body: body)
            .timeout(requestTimeoutDuration),
        delete: () => _httpClient!
            .delete(url, headers: headers)
            .timeout(requestTimeoutDuration),
      );
      return _responseToData(response, dataParser);
    } on SocketException catch (e) {
      closeClient();
      return left(ApiFailure.socket(message: e.message));
    } on TimeoutException catch (e) {
      closeClient();
      return left(ApiFailure.timeout(message: e.message));
    } on TypeError catch (e) {
      // Catch the type error caused by json deserialization
      // due to api agreement is inconsistent between server and client side
      var trace = Trace.from(e.stackTrace!);
      log(trace.frames.first.toString());
      return left(const ApiFailure.apiAgreementConflict());
    }
  }

  /// Deserialize the http response into the app entity of type [T] using [dataParser] when status code is 200,
  /// otherwise return a [ApiFailure] depend on the status code
  ///
  /// Throws a [TypeError] when the [dataParser] does not meet the API agreement
  Either<ApiFailure, T> _responseToData<T>(
    http.Response response,
    T Function(String) dataParser,
  ) {
    switch (response.statusCode) {
      case HttpStatus.ok:
        return right(dataParser(response.body));
      case HttpStatus.badRequest:
        return left(ApiFailure.badRequest(message: response.body));
      case HttpStatus.unauthorized:
        return left(ApiFailure.unauthorized(message: response.body));
      case HttpStatus.forbidden:
        return left(ApiFailure.forbidden(message: response.body));
      case HttpStatus.serviceUnavailable:
        return left(ApiFailure.serviceUnavailable(message: response.body));
      case HttpStatus.notFound:
        return left(ApiFailure.notFound(message: response.body));
      default:
        return left(
          ApiFailure.undefined(
            statusCode: response.statusCode,
            message: 'Error occured while communicate with server:\n'
                'url path: ${response.request?.url.path} \n'
                'status code: ${response.statusCode} \n'
                'body: ${response.body}',
          ),
        );
    }
  }
}
