import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'core/design_system/theme/sah_theme.dart';
import 'core/design_system/tokens/sah_colors.dart';
import 'core/design_system/tokens/sah_palette.dart';
import 'core/design_system/tokens/sah_palette_scope.dart';
import 'core/routing/app_router.dart';
import 'core/theme/theme_controller.dart';
import 'data/local/onboarding_store.dart';
import 'features/auth/controllers/auth_controller.dart';

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
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeCtrl = context.watch<ThemeController>();
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
        theme: SahTheme.light(),
        darkTheme: SahTheme.dark(),
        themeMode: themeCtrl.mode,
        routerConfig: _router,
        builder: (context, child) {
          // Garante que toda página renderizada pelo router fique abaixo
          // do scope — necessário porque o GoRouter pode preservar identity
          // dos seus filhos e o InheritedWidget acima do MaterialApp não
          // chega aos descendentes do Navigator interno.
          return SahPaletteScope(palette: palette, child: child!);
        },
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: const Locale('pt', 'BR'),
        supportedLocales: const [Locale('pt', 'BR'), Locale('en')],
      ),
    );
  }
}
