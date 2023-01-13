import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:{{project_name.snakeCase()}}/features/authentication/authentication.dart';
import 'package:{{project_name.snakeCase()}}/services/local_storage/data/shared_preference_repository.dart';

final secureRepositoryProvider = Provider<SecureRepository>((ref) {
  const secureStorage = FlutterSecureStorage();
  final sharedPrefRepo = ref.watch(sharedPreferenceRepoProvider);
  return SecureRepositoryImpl(secureStorage, sharedPrefRepo);
});

enum SecureStorageKey {
  authInfo,
  validStorage,
  staySignedIn,
}

abstract class SecureRepository {
  /// Verify if the data in secure storage if valid
  Future<void> validateSecureStorage();

  /// Save [authInfo] into secure storage
  Future<void> saveAuthInfo(AuthInfo authInfo);

  /// Retrive AuthInfo from secure storage
  Future<AuthInfo> getAuthInfo();

  /// Delete AuthInfo from secure storage
  Future<void> deleteAuthInfo();

  /// Delete all data from secure storage
  Future<void> deleteAll();
}

class SecureRepositoryImpl implements SecureRepository {
  final FlutterSecureStorage _secureStorage;
  final SharedPreferenceRepository _sharedPreferenceRepository;
  const SecureRepositoryImpl(
      this._secureStorage, this._sharedPreferenceRepository);

  AndroidOptions get _androidOptions => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  /// Validate if the data in secure storage was created in the app's life-cycle before uninstallation
  /// Since the data in keychain will still exist after uninstall the app
  /// Use a boolean in shared-preference to verify it
  /// false: the app is newly installed or has been uninstalled, delete all secure storage data and set the flag to true
  /// true: data is valid, ignore.
  @override
  Future<void> validateSecureStorage() async {
    if (!_sharedPreferenceRepository.isSecureStorageValid()) {
      await deleteAll();
      await _sharedPreferenceRepository.setSecureStorageAsValid();
    }
    return;
  }

  Future<void> _writeSecureData({
    required String key,
    required String value,
  }) =>
      _secureStorage.write(key: key, value: value, aOptions: _androidOptions);

  Future<String?> _readSecureData(String key) async {
    String? data;
    try {
      data = await _secureStorage.read(key: key, aOptions: _androidOptions);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      debugPrint(e.stacktrace);
      _secureStorage.deleteAll(aOptions: _androidOptions);
    }
    return data;
  }

  Future<void> _deleteSecureData(String key) =>
      _secureStorage.delete(key: key, aOptions: _androidOptions);

  @override
  Future<void> deleteAll() =>
      _secureStorage.deleteAll(aOptions: _androidOptions);

  @override
  Future<void> saveAuthInfo(AuthInfo authInfo) => _writeSecureData(
      key: SecureStorageKey.authInfo.name, value: authInfo.toSecureStorage);

  @override
  Future<AuthInfo> getAuthInfo() async {
    var authInfo = await _readSecureData(SecureStorageKey.authInfo.name);
    return authInfo == null
        ? AuthInfo.empty()
        : AuthInfo.fromSecureStorage(authInfo);
  }

  @override
  Future<void> deleteAuthInfo() =>
      _deleteSecureData(SecureStorageKey.authInfo.name);
}
