import 'package:vacoworking/core/global_functions.dart';
import 'package:vacoworking/core/global_variables.dart';
import 'package:vacoworking/generated/l10n.dart';
import 'package:vacoworking/page/detail/details_screen.dart';
import 'package:vacoworking/page/home/home_page.dart';
import 'package:vacoworking/page/map/map_screen.dart';
import 'package:vacoworking/page/users/account_profile_page.dart';
import 'package:vacoworking/page/home/splash_screen_page.dart';
import 'package:vacoworking/page/login/forgot_password_page.dart';
import 'package:vacoworking/page/login/login_page.dart';
import 'package:vacoworking/page/login/register_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vacoworking/api/mock/mock_data.dart';

import 'app_routes.dart';

GoRouter createAppRouter(GlobalKey<NavigatorState> navigatorKey) {
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutes.splash,    //pantalla de bienvenida
    redirect: (context, state) async {    //redirige a la ruta correcta, se ejecuta antes que se muestre cualquier pantalla
      final location = state.uri.path;    //ruta que se intenta abrir
      const authRoutes = <String>{
        AppRoutes.login,
        AppRoutes.register,
        AppRoutes.forgotPassword,
      };
      // Modo invitado permitido:
      // - En splash intentamos restaurar sesión si hay token.
      // - Si no hay sesión, no forzamos login; la app entra igualmente en Home.
      if (location == AppRoutes.splash && globalCurrentUser.username.isEmpty) {
        await loginUser();
      }
      if (globalCurrentUser.username.isNotEmpty && authRoutes.contains(location)) {
        return AppRoutes.home;
      }
      return null;  //null = deja pasar, si retornamos una ruta redirige a esa ruta
    },
    routes: [
      GoRoute( //mapea URL a Widget
        path: AppRoutes.splash,                            //URL
        builder: (_, __) => const SplashScreenPage(),      //Widget (pagina)
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (_, __) => const RegisterPage(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (_, __) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.accountProfile,
        builder: (_, __) => const AccountProfilePage(),
      ),
      GoRoute(
        path: AppRoutes.details,
        builder: (_, __) => DetailsScreen(coworking: mockCoworkings[0]),
      ),
      GoRoute(
       path: AppRoutes.map,
        builder: (_, __) => const MapScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64),
            const SizedBox(height: 16),
            Text(state.uri.path),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: Text(S.current.goToHome),
            ),
          ],
        ),
      ),
    ),
  );
}


