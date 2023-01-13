import 'package:{{project_name.snakeCase()}}/features/authentication/authentication.dart';
import 'package:{{project_name.snakeCase()}}/services/rest_api_service/rest_api_service.dart';

class FakeAuthRepository implements AuthRepository {
  const FakeAuthRepository({this.addDelay = true});
  final bool addDelay;
  final fakeAuthInfo = const AuthInfo(
    accessToken: 'foo',
  );

  @override
  Future<Either<ApiFailure, AuthInfo>> refreshToken() async {
    if (addDelay) {
      await Future<void>.delayed(const Duration(seconds: 1));
    }
    return Right(fakeAuthInfo);
  }

  @override
  Future<Either<ApiFailure, AuthInfo>> signIn({
    required String username,
    required String password,
  }) async {
    if (addDelay) {
      await Future<void>.delayed(const Duration(seconds: 1));
    }
    return Right(fakeAuthInfo);
    // return left(const ApiFailure.forbidden());
  }
}
