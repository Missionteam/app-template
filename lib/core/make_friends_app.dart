import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:make_friends_app/config/app_router.dart';
import 'package:make_friends_app/modules/auth/auth.repository.dart';

class MakeFriendsApp extends ConsumerWidget {
  const MakeFriendsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    return MaterialApp.router(
      routerConfig: appRouter,
      title: "Make Friends App",
    );
  }
}

class MainRoot extends ConsumerWidget {
  const MainRoot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(authUserProvider);

    if (userAsyncValue.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (userAsyncValue.value == null) {
      return const Center(
        child: Text('Welcome to Make Friends App!'),
      );
    }

    AppRouterService.goHome(context);

    return Container();
  }
}
