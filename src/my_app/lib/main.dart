import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterprint/constant/theme/theme.dart';
import 'package:flutterprint/features/theme_mode/application/theme_mode_controller.dart';
import 'package:flutterprint/l10n/l10n.dart';
import 'package:flutterprint/services/local_storage/local_storage.dart';
import 'package:flutterprint/routing/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final pref = await SharedPreferences.getInstance();
      final sharedPreferenceRepo = SharedPreferenceRepository(pref);

      FlutterError.onError = ((details) {
        // Catch synchronous error
        return log(details.exceptionAsString(), stackTrace: details.stack);
      });

      runApp(
        ProviderScope(
          overrides: [
            sharedPreferenceRepoProvider
                .overrideWithValue(sharedPreferenceRepo),
          ],
          child: const AppWidget(),
        ),
      );
    },
    (error, stackTrace) {
      // Catch asynchronous error
      return log(error.toString(), stackTrace: stackTrace);
    },
  );
}

class AppWidget extends ConsumerWidget {
  const AppWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeControllerProvider);
    final router = ref.watch(appRouterProvider);
    return GestureDetector(
      onTap: () {
        // Dismiss the soft keyboard by tapping outside of a form field.
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          // textTheme: textTheme,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          // textTheme: textTheme,
        ),
        themeMode: themeMode,
      ),
    );
  }
}
