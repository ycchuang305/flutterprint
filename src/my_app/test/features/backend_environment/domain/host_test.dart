import 'package:flutterprint/features/backend_environment/backend_environment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    '[Host]',
    () {
      test(
        'Verifies that the correct URL is retrieved in the release environment from the default Host constructor, '
        'also checks that the host is not considered local',
        () {
          const host = Host();
          final signInUrl = host.getUri(Endpoint.signIn);
          expect(
            signInUrl,
            Uri(
              scheme: 'https',
              host: BackendEnv.release.baseUrl,
              path: Endpoint.signIn.path,
            ),
          );
          expect(host.isLocal, false);
        },
      );

      test(
        'Verifies that the correct URL is retrieved in the demo environment from a demo Host, '
        'also checks that the host is not considered local',
        () {
          const host = Host(backendEnv: BackendEnv.demo);
          final signInUrl = host.getUri(Endpoint.signIn);
          expect(
            signInUrl,
            Uri(
              scheme: 'https',
              host: BackendEnv.demo.baseUrl,
              path: Endpoint.signIn.path,
            ),
          );
          expect(host.isLocal, false);
        },
      );

      test(
        'Verifies that the correct URL is retrieved in the develop environment from a develop Host, '
        'also checks that the host is not considered local',
        () {
          const host = Host(backendEnv: BackendEnv.develop);
          final signInUrl = host.getUri(Endpoint.signIn);
          expect(
            signInUrl,
            Uri(
              scheme: 'https',
              host: BackendEnv.develop.baseUrl,
              path: Endpoint.signIn.path,
            ),
          );
          expect(host.isLocal, false);
        },
      );

      test(
        'Verifies that the correct URL is retrieved for the local environment using the given local host and port 8000 for the Endpoint.signIn path. '
        'Also verifies that the host is recognized as being local',
        () {
          const port = 8080;
          const hostName = '192.168.0.233';
          const host = Host(localHost: '$hostName:$port');
          final signInUrl = host.getUri(Endpoint.signIn);
          expect(
            signInUrl,
            Uri(
              scheme: 'http',
              host: hostName,
              path: Endpoint.signIn.path,
              port: port,
            ),
          );
          expect(host.isLocal, true);
        },
      );

      test(
        "Verifies that the correct banner name is retrieved when the host's backend environment is set to demo.",
        () {
          const host = Host(backendEnv: BackendEnv.demo);
          expect(host.bannerName, BackendEnv.demo.appBanner);
        },
      );
    },
  );
}
