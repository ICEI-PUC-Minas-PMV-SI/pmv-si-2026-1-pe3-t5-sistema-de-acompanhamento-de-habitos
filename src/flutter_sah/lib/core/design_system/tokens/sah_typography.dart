import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sah_colors.dart';

abstract final class SahTypography {
  // General Sans — display/editorial
  static TextStyle displayXl({Color? color}) => TextStyle(
        fontFamily: 'GeneralSans',
        fontSize: 64,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.035 * 64,
        height: 1.0,
        color: color ?? SahColors.text,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  static TextStyle displayLg({Color? color}) => TextStyle(
        fontFamily: 'GeneralSans',
        fontSize: 38,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.025 * 38,
        height: 1.1,
        color: color ?? SahColors.text,
      );

  static TextStyle displayMd({Color? color}) => TextStyle(
        fontFamily: 'GeneralSans',
        fontSize: 26,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.02 * 26,
        height: 1.2,
        color: color ?? SahColors.text,
      );

  static TextStyle displaySm({Color? color}) => TextStyle(
        fontFamily: 'GeneralSans',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.015 * 20,
        height: 1.25,
        color: color ?? SahColors.text,
      );

  // Inter Tight — corpo / UI
  static TextStyle bodyLg({Color? color}) =>
      GoogleFonts.interTight(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.6,
        color: color ?? SahColors.text,
      );

  static TextStyle bodyMd({Color? color}) =>
      GoogleFonts.interTight(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.55,
        color: color ?? SahColors.text,
      );

  static TextStyle bodySm({Color? color}) =>
      GoogleFonts.interTight(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: 1.5,
        color: color ?? SahColors.textMuted,
      );

  static TextStyle caption({Color? color}) =>
      GoogleFonts.interTight(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: 1.4,
        color: color ?? SahColors.textMuted,
      );

  // JetBrains Mono — metadados, refs, eyebrows
  static TextStyle monoXs({Color? color}) =>
      GoogleFonts.jetBrainsMono(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.12,
        height: 1.3,
        color: color ?? SahColors.textFaint,
      );

  static TextStyle monoSm({Color? color}) =>
      GoogleFonts.jetBrainsMono(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.04,
        height: 1.35,
        color: color ?? SahColors.textFaint,
      );

  // Numbers — tabular-nums para métricas e streaks
  static TextStyle streakNumber({Color? color}) =>
      TextStyle(
        fontFamily: 'GeneralSans',
        fontSize: 30,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.025 * 30,
        height: 1.0,
        color: color ?? SahColors.streakText,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  static TextStyle metricNumber({Color? color}) => TextStyle(
        fontFamily: 'GeneralSans',
        fontSize: 30,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.025 * 30,
        height: 1.0,
        color: color ?? SahColors.text,
        fontFeatures: const [FontFeature.tabularFigures()],
      );
}
