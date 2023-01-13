/// [hostKey] is a key used to stored in shared preference
/// [baseUrl] is the base url/domain name of your server
/// [appBanner] is a label that indicates the current backend environment
enum BackendEnv {
  // TODO: Manage your backend environments configurations
  release(
    hostKey: '@release',
    baseUrl: 'release.example.com',
    appBanner: '',
  ),
  demo(
    hostKey: '@demo',
    baseUrl: 'demo.example.com',
    appBanner: 'demo',
  ),
  develop(
    hostKey: '@develop',
    baseUrl: 'develop.example.com',
    appBanner: 'develop',
  );

  final String hostKey;
  final String baseUrl;
  final String appBanner;
  const BackendEnv({
    required this.hostKey,
    required this.baseUrl,
    required this.appBanner,
  });
}
