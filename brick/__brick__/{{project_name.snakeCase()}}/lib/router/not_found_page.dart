import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/constant/app_sizes.dart';
import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';
import 'package:{{project_name.snakeCase()}}/router/app_router.dart';

class NotFoundPage extends ConsumerWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                l10n.pageNotFound,
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              gapH32,
              TextButton.icon(
                onPressed: () =>
                    ref.read(appRouterProvider).go(AppRoute.home.path),
                icon: const Icon(
                  Icons.home_outlined,
                  size: Sizes.p24,
                ),
                label: Text(
                  l10n.homePageAppBarTitle,
                  style: const TextStyle(fontSize: Sizes.p20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
