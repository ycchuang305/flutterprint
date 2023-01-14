import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/features/backend_environment/presentation/backend_environment_setting_page.dart';
import 'package:{{project_name.snakeCase()}}/features/home/presentation/home_page.dart';
import 'package:{{project_name.snakeCase()}}/features/start_up/presentation/splash_page.dart';
import 'package:{{project_name.snakeCase()}}/router/not_found_page.dart';
import 'package:{{project_name.snakeCase()}}/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/features/authentication/authentication.dart';

enum AppRoute {
  //TODO: Manage app route and its path
  home('/'),
  splash('/splash'),
  signIn('/signIn'),
  backendEnv('backendEnv'); // sub-route of sign-in page

  final String path;
  const AppRoute(this.path);
}

/// Caches and Exposes a [GoRouter]
final appRouterProvider = Provider<GoRouter>(
  (ref) {
    final router = AppRouterNotifier(ref);

    return GoRouter(
      debugLogDiagnostics: false,
      refreshListenable: router, // This notifiies `GoRouter` for refresh events
      redirect: router._redirectLogic, // All the logic is centralized here
      routes: router._routes, // All the routes can be found there
      initialLocation: AppRoute.home.path,
      errorBuilder: (context, state) => const NotFoundPage(),
    );
  },
);

class AppRouterNotifier extends ChangeNotifier {
  final Ref _ref;

  /// This implementation exploits `ref.listen()` to add a simple callback that
  /// calls `notifyListeners()` whenever there's change onto a desider provider.
  AppRouterNotifier(this._ref) {
    _ref.listen<AuthState>(
      authControllerProvider, // In our case, we're interested in the sign-in / sign-out events.
      (pre, cur) {
        if (pre != cur) {
          notifyListeners();
        }
      }, // Obviously more logic can be added here
    );
  }

  /// IMPORTANT: conceptually, we want to use `ref.read` to read providers, here.
  /// GoRouter is already aware of state changes through `refreshListenable`
  /// We don't want to trigger a rebuild of the surrounding provider.
  String? _redirectLogic(BuildContext context, GoRouterState routeState) {
    final authState = _ref.read(authControllerProvider);

    final onSignInRoutes = routeState.location.startsWith(AppRoute.signIn.path);
    final onSplashPage = routeState.location == AppRoute.splash.path;

    String? redirectPath = authState.maybeWhen(
      unknown: () => onSplashPage ? null : AppRoute.splash.path,
      unauthenticated: () => onSignInRoutes ? null : AppRoute.signIn.path,
      authenticated: () {
        if (onSignInRoutes || onSplashPage) {
          return AppRoute.home.path;
        }
        return null;
      },
      orElse: () => null,
    );
    return redirectPath;
  }

  //TODO: Manage routes
  List<RouteBase> get _routes => [
        GoRoute(
          name: AppRoute.splash.name,
          path: AppRoute.splash.path,
          builder: (_, __) => const SplashPage(),
        ),
        GoRouteBanner(
          name: AppRoute.home.name,
          path: AppRoute.home.path,
          builder: (_, __) => const HomePage(),
        ),
        GoRouteBanner(
          name: AppRoute.signIn.name,
          path: AppRoute.signIn.path,
          builder: (_, __) => const SignInPage(),
          routes: [
            GoRouteBanner(
              name: AppRoute.backendEnv.name,
              path: AppRoute.backendEnv.path,
              builder: (_, __) => const BackendEnvironmentSettingPage(),
            ),
          ],
        ),
      ];
}

/// Wrap the child returned from [builder] with the [BackendEnvBanner]
class GoRouteBanner extends GoRoute {
  GoRouteBanner({
    super.name,
    required super.path,
    super.pageBuilder,
    GoRouterWidgetBuilder? builder,
    super.redirect,
    super.parentNavigatorKey,
    super.routes = const <RouteBase>[],
  }) : super(
          builder: (context, state) {
            final child = builder?.call(context, state);
            return BackendEnvBanner(child: child ?? const SizedBox());
          },
        );
}
