import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../tokens/sah_palette.dart';

class SahTheme {
  static ThemeData light() => _build(SahPalette.light, Brightness.light);
  static ThemeData dark()  => _build(SahPalette.dark,  Brightness.dark);

  static ThemeData _build(SahPalette p, Brightness b) {
    return ThemeData(
      useMaterial3: true,
      brightness: b,
      scaffoldBackgroundColor: p.bg,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      colorScheme: ColorScheme.fromSeed(
        seedColor: p.primary,
        brightness: b,
        surface: p.surface,
      ).copyWith(
        primary: p.primary,
        secondary: p.accent,
        error: p.danger,
        surface: p.surface,
      ),
      textTheme: GoogleFonts.interTightTextTheme().copyWith(
        bodyLarge: GoogleFonts.interTight(
            fontSize: 17, color: p.text, height: 1.6),
        bodyMedium: GoogleFonts.interTight(
            fontSize: 14, color: p.text, height: 1.55),
        bodySmall: GoogleFonts.interTight(
            fontSize: 13,
            color: p.textMuted,
            fontWeight: FontWeight.w500,
            height: 1.5),
        labelSmall: GoogleFonts.interTight(
            fontSize: 12, color: p.textMuted, fontWeight: FontWeight.w500),
      ),
      inputDecorationTheme: const InputDecorationTheme(border: InputBorder.none),
      appBarTheme: AppBarTheme(
        backgroundColor: p.surface,
        foregroundColor: p.text,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              b == Brightness.dark ? Brightness.light : Brightness.dark,
        ),
        titleTextStyle: TextStyle(
          fontFamily: 'GeneralSans',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.3,
          color: p.text,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: p.surface,
        indicatorColor: p.primaryFaint,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.interTight(
                fontSize: 12, fontWeight: FontWeight.w600, color: p.accent);
          }
          return GoogleFonts.interTight(
              fontSize: 12, fontWeight: FontWeight.w400, color: p.textMuted);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: p.accent, size: 22);
          }
          return IconThemeData(color: p.textMuted, size: 22);
        }),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: p.surface,
        elevation: 0,
      ),
      dividerTheme: DividerThemeData(
        color: p.border,
        thickness: 1,
        space: 0,
      ),
    );
  }
}
