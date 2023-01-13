import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterprint/features/authentication/authentication.dart';
import 'package:flutterprint/services/local_storage/local_storage.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  final authRepository = ref.watch(authRepoProvider);
  final secureStorageRepository = ref.watch(secureRepositoryProvider);
  final sharedPreferenceRepository = ref.watch(sharedPreferenceRepoProvider);
  return AuthController(
    authRepository,
    secureStorageRepository,
    sharedPreferenceRepository,
    ref,
  );
});

// This provider holds the account token, which will be read by remote service
// And its state will only be manipulated in AuthStateController
final accountTokenProvider = StateProvider<String?>((ref) => null);

final staySignedInProvider = StateProvider<bool>((ref) => false);

class AuthController extends StateNotifier<AuthState> {
  AuthController(
    this.authRepository,
    this.secureRepository,
    this.sharedPreferenceRepository,
    this.ref,
  ) : super(const AuthState.unknown());
  final AuthRepository authRepository;
  final SecureRepository secureRepository;
  final SharedPreferenceRepository sharedPreferenceRepository;
  final Ref ref;

  Future<void> authentication() async {
    state = const AuthState.authenticating();

    var shouldStaySignedIn = sharedPreferenceRepository.getStaySignedIn();
    ref.read(staySignedInProvider.notifier).state = shouldStaySignedIn;
    var authInfo = await secureRepository.getAuthInfo();

    if (!shouldStaySignedIn || !authInfo.hasToken) {
      await signOut();
      return;
    }

    // Inject the token to accountTokenProvider, such that the rest api service can read from it.
    ref.read(accountTokenProvider.notifier).state = authInfo.accessToken;

    // * TBD: The app could be designed to check the token's expiration time
    // before making an API call and refresh it if it is close to expiring.
    // It depends on the specific requirements of the app and the authorization server that issues the access tokens.
    final result = await authRepository.refreshToken();

    return await result.fold(
      (apiFailure) async {
        await apiFailure.maybeWhen(unauthorized: (_) async {
          await signOut();
        }, orElse: () async {
          state = AuthState.failure(apiFailure);
        });
      },
      (authInfo) async {
        ref.read(accountTokenProvider.notifier).state = authInfo.accessToken;
        await secureRepository.saveAuthInfo(authInfo);
        state = const AuthState.authenticated();
      },
    );
  }

  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    state = const AuthState.authenticating();

    final failureOrSuccess = await authRepository.signIn(
      username: username,
      password: password,
    );

    return failureOrSuccess.fold(
      (apiFailure) {
        state = AuthState.failure(apiFailure);
      },
      (authInfo) async {
        ref.read(accountTokenProvider.notifier).state = authInfo.accessToken;
        await secureRepository.saveAuthInfo(authInfo);
        state = const AuthState.authenticated();
      },
    );
  }

  Future<bool> updateStaySignedIn(bool value) async {
    ref.read(staySignedInProvider.notifier).state = value;
    return await sharedPreferenceRepository.setStaySignedIn(value);
  }

  Future<void> signOut() async {
    ref.read(accountTokenProvider.notifier).state = null;
    await secureRepository.deleteAuthInfo();
    state = const AuthState.unauthenticated();
  }
}
