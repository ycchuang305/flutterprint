import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterprint/constant/app_sizes.dart';
import 'package:flutterprint/constant/theme/theme.dart';
import 'package:flutterprint/features/authentication/authentication.dart';
import 'package:flutterprint/features/theme_mode/application/theme_mode_controller.dart';
import 'package:flutterprint/l10n/l10n.dart';
import 'package:flutterprint/routing/app_router.dart';
import 'package:flutterprint/services/rest_api_service/rest_api_service.dart';
import 'package:flutterprint/services/snackbar/app_snackbar_repository.dart';
import 'package:flutterprint/utils/utils.dart';
import 'package:flutterprint/widgets/countdown_trigger.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  // * Keys for testing using find.byKey()
  static const accountTextFieldKey = Key('account');
  static const passwordTextFieldKey = Key('password');
  static const submitButtonKey = Key('submit');

  static const numberOfTapToAccessBackendSetting = 10;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SigninPageState();
}

class _SigninPageState extends ConsumerState<SignInPage>
    with AccountAndPasswordValidatorsMixin {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _accountTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();
  var _obscurePassword = true;

  // local variable used to apply AutovalidateMode.onUserInteraction and show
  // error hints only when the form has been submitted
  var _submitted = false;

  String get account => _accountTextEditingController.text;
  String get password => _passwordTextEditingController.text;

  @override
  void dispose() {
    _node.dispose();
    _accountTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    // only submit the form if validation passes
    if (_formKey.currentState!.validate()) {
      await ref.read(authControllerProvider.notifier).signIn(
            username: account,
            password: password,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    ref.listen<AuthState>(
      authControllerProvider,
      (_, status) {
        status.whenOrNull(
          failure: (apiFailure) {
            apiFailure.maybeWhen(
              badRequest: (_) => ref.read(appSnackBarRepoProvider).showSnackbar(
                  context,
                  message: l10n.incorrectAccountOrPassword),
              orElse: () =>
                  apiFailure.showPredefinedSnackbar(context: context, ref: ref),
            );
          },
        );
      },
    );
    final state = ref.watch(authControllerProvider);
    final theme = ref.watch(themeModeControllerProvider);
    final colorScheme = context.colorScheme;
    var isAuthenticating = state == const AuthState.authenticating();
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: CountdownTrigger(
          startFrom: SignInPage.numberOfTapToAccessBackendSetting,
          onUpdated: (count) {
            if (count < 6) {
              ref.read(appSnackBarRepoProvider).showSnackbar(context,
                  message: l10n.backendEnvEnableText(count));
            }
          },
          onFinished: () {
            ref.read(appSnackBarRepoProvider).clearSnackbars(context);
            ref.read(appRouterProvider).goNamed(AppRoute.backendEnv.name);
          },
          child: Text(l10n.signinAppBarTitle),
        ),
        actions: [
          IconButton(
            onPressed: () => ref
                .read(themeModeControllerProvider.notifier)
                .toggleAndSaveThemeMode(),
            icon: Icon(
              theme == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 600,
            child: Padding(
              padding: const EdgeInsets.all(Sizes.p16),
              child: Card(
                color: colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.p16),
                  child: FocusScope(
                    node: _node,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          gapH8,
                          // Account field
                          TextFormField(
                            key: SignInPage.accountTextFieldKey,
                            controller: _accountTextEditingController,
                            decoration: InputDecoration(
                              labelText: l10n.account,
                              hintText: 'abc123@test.com',
                              enabled: !isAuthenticating,
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (email) => !_submitted
                                ? null
                                : accountErrorText(email ?? '', l10n),
                            autocorrect: false,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            keyboardAppearance: Brightness.light,
                            onEditingComplete: () {
                              if (canSubmitAccount(account)) {
                                _node.nextFocus();
                              }
                            },
                          ),
                          gapH8,
                          // Password field
                          TextFormField(
                            key: SignInPage.passwordTextFieldKey,
                            controller: _passwordTextEditingController,
                            decoration: InputDecoration(
                              labelText: l10n.password,
                              enabled: !isAuthenticating,
                              suffix: SizedBox(
                                height: Sizes.p24,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.remove_red_eye,
                                    size: Sizes.p20,
                                  ),
                                  onPressed: () => setState(() =>
                                      _obscurePassword = !_obscurePassword),
                                ),
                              ),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (password) => !_submitted
                                ? null
                                : passwordErrorText(password ?? '', l10n),
                            obscureText: _obscurePassword,
                            autocorrect: false,
                            enableSuggestions: false,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            keyboardAppearance: Brightness.light,
                            onEditingComplete: () {
                              if (!canSubmitAccount(account)) {
                                _node.previousFocus();
                                return;
                              }
                              _submit();
                            },
                          ),
                          gapH8,
                          Row(
                            children: [
                              Checkbox(
                                value: ref.watch(staySignedInProvider),
                                activeColor: colorScheme.primary,
                                checkColor: colorScheme.surface,
                                onChanged: (value) {
                                  if (value != null) {
                                    ref
                                        .read(authControllerProvider.notifier)
                                        .updateStaySignedIn(value);
                                  }
                                },
                              ),
                              GestureDetector(
                                onTap: () {
                                  var value = !ref.read(staySignedInProvider);
                                  ref
                                      .read(authControllerProvider.notifier)
                                      .updateStaySignedIn(value);
                                },
                                child: Text(
                                  l10n.staySignedin,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          gapH8,
                          SizedBox(
                            height: Sizes.p48,
                            child: ElevatedButton(
                              key: SignInPage.submitButtonKey,
                              onPressed: isAuthenticating ? null : _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.secondaryContainer,
                                foregroundColor:
                                    colorScheme.onSecondaryContainer,
                              ),
                              child: isAuthenticating
                                  ? const SizedBox(
                                      height: Sizes.p16,
                                      width: Sizes.p16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      l10n.submit,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!,
                                    ),
                            ),
                          ),
                          gapH8,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
