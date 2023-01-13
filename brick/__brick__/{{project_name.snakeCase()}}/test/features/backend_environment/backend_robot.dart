import 'package:flutter/widgets.dart';
import 'package:{{project_name.snakeCase()}}/features/backend_environment/domain/backend_env.dart';
import 'package:{{project_name.snakeCase()}}/features/backend_environment/presentation/backend_environment_setting_page.dart';
import 'package:{{project_name.snakeCase()}}/widgets/countdown_trigger.dart';
import 'package:flutter_test/flutter_test.dart';

class BackendRobot {
  const BackendRobot(this.tester);
  final WidgetTester tester;

  void expectBannerFoundWithName(String bannerName) {
    final banner = find.byKey(Key(bannerName));
    expect(banner, findsOneWidget);
  }

  void expectBannerNotFound() {
    final banner = find.byType(Banner);
    expect(banner, findsNothing);
  }

  Future<void> tapCountdownTriggerNTimes(int times) async {
    final countdownTriggerWidget = find.byType(CountdownTrigger);
    expect(countdownTriggerWidget, findsOneWidget);

    for (int i = 0; i < times; ++i) {
      await tester.tap(countdownTriggerWidget);
      await tester.pump();
    }
  }

  Future<void> tapReleaseRadio() => _tapRadio(BackendEnv.release);

  Future<void> tapDemoRadio() => _tapRadio(BackendEnv.demo);

  Future<void> tapDevelopRadio() => _tapRadio(BackendEnv.develop);

  Future<void> _tapRadio(BackendEnv env) async {
    final radio = find.byKey(Key(env.name));
    await tester.tap(radio);
    await tester.pumpAndSettle();
  }

  Future<void> tapLocalHostRadio() async {
    final radio = find.byKey(BackendEnvironmentSettingPage.localHostRadioKey);
    await tester.tap(radio);
    await tester.pumpAndSettle();
  }

  Future<void> enterLocalHost(String value) async {
    final localHostTextField =
        find.byKey(BackendEnvironmentSettingPage.localHostTextFieldKey);
    expect(localHostTextField, findsOneWidget);
    await tester.enterText(localHostTextField, value);
  }

  Future<void> tapSaveButton() async {
    final saveButton = find.byKey(BackendEnvironmentSettingPage.saveKey);
    await tester.tap(saveButton);
    await tester.pumpAndSettle();
  }
}
