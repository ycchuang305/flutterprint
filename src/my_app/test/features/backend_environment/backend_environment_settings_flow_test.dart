import 'package:flutterprint/features/authentication/authentication.dart';
import 'package:flutterprint/features/backend_environment/domain/backend_env.dart';
import 'package:flutterprint/services/local_storage/data/shared_preference_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../robot.dart';

void main() {
  group(
    '[BackendEnvSettingFlow]:',
    () {
      testWidgets(
        'Verifies that the environment can be changed from release to demo '
        'and the banner displayed on the SignInPage reflects the change.',
        (tester) async {
          await tester.runAsync(
            () async {
              final r = Robot(tester);
              await r.pumpAppWidget();

              // No banner shown on SignInPage after app started
              r.backendRobot.expectBannerNotFound();

              // Tap 10 times to access backend environment settings page
              await r.backendRobot.tapCountdownTriggerNTimes(
                  SignInPage.numberOfTapToAccessBackendSetting);
              await tester.pumpAndSettle();

              // Tap the demo radio button and save
              await r.backendRobot.tapDemoRadio();
              await r.backendRobot.tapSaveButton();

              // Expect find a demo banner widget
              r.backendRobot.expectBannerFoundWithName(BackendEnv.demo.name);
            },
          );
        },
      );

      testWidgets(
        'Verifies that the environment can be changed from release to develop '
        'and the banner displayed on the SignInPage reflects the change.',
        (tester) async {
          await tester.runAsync(
            () async {
              final r = Robot(tester);
              await r.pumpAppWidget();

              // No banner shown on SignInPage after app started
              r.backendRobot.expectBannerNotFound();

              // Tap 10 times to access backend environment settings page
              await r.backendRobot.tapCountdownTriggerNTimes(
                  SignInPage.numberOfTapToAccessBackendSetting);
              await tester.pumpAndSettle();

              // Tap the demo radio button and save
              await r.backendRobot.tapDevelopRadio();
              await r.backendRobot.tapSaveButton();

              // Expect find a develop banner widget
              r.backendRobot.expectBannerFoundWithName(BackendEnv.develop.name);
            },
          );
        },
      );

      testWidgets(
        'Verifies that the environment can be changed from release to local host '
        'and the banner displayed on the SignInPage reflects the change.',
        (tester) async {
          await tester.runAsync(
            () async {
              final r = Robot(tester);
              await r.pumpAppWidget();

              // No banner shown on SignInPage after app started
              r.backendRobot.expectBannerNotFound();

              // Tap 10 times to access backend environment settings page
              await r.backendRobot.tapCountdownTriggerNTimes(
                  SignInPage.numberOfTapToAccessBackendSetting);
              await tester.pumpAndSettle();

              // Tap the demo radio button and save
              await r.backendRobot.tapLocalHostRadio();
              await r.backendRobot.enterLocalHost('192.168.0.233:8000');
              await r.backendRobot.tapSaveButton();

              // Expect find a local banner widget
              r.backendRobot.expectBannerFoundWithName('local');
            },
          );
        },
      );

      testWidgets(
        "A demo banner is displayed on the app's start-up page if the host key saved in shared preferences is set to demo",
        (tester) async {
          await tester.runAsync(
            () async {
              final r = Robot(tester);
              await r.pumpAppWidget(initialSharedPreferenceValues: {
                SharedPreferenceRepository.prefHostKey: BackendEnv.demo.hostKey,
              });
              // Expect find a demo banner widget
              r.backendRobot.expectBannerFoundWithName(BackendEnv.demo.name);
            },
          );
        },
      );
    },
  );
}
