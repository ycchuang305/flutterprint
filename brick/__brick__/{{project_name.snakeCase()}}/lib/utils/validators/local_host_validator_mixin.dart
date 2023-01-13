import 'package:{{project_name.snakeCase()}}/constant/regex_pattern.dart';
import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';
import 'package:{{project_name.snakeCase()}}/utils/utils.dart';

mixin LocalHostValidatorMixin {
  // Use a regular expression to check if the input string follows the pattern
  // of an IP address (four groups of digits separated by periods) followed by a
  // colon and a port number (one or more digits)
  final localHostVaidator = StringValidator.regex(RegexPattern.ipAddressPort);

  bool canSubmitLocalHost(String localHost) =>
      localHostVaidator.isValid(localHost);

  String? localHostErrorText(String account, AppLocalizations l10n) {
    final bool showErrorText = !canSubmitLocalHost(account);
    return showErrorText ? l10n.incorrectInputFormat : null;
  }
}
