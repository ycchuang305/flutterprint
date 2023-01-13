import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterprint/features/theme_mode/application/theme_mode_controller.dart';
import 'package:flutterprint/services/local_storage/local_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Future<ProviderContainer> makeProviderContainer({
    Map<String, Object> mockSharedPrefValues = const {},
  }) async {
    SharedPreferences.setMockInitialValues(mockSharedPrefValues);
    final sharedPreferences = await SharedPreferences.getInstance();
    final sharedPrefRepository = SharedPreferenceRepository(sharedPreferences);
    final container = ProviderContainer(
      overrides: [
        sharedPreferenceRepoProvider.overrideWithValue(sharedPrefRepository),
      ],
    );
    // Destroy the state of all providers associated with this container
    addTearDown(container.dispose);
    return container;
  }

  group(
    '[ThemeModeController]',
    () {
      late ProviderContainer container;
      test(
        'The default theme mode is set to ThemeMode.light if no theme mode value is saved in shared preferences',
        () async {
          container = await makeProviderContainer();
          var themeMode = container.read(themeModeControllerProvider);
          expect(themeMode, ThemeMode.light);
        },
      );

      test(
        'The default theme mode is set to ThemeMode.dark when the corresponding shared preference value is dark',
        () async {
          container = await makeProviderContainer(mockSharedPrefValues: {
            SharedPreferenceRepository.prefAppThemeMode: ThemeMode.dark.name,
          });
          var themeMode = container.read(themeModeControllerProvider);
          expect(themeMode, ThemeMode.dark);
        },
      );

      test(
        'The state should transition from light to dark after calling toggleThemeMode()',
        () async {
          container = await makeProviderContainer();
          var themeMode = container.read(themeModeControllerProvider);
          expect(themeMode, ThemeMode.light);
          await container
              .read(themeModeControllerProvider.notifier)
              .toggleAndSaveThemeMode();
          themeMode = container.read(themeModeControllerProvider);
          expect(themeMode, ThemeMode.dark);
        },
      );
    },
  );
}
