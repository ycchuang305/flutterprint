enum Endpoint {
  // TODO: Manage your api endpoints
  signIn('path/to/your/api/endpoint'),
  refreshToken('path/to/your/api/endpoint');

  const Endpoint(this.path);
  final String path;
}
