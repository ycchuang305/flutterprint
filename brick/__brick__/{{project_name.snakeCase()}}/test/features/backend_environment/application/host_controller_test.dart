import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/features/backend_environment/backend_environment.dart';
import 'package:{{project_name.snakeCase()}}/services/local_storage/local_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../mocks.dart';

void main() {
  Future<ProviderContainer> makeProviderContainer({
    Map<String, Object> mockSharedPrefValues = const {},
  }) async {
    SharedPreferences.setMockInitialValues(mockSharedPrefValues);
    final sharedPreferences = await SharedPreferences.getInstance();
    final sharedPrefRepository = SharedPreferenceRepository(sharedPreferences);
    final container = ProviderContainer(
      overrides: [
        sharedPreferenceRepoProvider.overrideWithValue(sharedPrefRepository),
      ],
    );
    // Destroy the state of all providers associated with this container
    addTearDown(container.dispose);
    return container;
  }

  group(
    '[HostController] init:',
    () {
      late ProviderContainer container;

      test(
        'Verifies that the release environment is retrieved after init() is called if no value is present in shared preferences',
        () async {
          container = await makeProviderContainer();
          final listener = Listener();
          container.listen<Host>(
            hostControllerProvider,
            listener,
            fireImmediately: true,
          );
          container.read(hostControllerProvider.notifier).setUpHost();
          verifyInOrder([
            () => listener(null, const Host()),
            () => listener(
                const Host(), const Host(backendEnv: BackendEnv.release))
          ]);
          verifyNoMoreInteractions(listener);
        },
      );

      test(
        'Verifies that the demo environment is retrieved after init() is called if the demo key is present in shared preferences',
        () async {
          container = await makeProviderContainer(mockSharedPrefValues: {
            SharedPreferenceRepository.prefHostKey: BackendEnv.demo.hostKey,
          });
          final listener = Listener();
          container.listen<Host>(
            hostControllerProvider,
            listener,
            fireImmediately: true,
          );
          container.read(hostControllerProvider.notifier).setUpHost();
          verifyInOrder([
            () => listener(null, const Host()),
            () =>
                listener(const Host(), const Host(backendEnv: BackendEnv.demo))
          ]);
          verifyNoMoreInteractions(listener);
        },
      );

      test(
        'Verifies that the develop environment is retrieved after init() is called if the develop key is present in shared preferences',
        () async {
          container = await makeProviderContainer(mockSharedPrefValues: {
            SharedPreferenceRepository.prefHostKey: BackendEnv.develop.hostKey,
          });
          final listener = Listener();
          container.listen<Host>(
            hostControllerProvider,
            listener,
            fireImmediately: true,
          );
          container.read(hostControllerProvider.notifier).setUpHost();
          verifyInOrder([
            () => listener(null, const Host()),
            () => listener(
                const Host(), const Host(backendEnv: BackendEnv.develop))
          ]);
          verifyNoMoreInteractions(listener);
        },
      );

      test(
        'Verifies that the local environment is retrieved after init() is called if the local host(ip address with port number) '
        'is present in shared preferences',
        () async {
          const localHost = '192.168.0.233';
          container = await makeProviderContainer(mockSharedPrefValues: {
            SharedPreferenceRepository.prefHostKey: localHost,
          });
          final listener = Listener();
          container.listen<Host>(
            hostControllerProvider,
            listener,
            fireImmediately: true,
          );
          container.read(hostControllerProvider.notifier).setUpHost();
          verifyInOrder([
            () => listener(null, const Host()),
            () => listener(
                const Host(),
                const Host(
                  localHost: localHost,
                ))
          ]);
          verifyNoMoreInteractions(listener);
        },
      );
    },
  );

  test(
    "[HostController] update: Verifies that the environment of the app can be updated from release to demo "
    "by calling the host controller's update() method and checking the new value returned",
    () async {
      final container = await makeProviderContainer();
      final listener = Listener();
      container.listen<Host>(
        hostControllerProvider,
        listener,
        fireImmediately: true,
      );
      container.read(hostControllerProvider.notifier).setUpHost();
      await container
          .read(hostControllerProvider.notifier)
          .update(hostKey: BackendEnv.demo.hostKey);
      verifyInOrder([
        () => listener(null, const Host()),
        () =>
            listener(const Host(), const Host(backendEnv: BackendEnv.release)),
        () => listener(const Host(backendEnv: BackendEnv.release),
            const Host(backendEnv: BackendEnv.demo))
      ]);
      verifyNoMoreInteractions(listener);
    },
  );
}
