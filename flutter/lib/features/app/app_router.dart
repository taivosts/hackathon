import 'dart:async';
import 'package:ai_dreamer/features/login/login_page.dart';
import 'package:ai_dreamer/network/repositories/authentication_repository.dart';
import 'package:ai_dreamer/resource/app_constants.dart';
import 'package:ai_dreamer/utils/app_logger.dart';
import 'package:ai_dreamer/utils/fade_transition_page.dart';
import 'package:ai_dreamer/utils/slide_transition_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_dreamer/features/common/navigation_service.dart';
import 'package:ai_dreamer/features/authentication/bloc/authentication_bloc.dart';
import '../feature.dart';

class AppRouterFactory {
  static GoRouter createRouter(BuildContext context) {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          redirect: (_, __) => HomePage.path,
        ),
        GoRoute(
          path: HomePage.path,
          parentNavigatorKey: NavigationService.navigatorKey,
          pageBuilder: (context, state) {
            return const SlideTransitionPage(child: HomePage());
          },
          routes: const [],
        ),
        GoRoute(
          parentNavigatorKey: NavigationService.navigatorKey,
          path: GetStartedPage.path,
          pageBuilder: (context, state) =>
              const FadeTransitionPage(child: GetStartedPage()),
          routes: [
            GoRoute(
              path: LoginPage.path,
              builder: (context, state) => const LoginPage(),
            )
          ],
        ),
        GoRoute(
          path: SplashPage.path,
          builder: (context, state) => const SplashPage(),
        ),
      ],
      redirect: (context, state) {
        // For debug single UI
        if (AppConstants.isDebugUI) {
          return [GetStartedPage.path].join("/");
        }
        // End debug

        AppLogger.logDebug('Redirect: ${state.fullPath}');
        // Set default status bar style is light
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        );

        final bool isLaunching = state.fullPath == SplashPage.path;
        final bool isLoggedIn =
            state.fullPath?.contains(HomePage.path) ?? false;

        switch (context.read<AuthenticationBloc>().state.status) {
          case AuthenticationStatus.authenticated:
            return HomePage.path;
          case AuthenticationStatus.unauthenticated:
            if (isLaunching) {
              return GetStartedPage.path;
            } else if (isLoggedIn) {
              return [GetStartedPage.path, LoginPage.path].join("/");
            }
          case AuthenticationStatus.unknown:
            return SplashPage.path;
        }
        return null;
      },
      refreshListenable:
          GoRouterRefreshStream(context.read<AuthenticationBloc>().stream),
      navigatorKey: NavigationService.navigatorKey,
    );
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
