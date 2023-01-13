import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterprint/features/authentication/authentication.dart';
import 'package:flutterprint/services/local_storage/data/secure_storage_repository.dart';
import 'package:flutterprint/services/local_storage/data/shared_preference_repository.dart';
import 'package:flutterprint/services/rest_api_service/rest_api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fake_model.dart';
import '../../../mocks.dart';

void main() {
  Future<ProviderContainer> makeProviderContainer({
    Map<String, Object> mockSharedPrefValues = const {},
  }) async {
    final mockAuthRepository = MockAuthRepository();
    final mockSecureRepository = MockSecureRepository();
    SharedPreferences.setMockInitialValues(mockSharedPrefValues);
    final sharedPreferences = await SharedPreferences.getInstance();
    final sharedPrefRepository = SharedPreferenceRepository(sharedPreferences);
    final container = ProviderContainer(
      overrides: [
        sharedPreferenceRepoProvider.overrideWithValue(sharedPrefRepository),
        authRepoProvider.overrideWithValue(mockAuthRepository),
        secureRepositoryProvider.overrideWithValue(mockSecureRepository),
      ],
    );
    // Destroy the state of all providers associated with this container
    addTearDown(container.dispose);
    return container;
  }

  test(
    'Verifies that the default state of the AuthController is AuthState.unknown()',
    () async {
      final container = await makeProviderContainer();
      final listener = Listener();
      container.listen<AuthState>(
        authControllerProvider,
        listener,
        fireImmediately: true,
      );
      verify(
        () => listener(
          null,
          const AuthState.unknown(),
        ),
      ).called(1);
      verifyNoMoreInteractions(listener);
    },
  );

  group(
    '[AuthController] signOut:',
    () {
      late ProviderContainer container;

      void commonMocks() {
        when(() => container.read(secureRepositoryProvider).deleteAuthInfo())
            .thenAnswer((_) => Future.value(null));
      }

      test(
        'Verifies that the AccountTokenProvider is properly reset to null after a sign out',
        () async {
          container = await makeProviderContainer();
          final accountTokenProviderListener = Listener();
          container.listen<String?>(
            accountTokenProvider,
            accountTokenProviderListener,
            fireImmediately: true,
          );
          commonMocks();
          await container.read(authControllerProvider.notifier).signOut();
          verify(() => accountTokenProviderListener(any(), null)).called(1);
          verifyNoMoreInteractions(accountTokenProviderListener);
        },
      );

      test(
        'Verifies that the auth info is deleted and the state is changed to AuthState.unauthenticated() after a sign out ',
        () async {
          container = await makeProviderContainer();

          final authStateListener = Listener();
          container.listen<AuthState>(
            authControllerProvider,
            authStateListener,
            fireImmediately: false,
          );
          commonMocks();
          await container.read(authControllerProvider.notifier).signOut();
          verify(() =>
                  container.read(secureRepositoryProvider).deleteAuthInfo())
              .called(1);
          verify(
            () => authStateListener(
              const AuthState.unknown(),
              const AuthState.unauthenticated(),
            ),
          ).called(1);
          verifyNoMoreInteractions(authStateListener);
        },
      );
    },
  );

  group(
    '[AuthController] authentication:',
    () {
      late ProviderContainer container;

      void commonMocks() {
        when(() => container.read(secureRepositoryProvider).deleteAuthInfo())
            .thenAnswer((_) => Future.value(null));
      }

      test(
        'Verifies that the state is changed to AuthState.unauthenticated() when the token is not found',
        () async {
          container = await makeProviderContainer();
          final authStateListener = Listener();
          container.listen<AuthState>(
            authControllerProvider,
            authStateListener,
            fireImmediately: false,
          );
          commonMocks();
          when(() => container.read(secureRepositoryProvider).getAuthInfo())
              .thenAnswer((_) async => AuthInfo.empty());
          await container
              .read(authControllerProvider.notifier)
              .authentication();

          verifyInOrder([
            () => authStateListener(
                  const AuthState.unknown(),
                  const AuthState.authenticating(),
                ),
            () => authStateListener(
                  const AuthState.authenticating(),
                  const AuthState.unauthenticated(),
                ),
          ]);
          verifyNoMoreInteractions(authStateListener);
        },
      );

      test(
        'Verifies that the state is changed to AuthState.unauthenticated() when the value of shouldStaySignedIn is false ',
        () async {
          container = await makeProviderContainer(mockSharedPrefValues: {
            SharedPreferenceRepository.prefStaySignedInKey: false,
          });
          final authStateListener = Listener();
          container.listen<AuthState>(
            authControllerProvider,
            authStateListener,
            fireImmediately: false,
          );
          commonMocks();
          when(() => container.read(secureRepositoryProvider).getAuthInfo())
              .thenAnswer((_) async => FakeModel.authInfo);
          await container
              .read(authControllerProvider.notifier)
              .authentication();
          verifyInOrder([
            () => authStateListener(
                  const AuthState.unknown(),
                  const AuthState.authenticating(),
                ),
            () => authStateListener(
                  const AuthState.authenticating(),
                  const AuthState.unauthenticated(),
                ),
          ]);
          verifyNoMoreInteractions(authStateListener);
        },
      );

      test(
        'Verifies that the state is changed to AuthState.unauthenticated() when receiving unauthorized failure object',
        () async {
          container = await makeProviderContainer(mockSharedPrefValues: {
            SharedPreferenceRepository.prefStaySignedInKey: true,
          });
          final authStateListener = Listener();
          final authRepo = container.read(authRepoProvider);
          container.listen<AuthState>(
            authControllerProvider,
            authStateListener,
            fireImmediately: false,
          );
          commonMocks();
          when(() => container.read(secureRepositoryProvider).getAuthInfo())
              .thenAnswer((_) async => FakeModel.authInfo);
          // Return an unauthorized failure when calling refreshToken
          when(() => authRepo.refreshToken())
              .thenAnswer((_) async => left(const ApiFailure.unauthorized()));
          await container
              .read(authControllerProvider.notifier)
              .authentication();
          verify(() => authRepo.refreshToken()).called(1);
          verifyInOrder([
            () => authStateListener(
                  const AuthState.unknown(),
                  const AuthState.authenticating(),
                ),
            () => authStateListener(
                  const AuthState.authenticating(),
                  const AuthState.unauthenticated(),
                ),
          ]);
          verifyNoMoreInteractions(authStateListener);
        },
      );

      test(
        'Verifies that the state is changed to AuthState.authenticated() when receiving a valid AuthInfo object',
        () async {
          container = await makeProviderContainer(mockSharedPrefValues: {
            SharedPreferenceRepository.prefStaySignedInKey: true,
          });
          final authStateListener = Listener<AuthState>();
          final authRepo = container.read(authRepoProvider);
          const newToken = 'new';
          final fakeUserWithNewToken =
              FakeModel.authInfo.copyWith(accessToken: newToken);
          container.listen<AuthState>(
            authControllerProvider,
            authStateListener,
            fireImmediately: false,
          );
          when(() => container.read(secureRepositoryProvider).getAuthInfo())
              .thenAnswer((_) async => FakeModel.authInfo);
          when(() => container
              .read(secureRepositoryProvider)
              .saveAuthInfo(fakeUserWithNewToken)).thenAnswer((_) async {});
          // Return an unauthorized failure when calling refreshToken
          when(() => authRepo.refreshToken())
              .thenAnswer((_) async => right(fakeUserWithNewToken));
          await container
              .read(authControllerProvider.notifier)
              .authentication();
          verify(() => authRepo.refreshToken()).called(1);
          verify(() => container
              .read(secureRepositoryProvider)
              .saveAuthInfo(fakeUserWithNewToken)).called(1);
          verifyInOrder([
            () => authStateListener(
                  const AuthState.unknown(),
                  const AuthState.authenticating(),
                ),
            () => authStateListener(
                  const AuthState.authenticating(),
                  const AuthState.authenticated(),
                ),
          ]);
          verifyNoMoreInteractions(authStateListener);
        },
      );

      test(
        'Verifies that the state of accountTokenProvider should be updated with the new token upon successful authentication',
        () async {
          container = await makeProviderContainer(mockSharedPrefValues: {
            SharedPreferenceRepository.prefStaySignedInKey: true,
          });
          final accountTokenListener = Listener<String?>();
          final authRepo = container.read(authRepoProvider);
          const oldToken = 'old';
          const newToken = 'new';
          final fakeUserWithOldToken =
              FakeModel.authInfo.copyWith(accessToken: oldToken);
          final fakeUserWithNewToken =
              FakeModel.authInfo.copyWith(accessToken: newToken);
          container.listen<String?>(
            accountTokenProvider,
            accountTokenListener,
            fireImmediately: false,
          );
          when(() => container.read(secureRepositoryProvider).getAuthInfo())
              .thenAnswer((_) async => fakeUserWithOldToken);
          when(() => container
              .read(secureRepositoryProvider)
              .saveAuthInfo(fakeUserWithNewToken)).thenAnswer((_) async {});
          // Return an unauthorized failure when calling refreshToken
          when(() => authRepo.refreshToken())
              .thenAnswer((_) async => right(fakeUserWithNewToken));
          await container
              .read(authControllerProvider.notifier)
              .authentication();
          verify(() => authRepo.refreshToken()).called(1);
          verify(() => container
              .read(secureRepositoryProvider)
              .saveAuthInfo(fakeUserWithNewToken)).called(1);
          verifyInOrder([
            () => accountTokenListener(
                  null,
                  oldToken,
                ),
            () => accountTokenListener(
                  oldToken,
                  newToken,
                ),
          ]);
          verifyNoMoreInteractions(accountTokenListener);
        },
      );
    },
  );

  group(
    '[AuthController] signIn:',
    () {
      late ProviderContainer container;

      test(
        'Verifies that the state is changed to AuthState.failure(ApiFailure.badRequest()) '
        'when the sign in fails due to a bad request API failure ',
        () async {
          const username = 'foo';
          const password = 'bar';
          container = await makeProviderContainer();
          final authStateListener = Listener();
          container.listen<AuthState>(
            authControllerProvider,
            authStateListener,
            fireImmediately: false,
          );
          when(
            () => container
                .read(authRepoProvider)
                .signIn(username: username, password: password),
          ).thenAnswer((_) async => left(const ApiFailure.badRequest()));
          await container
              .read(authControllerProvider.notifier)
              .signIn(username: username, password: password);
          verifyInOrder([
            () => authStateListener(
                  const AuthState.unknown(),
                  const AuthState.authenticating(),
                ),
            () => authStateListener(
                  const AuthState.authenticating(),
                  const AuthState.failure(ApiFailure.badRequest()),
                ),
          ]);
          verify(() => container
              .read(authRepoProvider)
              .signIn(username: username, password: password)).called(1);
          verifyNoMoreInteractions(authStateListener);
        },
      );

      test(
        'Verifies that the auth info is saved into secure storage '
        'and the state is changed to AuthState.authenticated() upon successful sign in',
        () async {
          const username = 'foo';
          const password = 'bar';
          container = await makeProviderContainer();
          final authStateListener = Listener();
          container.listen<AuthState>(
            authControllerProvider,
            authStateListener,
            fireImmediately: false,
          );
          when(() => container
              .read(secureRepositoryProvider)
              .saveAuthInfo(FakeModel.authInfo)).thenAnswer((_) async {});
          when(
            () => container
                .read(authRepoProvider)
                .signIn(username: username, password: password),
          ).thenAnswer((_) async => right(FakeModel.authInfo));
          await container
              .read(authControllerProvider.notifier)
              .signIn(username: username, password: password);
          verifyInOrder([
            () => authStateListener(
                  const AuthState.unknown(),
                  const AuthState.authenticating(),
                ),
            () => authStateListener(const AuthState.authenticating(),
                const AuthState.authenticated()),
          ]);
          verify(() => container
              .read(secureRepositoryProvider)
              .saveAuthInfo(FakeModel.authInfo)).called(1);
          verify(() => container
              .read(authRepoProvider)
              .signIn(username: username, password: password)).called(1);
          verifyNoMoreInteractions(authStateListener);
        },
      );
    },
  );

  group(
    '[AuthController] updateStaySignedIn:',
    () {
      late ProviderContainer container;

      test(
        'Verifies that the state of staySignedInProvider should be updated to true',
        () async {
          container = await makeProviderContainer();
          await container
              .read(authControllerProvider.notifier)
              .updateStaySignedIn(true);
          var staySignedIn =
              container.read(sharedPreferenceRepoProvider).getStaySignedIn();
          expect(container.read(staySignedInProvider), true);
          expect(staySignedIn, true);
        },
      );

      test(
        'Verifies that the state of staySignedInProvider should be updated to false',
        () async {
          container = await makeProviderContainer();
          await container
              .read(authControllerProvider.notifier)
              .updateStaySignedIn(false);
          var staySignedIn =
              container.read(sharedPreferenceRepoProvider).getStaySignedIn();
          expect(container.read(staySignedInProvider), false);
          expect(staySignedIn, false);
        },
      );
    },
  );
}
