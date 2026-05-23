import 'package:go_router/go_router.dart';
import '../../features/admin/categories/screens/categories_screen.dart';
import '../../features/admin/dashboard/screens/admin_dashboard_screen.dart';
import '../../features/admin/logs/screens/logs_screen.dart';
import '../../features/admin/shell/admin_shell.dart';
import '../../features/admin/users/screens/users_screen.dart';
import '../../features/auth/controllers/auth_controller.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/recover_screen.dart';
import '../../features/auth/screens/recover_sent_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/auth/screens/reset_password_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/system_states/error_screen.dart';
import '../../features/user_home/backup/screens/backup_screen.dart';
import '../../data/local/onboarding_store.dart';
import '../../features/system_states/splash_screen.dart';
import '../../features/user_home/categories/screens/user_categories_screen.dart';
import '../../features/user_home/screens/history_screen.dart';
import '../../features/user_home/screens/profile_screen.dart';
import '../../features/user_home/habits/screens/habits_screen.dart';
import '../../features/user_home/today/screens/today_screen.dart';
import '../../features/user_home/shell/user_shell.dart';
import 'guards.dart';
import 'routes.dart';

GoRouter buildRouter(
  AuthController authController,
  OnboardingStore onboardingStore,
) {
  final guards = AppGuards(authController, onboardingStore);

  return GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: authController,
    redirect: (context, state) => guards.appRedirect(state),
    errorBuilder: (context, state) => ErrorScreen(
      message: state.error?.message,
      refCode: 'ROUTE_${state.matchedLocation.replaceAll('/', '_').toUpperCase()}',
    ),
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.signup,
        builder: (_, __) => const SignupScreen(),
      ),
      GoRoute(
        path: Routes.recover,
        builder: (_, __) => const RecoverScreen(),
      ),
      GoRoute(
        path: Routes.recoverSent,
        builder: (_, __) => const RecoverSentScreen(),
      ),
      GoRoute(
        path: Routes.resetPassword,
        builder: (_, __) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: Routes.onboarding,
        builder: (_, __) => const OnboardingScreen(),
      ),
      GoRoute(
        path: Routes.backup,
        builder: (_, __) => const BackupScreen(),
      ),
      // Admin shell (4 branches)
      StatefulShellRoute.indexedStack(
        builder: (_, __, shell) => AdminShell(navigationShell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.adminDashboard,
                builder: (_, __) => const AdminDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.adminUsers,
                builder: (_, __) => const UsersScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.adminCategories,
                builder: (_, __) => const CategoriesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.adminLogs,
                builder: (_, __) => const LogsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: Routes.userCategories,
        builder: (_, __) => const UserCategoriesScreen(),
      ),
      // User shell (4 branches)
      StatefulShellRoute.indexedStack(
        builder: (_, __, shell) => UserShell(navigationShell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.userToday,
                builder: (_, __) => const TodayScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.userHabits,
                builder: (_, __) => const HabitsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.userHistory,
                builder: (_, __) => const HistoryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.userProfile,
                builder: (_, __) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
