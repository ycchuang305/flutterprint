import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:{{project_name.snakeCase()}}/features/backend_environment/backend_environment.dart';
import 'package:{{project_name.snakeCase()}}/services/local_storage/local_storage.dart';

final hostControllerProvider =
    StateNotifierProvider<HostController, Host>((ref) {
  final sharedPreferenceRepository = ref.watch(sharedPreferenceRepoProvider);
  return HostController(sharedPreferenceRepository);
});

class HostController extends StateNotifier<Host> {
  HostController(this.sharedPreferenceRepository) : super(const Host());

  final SharedPreferenceRepository sharedPreferenceRepository;

  void setUpHost() => state = _getHost(sharedPreferenceRepository.hostKey);

  Future<void> update({required String hostKey}) async {
    if (hostKey.isNotEmpty) {
      await sharedPreferenceRepository.updateHostKey(hostKey);
    } else {
      await sharedPreferenceRepository.removeHostKey();
    }
    state = _getHost(hostKey);
  }

  Host _getHost(String key) {
    final backendEnv =
        BackendEnv.values.firstWhereOrNull((env) => env.hostKey == key);
    return Host(
      backendEnv: backendEnv,
      localHost: backendEnv == null ? key : '',
    );
  }
}
