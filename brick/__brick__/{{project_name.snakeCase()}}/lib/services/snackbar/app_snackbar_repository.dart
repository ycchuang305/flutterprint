import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/constant/app_sizes.dart';
import 'package:{{project_name.snakeCase()}}/constant/theme/theme.dart';

final appSnackBarRepoProvider = Provider((ref) => AppSnackBarRepository(ref));

class AppSnackBarRepository {
  final Ref ref;

  const AppSnackBarRepository(this.ref);

  /// Clear snackbars based on the given [context]
  void clearSnackbars(BuildContext context) =>
      ScaffoldMessenger.of(context).clearSnackBars();

  /// Show a snackbar based on the given [context]
  void showSnackbar(
    BuildContext context, {
    required String message,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    bool overlayOther = true,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (overlayOther) {
      ScaffoldMessenger.of(context).clearSnackBars();
    }
    final colorScheme = context.colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.all(Sizes.p32),
        padding: EdgeInsets.zero,
        content: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.p12,
            horizontal: Sizes.p16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      message,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: colorScheme.surface),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        duration: duration,
      ),
    );
  }
}
