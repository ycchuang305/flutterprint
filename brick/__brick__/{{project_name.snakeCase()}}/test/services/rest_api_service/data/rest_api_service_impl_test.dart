import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:{{project_name.snakeCase()}}/features/backend_environment/backend_environment.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/features/authentication/authentication.dart';
import 'package:{{project_name.snakeCase()}}/services/rest_api_service/rest_api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  ProviderContainer makeProviderContainer(http.Client httpClient) {
    final container = ProviderContainer(
      overrides: [
        httpClientProvider.overrideWithValue(httpClient),
      ],
    );
    // Destroy the state of all providers associated with this container
    addTearDown(container.dispose);
    return container;
  }

  AuthInfo authInfoParser(String body) {
    final jsonResponse = jsonDecode(body);
    return AuthInfo.fromJson(jsonResponse as Map<String, dynamic>);
  }

  group(
    '[RestApiServiceImpl] Calling a correct HTTP rest api request once:',
    () {
      late ProviderContainer container;
      late http.Client httpClient;
      final fakeUrl = Uri(
        scheme: 'https',
        host: 'test.com',
        path: 'path',
      );
      const requestBody = '123';
      setUp(() {
        // Mock the underlying data source, i.e., HTTP Client
        httpClient = MockHttpClient();
        container = makeProviderContainer(httpClient);
      });

      test(
        'GET',
        () async {
          Future<http.Response> httpCall() => httpClient
              .get(
                fakeUrl,
                headers: RestApiServiceImpl.defaultHeader,
              )
              .timeout(RestApiServiceImpl.requestTimeoutDuration);
          await container.read(restApiServiceProvider).get(
                url: fakeUrl,
                dataParser: (_) => null,
                tokenType: TokenType.none,
              );
          verify(httpCall).called(1);
        },
      );

      test(
        'POST',
        () async {
          Future<http.Response> httpCall() => httpClient
              .post(
                fakeUrl,
                headers: RestApiServiceImpl.defaultHeader,
                body: requestBody,
              )
              .timeout(RestApiServiceImpl.requestTimeoutDuration);
          await container.read(restApiServiceProvider).post(
                url: fakeUrl,
                dataParser: (_) => null,
                tokenType: TokenType.none,
                body: requestBody,
              );
          verify(httpCall).called(1);
        },
      );

      test(
        'PUT',
        () async {
          Future<http.Response> httpCall() => httpClient
              .put(
                fakeUrl,
                headers: RestApiServiceImpl.defaultHeader,
                body: requestBody,
              )
              .timeout(RestApiServiceImpl.requestTimeoutDuration);
          await container.read(restApiServiceProvider).put(
                url: fakeUrl,
                dataParser: (_) => null,
                tokenType: TokenType.none,
                body: requestBody,
              );
          verify(httpCall).called(1);
        },
      );

      test(
        'PATCH',
        () async {
          Future<http.Response> httpCall() => httpClient
              .patch(
                fakeUrl,
                headers: RestApiServiceImpl.defaultHeader,
                body: requestBody,
              )
              .timeout(RestApiServiceImpl.requestTimeoutDuration);
          await container.read(restApiServiceProvider).patch(
                url: fakeUrl,
                dataParser: (_) => null,
                tokenType: TokenType.none,
                body: requestBody,
              );
          verify(httpCall).called(1);
        },
      );

      test(
        'DELETE',
        () async {
          Future<http.Response> httpCall() => httpClient
              .delete(
                fakeUrl,
                headers: RestApiServiceImpl.defaultHeader,
              )
              .timeout(RestApiServiceImpl.requestTimeoutDuration);
          await container.read(restApiServiceProvider).delete(
                url: fakeUrl,
                dataParser: (_) => null,
                tokenType: TokenType.none,
              );
          verify(httpCall).called(1);
        },
      );
    },
  );

  group(
    '[RestApiServiceImpl] HTTP Status 200 =>',
    () {
      late ProviderContainer container;
      late http.Client httpClient;
      const host = Host();

      setUp(() {
        // Mock the underlying data source, i.e., HTTP Client
        httpClient = MockHttpClient();
        container = makeProviderContainer(httpClient);
      });

      test(
        'Verifies that making an HTTP call with default headers to a given sign-in URL using the RestApiService '
        'returns an expected AuthInfo object from the response',
        () async {
          final url = host.getUri(Endpoint.signIn);
          final response = MockResponse();
          const requestBody = '123';
          const resBody = {
            '_data': {
              'access_token': 'secret',
            }
          };
          Future<http.Response> httpCall() => httpClient
              .post(
                url,
                headers: {
                  'content-type': 'application/json',
                },
                body: requestBody,
              )
              .timeout(RestApiServiceImpl.requestTimeoutDuration);
          when(() => response.statusCode).thenReturn(HttpStatus.ok);
          when(() => response.body).thenReturn(jsonEncode(resBody));
          when(httpCall).thenAnswer((_) async => response);

          final result = await container.read(restApiServiceProvider).post(
                url: url,
                dataParser: authInfoParser,
                tokenType: TokenType.none,
                body: requestBody,
              );
          verify(httpCall).called(1);
          expect(result.fold(id, id), const AuthInfo(accessToken: 'secret'));
        },
      );

      test(
        'Verifies that a correct HTTP call with account token headers is made to the given refresh token URL, '
        'returns an expected AuthInfo object from the response',
        () async {
          final url = host.getUri(Endpoint.refreshToken);
          final response = MockResponse();
          const accessToken = 'fakeAccessToken';
          final accountHeader = {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $accessToken',
          };
          const resBody = {
            '_data': {
              'access_token': 'secret',
            }
          };
          Future<http.Response> httpCall() => httpClient
              .put(
                url,
                headers: accountHeader,
              )
              .timeout(RestApiServiceImpl.requestTimeoutDuration);
          when(() => response.statusCode).thenReturn(HttpStatus.ok);
          when(() => response.body).thenReturn(jsonEncode(resBody));
          when(httpCall).thenAnswer((_) async => response);

          // Inject account token to accountTokenProvider
          container
              .read(accountTokenProvider.notifier)
              .update((state) => accessToken);

          final result = await container.read(restApiServiceProvider).put(
                url: url,
                dataParser: authInfoParser,
                tokenType: TokenType.account,
              );

          verify(httpCall).called(1);
          expect(result.fold(id, id), const AuthInfo(accessToken: 'secret'));
        },
      );
    },
  );

  group(
    '[RestApiServiceImpl] Receiving a sealed class of ApiFailure object on non-200 HTTP status code of',
    () {
      late ProviderContainer container;
      late http.Client httpClient;
      const host = Host();

      setUp(() {
        // Mock the underlying data source, i.e., HTTP Client
        httpClient = MockHttpClient();
        container = makeProviderContainer(httpClient);
      });

      void setUpHttpCallWithNon200StatusCode(int statusCode) {
        final url = host.getUri(Endpoint.refreshToken);
        final response = MockResponse();
        const accessToken = 'fakeAccessToken';
        final accountHeader = {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        };
        const resBody = {};
        Future<http.Response> httpCall() => httpClient
            .put(
              url,
              headers: accountHeader,
            )
            .timeout(RestApiServiceImpl.requestTimeoutDuration);
        when(() => response.statusCode).thenReturn(statusCode);
        when(() => response.body).thenReturn(jsonEncode(resBody));
        when(httpCall).thenAnswer((_) async => response);
        container
            .read(accountTokenProvider.notifier)
            .update((state) => accessToken);
      }

      Future<Either<ApiFailure, AuthInfo>> makeARefreshTokenRequest() =>
          container
              .read(restApiServiceProvider)
              .put(
                url: host.getUri(Endpoint.refreshToken),
                dataParser: authInfoParser,
                tokenType: TokenType.account,
              )
              .timeout(RestApiServiceImpl.requestTimeoutDuration);

      test(
        'badRequest',
        () async {
          setUpHttpCallWithNon200StatusCode(HttpStatus.badRequest);
          final result = await makeARefreshTokenRequest();
          expect(
              result.fold(id, id), const ApiFailure.badRequest(message: '{}'));
        },
      );

      test(
        'unauthorized',
        () async {
          setUpHttpCallWithNon200StatusCode(HttpStatus.unauthorized);
          final result = await makeARefreshTokenRequest();
          expect(result.fold(id, id),
              const ApiFailure.unauthorized(message: '{}'));
        },
      );

      test(
        'forbidden',
        () async {
          setUpHttpCallWithNon200StatusCode(HttpStatus.forbidden);
          final result = await makeARefreshTokenRequest();
          expect(
              result.fold(id, id), const ApiFailure.forbidden(message: '{}'));
        },
      );

      test(
        'serviceUnavailable',
        () async {
          setUpHttpCallWithNon200StatusCode(HttpStatus.serviceUnavailable);
          final result = await makeARefreshTokenRequest();
          expect(result.fold(id, id),
              const ApiFailure.serviceUnavailable(message: '{}'));
        },
      );

      test(
        'notFound',
        () async {
          setUpHttpCallWithNon200StatusCode(HttpStatus.notFound);
          final result = await makeARefreshTokenRequest();
          expect(result.fold(id, id), const ApiFailure.notFound(message: '{}'));
        },
      );

      test(
        'unknown',
        () async {
          setUpHttpCallWithNon200StatusCode(500);
          final result = await makeARefreshTokenRequest();
          var isUnknownFailure = result.fold(
              (failure) => failure.mapOrNull(undefined: (_) => true),
              (r) => null);
          expect(isUnknownFailure, true);
        },
      );
    },
  );

  group(
    '[RestApiServiceImpl]',
    () {
      late ProviderContainer container;
      late http.Client httpClient;
      const host = Host();

      setUp(() {
        // Mock the underlying data source, i.e., HTTP Client
        httpClient = MockHttpClient();
        container = makeProviderContainer(httpClient);
      });

      void setUpHttpCallAndThrows(Object throwable) {
        final url = host.getUri(Endpoint.refreshToken);
        final response = MockResponse();
        const accessToken = 'fakeAccessToken';
        final accountHeader = {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        };
        const resBody = {};
        Future<http.Response> httpCall() => httpClient
            .put(
              url,
              headers: accountHeader,
            )
            .timeout(RestApiServiceImpl.requestTimeoutDuration);
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(jsonEncode(resBody));
        when(httpCall).thenThrow(throwable);
        container
            .read(accountTokenProvider.notifier)
            .update((state) => accessToken);
      }

      Future<Either<ApiFailure, AuthInfo>> makeARefreshTokenRequest() =>
          container
              .read(restApiServiceProvider)
              .put(
                url: host.getUri(Endpoint.refreshToken),
                dataParser: authInfoParser,
                tokenType: TokenType.account,
              )
              .timeout(RestApiServiceImpl.requestTimeoutDuration);

      test(
        'Receiving a ApiFailure.socket() object on SocketException',
        () async {
          setUpHttpCallAndThrows(const SocketException('socket error'));
          final result = await makeARefreshTokenRequest();
          expect(result.fold(id, id),
              const ApiFailure.socket(message: 'socket error'));
        },
      );

      test(
        'Receiving a ApiFailure.timout() object on TimeoutException',
        () async {
          setUpHttpCallAndThrows(TimeoutException('timeout'));
          final result = await makeARefreshTokenRequest();
          expect(result.fold(id, id),
              const ApiFailure.timeout(message: 'timeout'));
        },
      );

      test(
        'Receiving a ApiFailure.apiAgreementConflict() object on TypeError',
        () async {
          setUpHttpCallAndThrows(TypeError());
          final result = await makeARefreshTokenRequest();
          expect(result.fold(id, id), const ApiFailure.apiAgreementConflict());
        },
      );
    },
  );
}
