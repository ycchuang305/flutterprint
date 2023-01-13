import 'package:flutterprint/features/authentication/domain/auth_info.dart';
import 'package:flutterprint/services/local_storage/data/secure_storage_repository.dart';

class FakeSecureStorageRepository implements SecureRepository {
  const FakeSecureStorageRepository();

  @override
  Future<void> deleteAll() => Future.value(null);

  @override
  Future<void> deleteAuthInfo() => Future.value(null);

  @override
  Future<AuthInfo> getAuthInfo() => Future.value(const AuthInfo(
        accessToken: 'foo',
      ));

  @override
  Future<void> saveAuthInfo(AuthInfo authInfo) => Future.value(null);

  @override
  Future<void> validateSecureStorage() => Future.value(null);
}
