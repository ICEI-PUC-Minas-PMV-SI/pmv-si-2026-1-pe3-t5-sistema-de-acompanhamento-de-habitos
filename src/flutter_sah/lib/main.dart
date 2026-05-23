import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'core/theme/theme_controller.dart';
import 'data/http/mailtrap_client.dart';
import 'data/local/hive_audit_log_repository.dart';
import 'data/local/hive_auth_repository.dart';
import 'data/local/hive_bootstrap.dart';
import 'data/local/hive_category_repository.dart';
import 'data/local/hive_execution_log_repository.dart';
import 'data/local/hive_habit_repository.dart';
import 'data/local/hive_user_repository.dart';
import 'data/local/mailtrap_config_store.dart';
import 'data/local/onboarding_store.dart';
import 'data/local/password_reset_token_store.dart';
import 'data/notifications/notification_service.dart';
import 'data/widgets/home_widget_service.dart';
import 'data/repositories/audit_log_repository.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/category_repository.dart';
import 'data/repositories/execution_log_repository.dart';
import 'data/repositories/habit_repository.dart';
import 'data/repositories/user_repository.dart';
import 'features/auth/controllers/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveBootstrap.init();
  final themeController = ThemeController();
  await themeController.load();
  final notificationService = NotificationService();
  await notificationService.init();
  final homeWidgetService = HomeWidgetService();
  await homeWidgetService.init();

  runApp(
    MultiProvider(
      providers: [
        Provider<UserRepository>(create: (_) => HiveUserRepository()),
        Provider<CategoryRepository>(create: (_) => HiveCategoryRepository()),
        Provider<AuditLogRepository>(create: (_) => HiveAuditLogRepository()),
        Provider<HabitRepository>(create: (_) => HiveHabitRepository()),
        Provider<ExecutionLogRepository>(create: (_) => HiveExecutionLogRepository()),
        Provider<NotificationService>.value(value: notificationService),
        Provider<HomeWidgetService>.value(value: homeWidgetService),
        Provider<OnboardingStore>(create: (_) => OnboardingStore()),
        Provider<MailtrapConfigStore>(create: (_) => MailtrapConfigStore()),
        Provider<MailtrapClient>(create: (_) => MailtrapClient()),
        Provider<PasswordResetTokenStore>(create: (_) => PasswordResetTokenStore()),
        Provider<AuthRepository>(
          create: (ctx) => HiveAuthRepository(
            userRepo: ctx.read<UserRepository>(),
            habitRepo: ctx.read<HabitRepository>(),
            catRepo: ctx.read<CategoryRepository>(),
            execLogRepo: ctx.read<ExecutionLogRepository>(),
            notifications: ctx.read<NotificationService>(),
            mailtrapStore: ctx.read<MailtrapConfigStore>(),
            mailtrapClient: ctx.read<MailtrapClient>(),
            tokenStore: ctx.read<PasswordResetTokenStore>(),
          ),
        ),
        ChangeNotifierProvider<AuthController>(
          create: (ctx) => AuthController(
            ctx.read<AuthRepository>(),
            ctx.read<UserRepository>(),
            ctx.read<HomeWidgetService>(),
          ),
        ),
        ChangeNotifierProvider<ThemeController>.value(value: themeController),
      ],
      child: const SahApp(),
    ),
  );
}
