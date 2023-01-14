import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterprint/constant/theme/theme.dart';
import 'package:flutterprint/features/authentication/authentication.dart';
import 'package:flutterprint/features/start_up/data/start_up_repository.dart';
import 'package:flutterprint/services/rest_api_service/rest_api_service.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with AfterLayoutMixin<SplashPage> {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) =>
      ref.read(startUpRepositoryProvider).prepareAuthentication();

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
