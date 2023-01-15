import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';
import 'package:{{project_name.snakeCase()}}/services/rest_api_service/domain/api_failure.dart';
import 'package:{{project_name.snakeCase()}}/services/snackbar/app_snackbar_repository.dart';

export 'data/rest_api_service.dart';
export 'data/rest_api_service_impl.dart';
export 'domain/token_type.dart';
export 'domain/api_failure.dart';
export 'domain/api_method.dart';
export 'domain/api_status.dart';
export 'package:dartz/dartz.dart';

extension ApiFailureX on ApiFailure {
  void showPredefinedSnackbar({
    required BuildContext context,
    required WidgetRef ref,
  }) =>
      ref.read(appSnackBarRepoProvider).showSnackbar(
            context,
            message: when(
              apiAgreementConflict: () => '',
              badRequest: (_) => context.l10n.badRequest,
              forbidden: (_) => context.l10n.forbidden,
              socket: (_) => context.l10n.socket,
              notFound: (_) => context.l10n.notFound,
              serviceUnavailable: (_) => context.l10n.serviceUnavailable,
              timeout: (_) => context.l10n.timeout,
              unauthorized: (_) => context.l10n.unauthorized,
              undefined: (statusCode, _) => context.l10n.unknown(statusCode),
            ),
          );
}
