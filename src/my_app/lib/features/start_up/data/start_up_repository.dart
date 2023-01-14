import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterprint/features/authentication/authentication.dart';
import 'package:flutterprint/features/backend_environment/backend_environment.dart';
import 'package:flutterprint/services/local_storage/local_storage.dart';

final startUpRepositoryProvider =
    Provider.autoDispose((ref) => StartUpRepository(ref));

class StartUpRepository {
  const StartUpRepository(this.ref);
  final Ref ref;

  Future<void> prepareAuthentication() async {
    // Considering add more setup method here only if it has to be done before authenticating

    // Validate secure storage
    await ref.read(secureRepositoryProvider).validateSecureStorage();

    // Setup backend host environment
    ref.read(hostControllerProvider.notifier).setUpHost();

    // Start authentication
    ref.read(authControllerProvider.notifier).authentication();
  }
}
