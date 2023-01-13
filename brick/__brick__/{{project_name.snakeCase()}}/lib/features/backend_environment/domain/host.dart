import 'package:{{project_name.snakeCase()}}/features/backend_environment/backend_environment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'host.freezed.dart';

@freezed
class Host with _$Host {
  const Host._();
  const factory Host({
    BackendEnv? backendEnv,
    @Default('') String localHost,
  }) = _Host;

  String get baseUrl =>
      isLocal ? localHost : backendEnv?.baseUrl ?? BackendEnv.release.baseUrl;
  bool get isLocal => localHost.isNotEmpty;

  Uri getUri(
    Endpoint endpoint, {
    Map<String, dynamic>? queryParameters,
    String? path,
  }) {
    var selectedbaseUrl = isLocal ? baseUrl.split(':').first : baseUrl;
    var port = isLocal ? int.tryParse(baseUrl.split(':').last) ?? 8000 : null;
    return Uri(
      scheme: isLocal ? 'http' : 'https',
      host: selectedbaseUrl,
      port: port,
      path: path == null ? endpoint.path : '${endpoint.path}/$path',
      queryParameters: queryParameters,
    );
  }

  String get bannerName {
    if (isLocal) {
      return 'local';
    }
    return backendEnv?.appBanner ?? '';
  }
}
