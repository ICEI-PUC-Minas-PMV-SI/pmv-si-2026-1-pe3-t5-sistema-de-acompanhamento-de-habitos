import 'package:go_router/go_router.dart';
import '../../data/local/onboarding_store.dart';
import '../../features/auth/controllers/auth_controller.dart';
import 'routes.dart';

class AppGuards {
  final AuthController _auth;
  final OnboardingStore _onboarding;

  const AppGuards(this._auth, this._onboarding);

  String? appRedirect(GoRouterState state) {
    final loc = state.matchedLocation;
    final status = _auth.status;

    // Boot: fica no splash enquanto o AuthController ainda não sabe o status
    if (status == AuthStatus.unknown) {
      return loc == Routes.splash ? null : Routes.splash;
    }

    // Depois do boot, sai do splash para o destino correto
    if (loc == Routes.splash) {
      if (status == AuthStatus.authenticated) {
        if (_auth.isAdmin) return Routes.adminDashboard;
        final userId = _auth.currentUser?.id;
        if (userId != null && !_onboarding.isCompleted(userId)) {
          return Routes.onboarding;
        }
        return Routes.userToday;
      }
      return Routes.login;
    }

    final isAuthRoute = loc.startsWith('/login') ||
        loc.startsWith('/signup') ||
        loc.startsWith('/recover');

    if (status == AuthStatus.unauthenticated) {
      return isAuthRoute ? null : Routes.login;
    }

    // autenticado
    if (isAuthRoute) {
      if (_auth.isAdmin) return Routes.adminDashboard;
      final userId = _auth.currentUser?.id;
      if (userId != null && !_onboarding.isCompleted(userId)) {
        return Routes.onboarding;
      }
      return Routes.userToday;
    }

    if (loc.startsWith('/app')) {
      final userId = _auth.currentUser?.id;
      if (userId != null && !_onboarding.isCompleted(userId)) {
        return Routes.onboarding;
      }
    }

    if (!_auth.isAdmin && loc.startsWith('/admin')) {
      return Routes.userToday;
    }

    return null;
  }
}
