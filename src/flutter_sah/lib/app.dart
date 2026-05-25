import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'core/design_system/theme/sah_theme.dart';
import 'core/design_system/tokens/sah_colors.dart';
import 'core/design_system/tokens/sah_palette.dart';
import 'core/design_system/tokens/sah_palette_scope.dart';
import 'core/error/error_reporter.dart';
import 'core/i18n/locale_controller.dart';
import 'core/routing/app_router.dart';
import 'core/theme/theme_controller.dart';
import 'data/local/audit_context.dart';
import 'data/local/onboarding_store.dart';
import 'features/auth/controllers/auth_controller.dart';
import 'l10n/app_localizations.dart';

class SahApp extends StatefulWidget {
  const SahApp({super.key});

  @override
  State<SahApp> createState() => _SahAppState();
}

class _SahAppState extends State<SahApp> with WidgetsBindingObserver {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = buildRouter(
      context.read<AuthController>(),
      context.read<OnboardingStore>(),
    );
    _router.routerDelegate.addListener(_onRouteChange);
    WidgetsBinding.instance.addObserver(this);
  }

  void _onRouteChange() {
    final uri = _router.routerDelegate.currentConfiguration.uri;
    AuditContext.setRoute(uri.toString());
  }

  @override
  void dispose() {
    _router.routerDelegate.removeListener(_onRouteChange);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Rede pode ter mudado enquanto o app estava em background.
      AuditContext.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeCtrl = context.watch<ThemeController>();
    final localeCtrl = context.watch<LocaleController>();
    final systemBrightness = MediaQuery.platformBrightnessOf(context);
    final effective = switch (themeCtrl.mode) {
      ThemeMode.light  => Brightness.light,
      ThemeMode.dark   => Brightness.dark,
      ThemeMode.system => systemBrightness,
    };
    final palette =
        effective == Brightness.dark ? SahPalette.dark : SahPalette.light;
    setActiveSahPalette(palette);

    return SahPaletteScope(
      palette: palette,
      child: MaterialApp.router(
        title: 'SAH',
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: ErrorReporter.instance.messengerKey,
        theme: SahTheme.light(),
        darkTheme: SahTheme.dark(),
        themeMode: themeCtrl.mode,
        routerConfig: _router,
        builder: (context, child) {
          return SahPaletteScope(palette: palette, child: child!);
        },
        localizationsDelegates: AppL10n.localizationsDelegates,
        locale: localeCtrl.locale,
        supportedLocales: AppL10n.supportedLocales,
      ),
    );
  }
}
