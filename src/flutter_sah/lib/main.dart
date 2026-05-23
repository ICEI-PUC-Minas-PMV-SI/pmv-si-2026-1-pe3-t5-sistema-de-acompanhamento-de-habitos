import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'core/error/error_reporter.dart';
import 'core/i18n/locale_controller.dart';
import 'core/theme/theme_controller.dart';
import 'data/backup/auto_backup_service.dart';
import 'data/backup/backup_service.dart';
import 'data/events/categories_bus.dart';
import 'data/events/habits_bus.dart';
import 'data/http/mailtrap_client.dart';
import 'data/local/audit_context.dart';
import 'data/local/hive_audit_log_repository.dart';
import 'data/local/hive_auth_repository.dart';
import 'data/local/hive_bootstrap.dart';
import 'data/local/hive_category_repository.dart';
import 'data/local/hive_execution_log_repository.dart';
import 'data/local/hive_habit_repository.dart';
import 'data/local/hive_user_repository.dart';
import 'data/local/login_attempt_store.dart';
import 'data/local/mailtrap_config_store.dart';
import 'data/local/onboarding_store.dart';
import 'data/local/password_reset_token_store.dart';
import 'data/notifications/notification_service.dart';
import 'data/repositories/audit_log_repository.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/category_repository.dart';
import 'data/repositories/execution_log_repository.dart';
import 'data/repositories/habit_repository.dart';
import 'data/repositories/user_repository.dart';
import 'data/widgets/home_widget_service.dart';
import 'features/auth/controllers/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorReporter.instance.install();
  // Usa apenas as fontes bundladas em assets/google_fonts/ — sem fetch online,
  // evita erros em emuladores/dispositivos sem internet ou com DNS bloqueado.
  GoogleFonts.config.allowRuntimeFetching = false;
  await initializeDateFormatting();
  await AuditContext.init();
  await HiveBootstrap.init();
  final themeController = ThemeController();
  await themeController.load();
  final localeController = LocaleController();
  await localeController.load();
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
        ChangeNotifierProvider<HabitsBus>(create: (_) => HabitsBus()),
        ChangeNotifierProvider<CategoriesBus>(create: (_) => CategoriesBus()),
        Provider<NotificationService>.value(value: notificationService),
        Provider<HomeWidgetService>.value(value: homeWidgetService),
        Provider<BackupService>(
          create: (ctx) => BackupService(
            userRepo: ctx.read<UserRepository>(),
            habitRepo: ctx.read<HabitRepository>(),
            catRepo: ctx.read<CategoryRepository>(),
            execLogRepo: ctx.read<ExecutionLogRepository>(),
            notifications: ctx.read<NotificationService>(),
          ),
        ),
        Provider<AutoBackupService>(
          create: (ctx) => AutoBackupService(ctx.read<BackupService>()),
        ),
        Provider<OnboardingStore>(create: (_) => OnboardingStore()),
        Provider<MailtrapConfigStore>(create: (_) => MailtrapConfigStore()),
        Provider<MailtrapClient>(create: (_) => MailtrapClient()),
        Provider<PasswordResetTokenStore>(create: (_) => PasswordResetTokenStore()),
        Provider<LoginAttemptStore>(create: (_) => LoginAttemptStore()),
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
            loginAttempts: ctx.read<LoginAttemptStore>(),
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
        ChangeNotifierProvider<LocaleController>.value(value: localeController),
      ],
      child: const SahApp(),
    ),
  );
}
