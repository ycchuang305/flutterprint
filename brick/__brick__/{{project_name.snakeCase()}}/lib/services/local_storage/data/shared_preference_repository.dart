import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/features/backend_environment/backend_environment.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferenceRepoProvider =
    Provider<SharedPreferenceRepository>((ref) {
  // The value from this repository will be overriden in main method
  // after instantiating Shared Preferences
  throw UnimplementedError();
});

/// Develop enviornment repository
class SharedPreferenceRepository {
  final SharedPreferences _pref;

  const SharedPreferenceRepository(this._pref);

  static const prefHostKey = 'hostKey';
  static const prefValidSecureStorageKey = 'validSecureStorage';
  static const prefStaySignedInKey = 'staySignedIn';
  static const prefAppThemeMode = 'appThemeMode';

  String get hostKey =>
      _pref.getString(prefHostKey)?.trim() ?? BackendEnv.release.hostKey;

  Future<bool> updateHostKey(String host) => _pref.setString(prefHostKey, host);

  Future<bool> removeHostKey() => _pref.remove(prefHostKey);

  bool isSecureStorageValid() =>
      _pref.getBool(prefValidSecureStorageKey) ?? false;

  Future<bool> setSecureStorageAsValid() =>
      _pref.setBool(prefValidSecureStorageKey, true);

  Future<bool> setStaySignedIn(bool value) =>
      _pref.setBool(prefStaySignedInKey, value);

  bool getStaySignedIn() => _pref.getBool(prefStaySignedInKey) ?? false;

  Future<bool> setThemeMode(ThemeMode themeMode) async {
    return await _pref.setString(prefAppThemeMode, themeMode.name);
  }

  ThemeMode getThemeMode() {
    final themeName = _pref.getString(prefAppThemeMode);
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == themeName,
      orElse: () => ThemeMode.light,
    );
  }
}
