import 'package:{{project_name.snakeCase()}}/services/local_storage/data/shared_preference_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../robot.dart';

void main() {
  group(
    '[AuthFlow]:',
    () {
      testWidgets(
        'Verifies the sign in and sign out flow of the app by starting on the SignInPage, '
        'and verifying that entering and submitting the correct account and password redirects to the HomePage, '
        'and tapping the sign out button on the HomePage redirects back to the SignInPage',
        (tester) async {
          await tester.runAsync(
            () async {
              final r = Robot(tester);
              await r.pumpAppWidget();

              // SignInPage should be present on app started
              r.authRobot.expectAccountAndPasswordFieldsFound();
              await r.authRobot.enterAndSubmitAccountAndPassword();

              // HomePage should be present after sign in
              r.authRobot.expectSignOutButtonFound();
              await r.authRobot.tapSignOutButton();

              // SignInPage should be present after sign out
              r.authRobot.expectAccountAndPasswordFieldsFound();
            },
          );
        },
      );

      testWidgets(
        "Verifies the sign out flow of the app by starting on the HomePage if the 'stay signed in' value saved in shared preferences is true, "
        "and tapping the sign out button on the HomePage redirects back to the SignInPage",
        (tester) async {
          await tester.runAsync(
            () async {
              final r = Robot(tester);
              await r.pumpAppWidget(
                initialSharedPreferenceValues: {
                  SharedPreferenceRepository.prefStaySignedInKey: true,
                },
              );
              // HomePage should be present on app started if 'stay signed in' value saved in shared preferences is true
              // upon successful authentication
              r.authRobot.expectSignOutButtonFound();
              await r.authRobot.tapSignOutButton();

              // SignInPage should be present after sign out
              r.authRobot.expectAccountAndPasswordFieldsFound();
            },
          );
        },
      );
    },
  );
}
