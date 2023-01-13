import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/features/authentication/authentication.dart';
import 'package:{{project_name.snakeCase()}}/features/authentication/data/fake_auth_repository.dart';
import 'package:{{project_name.snakeCase()}}/main.dart';
import 'package:{{project_name.snakeCase()}}/services/local_storage/data/fake_secure_storage_repository.dart';
import 'package:{{project_name.snakeCase()}}/services/local_storage/local_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/authentication/auth_robot.dart';
import 'features/backend_environment/backend_robot.dart';

class Robot {
  Robot(this.tester)
      : authRobot = AuthRobot(tester),
        backendRobot = BackendRobot(tester);
  final WidgetTester tester;
  final AuthRobot authRobot;
  final BackendRobot backendRobot;

  Future<void> pumpAppWidget(
      {Map<String, Object> initialSharedPreferenceValues = const {}}) async {
    const secureStorageRepository = FakeSecureStorageRepository();
    const authRepository = FakeAuthRepository(addDelay: false);
    SharedPreferences.setMockInitialValues(initialSharedPreferenceValues);
    final sharedPreferences = await SharedPreferences.getInstance();
    final sharedPrefRepository = SharedPreferenceRepository(sharedPreferences);
    // Create ProviderContainer with any required overrides
    final container = ProviderContainer(
      overrides: [
        secureRepositoryProvider.overrideWithValue(secureStorageRepository),
        authRepoProvider.overrideWithValue(authRepository),
        sharedPreferenceRepoProvider.overrideWithValue(sharedPrefRepository),
      ],
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const AppWidget(),
      ),
    );
    await tester.pumpAndSettle();
  }
}
