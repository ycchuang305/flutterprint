import 'package:flutterprint/features/authentication/authentication.dart';
import 'package:flutterprint/features/home/presentation/home_page.dart';
import 'package:flutter_test/flutter_test.dart';

class AuthRobot {
  const AuthRobot(this.tester);
  final WidgetTester tester;

  Future<void> enterAccount(String value) async {
    final accountField = find.byKey(SignInPage.accountTextFieldKey);
    expect(accountField, findsOneWidget);
    await tester.enterText(accountField, value);
  }

  Future<void> enterPassword(String value) async {
    final passwordField = find.byKey(SignInPage.passwordTextFieldKey);
    expect(passwordField, findsOneWidget);
    await tester.enterText(passwordField, value);
  }

  Future<void> tapEmailAndPasswordSubmitButton() async {
    final submitButton = find.byKey(SignInPage.submitButtonKey);
    expect(submitButton, findsOneWidget);
    await tester.tap(submitButton);
    await tester.pumpAndSettle();
  }

  Future<void> enterAndSubmitAccountAndPassword() async {
    await enterAccount('tester');
    await tester.pump();
    await enterPassword('123456');
    await tapEmailAndPasswordSubmitButton();
  }

  Future<void> tapSignOutButton() async {
    final signOutButton = find.byKey(HomePage.signOutKey);
    expect(signOutButton, findsOneWidget);
    await tester.tap(signOutButton);
    await tester.pumpAndSettle();
  }

  void expectAccountAndPasswordFieldsFound() {
    final accountField = find.byKey(SignInPage.accountTextFieldKey);
    expect(accountField, findsOneWidget);
    final passwordField = find.byKey(SignInPage.passwordTextFieldKey);
    expect(passwordField, findsOneWidget);
  }

  void expectSignOutButtonFound() {
    final signOutBtn = find.byKey(HomePage.signOutKey);
    expect(signOutBtn, findsOneWidget);
  }
}
