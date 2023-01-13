import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/services/local_storage/data/shared_preference_repository.dart';

final themeModeControllerProvider =
    AutoDisposeNotifierProvider<ThemeModeController, ThemeMode>(
        ThemeModeController.new);

class ThemeModeController extends AutoDisposeNotifier<ThemeMode> {
  @override
  ThemeMode build() => ref.read(sharedPreferenceRepoProvider).getThemeMode();

  Future<bool> toggleAndSaveThemeMode() async {
    final themeMode =
        state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    state = themeMode;
    return await ref.read(sharedPreferenceRepoProvider).setThemeMode(themeMode);
  }
}
