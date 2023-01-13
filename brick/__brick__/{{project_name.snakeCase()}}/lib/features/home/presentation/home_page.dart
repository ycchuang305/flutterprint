import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/constant/app_sizes.dart';
import 'package:{{project_name.snakeCase()}}/constant/theme/theme.dart';
import 'package:{{project_name.snakeCase()}}/features/authentication/authentication.dart';
import 'package:{{project_name.snakeCase()}}/features/theme_mode/application/theme_mode_controller.dart';
import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  static const signOutKey = Key('signOut');
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = ref.watch(themeModeControllerProvider);
    final colorScheme = context.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(l10n.homePageAppBarTitle),
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
      body: Center(
        child: TextButton.icon(
          key: HomePage.signOutKey,
          onPressed: () => ref.read(authControllerProvider.notifier).signOut(),
          icon: const Icon(
            Icons.logout_outlined,
            size: Sizes.p24,
          ),
          label: Text(
            l10n.signOut,
            style: const TextStyle(fontSize: Sizes.p20),
          ),
        ),
      ),
    );
  }
}
