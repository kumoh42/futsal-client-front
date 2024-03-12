import 'package:flutter_client_front/auth/provider/auth_provider.dart';
import 'package:flutter_client_front/auth/view/login_view.dart';
import 'package:flutter_client_front/common/view/root_tab.dart';
import 'package:flutter_client_front/common/view/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final provider = ref.read(authProvider);
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/',
        name: RootTab.routeName,
        builder: (context, state) => const RootTab(),
      ),
      GoRoute(
        path: '/splash',
        name: SplashScreen.routeName,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: LoginView.routeName,
        builder: (context, state) => const LoginView(),
      ),
    ],
    refreshListenable: provider,
    redirect: provider.redirectLogic,
  );
});
