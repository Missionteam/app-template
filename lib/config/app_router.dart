import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:make_friends_app/core/scaffold_with_nav_bar.dart';
import 'package:make_friends_app/modules/auth/auth.repository.dart';
import 'package:make_friends_app/modules/auth/auth.service.dart';
import 'package:make_friends_app/modules/user/user.repository.dart';
import 'package:make_friends_app/screens/feedback/feedback_screen.dart';
import 'package:make_friends_app/screens/home/home_screen.dart';
import 'package:make_friends_app/screens/quick_request/quick_request_screen.dart';
import 'package:make_friends_app/screens/signup/register_screen.dart';
import 'package:make_friends_app/screens/signup/signup_sreen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class AppPath {
  static const home = '/home';
  static const quickRequest = '/quickRequest';
  static const feedBack = '/feedback';
  static const signUp = '/signup';
  static const register = '/register';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authUserProvider);
  final currentUser = ref.watch(currentUserProvider).value;
  final initialLocation =
      AuthService.fetchInitPathByAuthState(authState, currentUser);
  return appRouter(initialLocation: initialLocation);
});

GoRouter appRouter({String? initialLocation}) {
  return GoRouter(
    initialLocation: initialLocation,
    debugLogDiagnostics: true,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            initialLocation: AppPath.quickRequest,
            routes: [
              GoRoute(
                path: AppPath.quickRequest,
                builder: (context, state) {
                  return QuickRequesatScreen();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            initialLocation: AppPath.home,
            routes: [
              GoRoute(
                path: AppPath.home,
                builder: (context, state) {
                  return HomeSreen();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            initialLocation: AppPath.feedBack,
            routes: [
              GoRoute(
                path: AppPath.feedBack,
                builder: (context, state) {
                  return FeedbackScreen();
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppPath.signUp,
        builder: (context, state) => SignUpSreen(),
      ),
      GoRoute(
        path: AppPath.register,
        builder: (context, state) => RegisterScreen(),
      ),
    ],
  );
}

class AppRouterService {
  static void goHome(BuildContext context) {
    GoRouter.of(context).go(AppPath.home);
  }
}
