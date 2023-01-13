import 'package:{{project_name.snakeCase()}}/utils/validators/string_validator.dart';
import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';

/// Mixin class to be used for client-side account & password validation
mixin AccountAndPasswordValidatorsMixin {
  final nonEmptyValidator = StringValidator.nonEmpty();

  bool canSubmitAccount(String account) {
    return nonEmptyValidator.isValid(account);
  }

  bool canSubmitPassword(String password) {
    return nonEmptyValidator.isValid(password);
  }

  String? accountErrorText(String account, AppLocalizations l10n) {
    final bool showErrorText = !canSubmitAccount(account);
    return showErrorText ? l10n.accountCanNotBeEmpty : null;
  }

  String? passwordErrorText(String password, AppLocalizations l10n) {
    final bool showErrorText = !canSubmitPassword(password);
    return showErrorText ? l10n.passwordCanNotBeEmpty : null;
  }
}
