import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/constant/theme/theme.dart';
import 'package:{{project_name.snakeCase()}}/features/authentication/authentication.dart';
import 'package:{{project_name.snakeCase()}}/features/backend_environment/application/host_controller.dart';
import 'package:{{project_name.snakeCase()}}/services/local_storage/local_storage.dart';
import 'package:{{project_name.snakeCase()}}/services/rest_api_service/rest_api_service.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage>
    with AfterLayoutMixin<LandingPage> {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    // Considering add more logic here if there are something have to be done before authenticating
    await ref.read(secureRepositoryProvider).validateSecureStorage();
    ref.read(hostControllerProvider.notifier).init();
    ref.read(authControllerProvider.notifier).authentication();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(
      authControllerProvider,
      (_, state) {
        state.whenOrNull(
          failure: (apiFailure) =>
              apiFailure.showPredefinedSnackbar(context: context, ref: ref),
        );
      },
    );
    final colorScheme = context.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: const Center(
        child: FlutterLogo(
          size: 64,
        ),
      ),
    );
  }
}
