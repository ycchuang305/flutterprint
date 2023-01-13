import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:{{project_name.snakeCase()}}/services/local_storage/local_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fake_model.dart';
import '../../mocks.dart';

void main() {
  Future<ProviderContainer> makeProviderContainer({
    Map<String, Object> mockSharedPrefValues = const {},
    required FlutterSecureStorage secureStorage,
  }) async {
    SharedPreferences.setMockInitialValues(mockSharedPrefValues);
    final sharedPreferences = await SharedPreferences.getInstance();
    final sharedPrefRepository = SharedPreferenceRepository(sharedPreferences);
    final secureRepository =
        SecureRepositoryImpl(secureStorage, sharedPrefRepository);
    final container = ProviderContainer(
      overrides: [
        sharedPreferenceRepoProvider.overrideWithValue(sharedPrefRepository),
        secureRepositoryProvider.overrideWithValue(secureRepository),
      ],
    );
    // Destroy the state of all providers associated with this container
    addTearDown(container.dispose);
    return container;
  }

  group(
    '[SecureStorageRepository] validateSecureStorage:',
    () {
      late ProviderContainer container;
      late FlutterSecureStorage mockSecureStorage;

      setUpAll(() {
        registerFallbackValue(const AndroidOptions());
      });

      setUp(
        () async {
          mockSecureStorage = MockFlutterSecureStorage();
        },
      );

      test(
        "If the valid flag stored in shared preferences is false (indicating that the application is newly installed or has been uninstalled),"
        "the secure storage is invalid. In this case, "
        "delete all secure storage data and set the valid flag to true.",
        () async {
          container =
              await makeProviderContainer(secureStorage: mockSecureStorage);
          when(() =>
                  mockSecureStorage.deleteAll(aOptions: any(named: 'aOptions')))
              .thenAnswer((_) async {});

          var isSecureStorageValid = container
              .read(sharedPreferenceRepoProvider)
              .isSecureStorageValid();

          expect(isSecureStorageValid, false);

          await container
              .read(secureRepositoryProvider)
              .validateSecureStorage();

          isSecureStorageValid = container
              .read(sharedPreferenceRepoProvider)
              .isSecureStorageValid();

          expect(isSecureStorageValid, true);
          verify(() =>
                  mockSecureStorage.deleteAll(aOptions: any(named: 'aOptions')))
              .called(1);
        },
      );

      test(
        'If the valid flag saved in shared preferences is true, indicating that the secure storage is valid, '
        'do not perform any action',
        () async {
          container = await makeProviderContainer(
            secureStorage: mockSecureStorage,
            mockSharedPrefValues: {
              SharedPreferenceRepository.prefValidSecureStorageKey: true,
            },
          );

          await container
              .read(secureRepositoryProvider)
              .validateSecureStorage();

          verifyNever(() =>
              mockSecureStorage.deleteAll(aOptions: any(named: 'aOptions')));
        },
      );
    },
  );

  group(
    '[SecureStorageRepository] saveAuthInfo:',
    () {
      late ProviderContainer container;
      late FlutterSecureStorage mockSecureStorage;

      setUpAll(() {
        registerFallbackValue(const AndroidOptions());
      });

      setUp(
        () async {
          mockSecureStorage = MockFlutterSecureStorage();
        },
      );

      test(
        'Verifies that the write method with the expected arguments is called once when saving the AuthInfo object to secure storage',
        () async {
          container =
              await makeProviderContainer(secureStorage: mockSecureStorage);

          Future<void> writeAuthInfo() => mockSecureStorage.write(
              key: SecureStorageKey.authInfo.name,
              value: FakeModel.authInfo.toSecureStorage,
              aOptions: any(named: 'aOptions'));

          when(writeAuthInfo).thenAnswer((_) async {});

          await container
              .read(secureRepositoryProvider)
              .saveAuthInfo(FakeModel.authInfo);

          verify(writeAuthInfo).called(1);
        },
      );
    },
  );

  group(
    '[SecureStorageRepository] getAuthInfo:',
    () {
      late ProviderContainer container;
      late FlutterSecureStorage mockSecureStorage;

      setUpAll(() {
        registerFallbackValue(const AndroidOptions());
      });

      setUp(
        () async {
          mockSecureStorage = MockFlutterSecureStorage();
        },
      );

      test(
        'Verifies that the read method with the expected arguments is called once and that the expected authInfo object is retrieved from the secure storage',
        () async {
          container =
              await makeProviderContainer(secureStorage: mockSecureStorage);

          Future<String?> getAuthInfo() => mockSecureStorage.read(
              key: SecureStorageKey.authInfo.name,
              aOptions: any(named: 'aOptions'));

          when(getAuthInfo)
              .thenAnswer((_) async => FakeModel.authInfo.toSecureStorage);

          var authInfo =
              await container.read(secureRepositoryProvider).getAuthInfo();

          verify(getAuthInfo).called(1);
          expect(authInfo, FakeModel.authInfo);
        },
      );
    },
  );

  group(
    '[SecureStorageRepository] deleteAuthInfo:',
    () {
      late ProviderContainer container;
      late FlutterSecureStorage mockSecureStorage;

      setUpAll(() {
        registerFallbackValue(const AndroidOptions());
      });

      setUp(
        () async {
          mockSecureStorage = MockFlutterSecureStorage();
        },
      );

      test(
        "Verifies that the delete method with the expected arguments is called once when calling deleteAuthInfo()",
        () async {
          container =
              await makeProviderContainer(secureStorage: mockSecureStorage);

          Future<void> deleteAuthInfo() => mockSecureStorage.delete(
              key: SecureStorageKey.authInfo.name,
              aOptions: any(named: 'aOptions'));

          when(deleteAuthInfo).thenAnswer((_) async {});

          await container.read(secureRepositoryProvider).deleteAuthInfo();

          verify(deleteAuthInfo).called(1);
        },
      );
    },
  );
}
