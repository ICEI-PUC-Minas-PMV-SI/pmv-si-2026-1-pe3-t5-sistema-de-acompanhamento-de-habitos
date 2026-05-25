import 'package:flutter/material.dart';

class SahPalette {
  final Color bg;
  final Color bgAlt;
  final Color surface;
  final Color surfaceAlt;
  final Color border;
  final Color borderStrong;
  final Color text;
  final Color textMuted;
  final Color textFaint;
  final Color primary;
  final Color primaryHover;
  final Color primarySoft;
  final Color primaryFaint;
  final Color accent;
  final Color accentHover;
  final Color accentSoft;
  final Color accentFaint;
  final Color streak;
  final Color streakSoft;
  final Color streakText;
  final Color success;
  final Color warning;
  final Color danger;
  final Color dangerSoft;
  final Color info;
  final Color infoSoft;

  const SahPalette({
    required this.bg,
    required this.bgAlt,
    required this.surface,
    required this.surfaceAlt,
    required this.border,
    required this.borderStrong,
    required this.text,
    required this.textMuted,
    required this.textFaint,
    required this.primary,
    required this.primaryHover,
    required this.primarySoft,
    required this.primaryFaint,
    required this.accent,
    required this.accentHover,
    required this.accentSoft,
    required this.accentFaint,
    required this.streak,
    required this.streakSoft,
    required this.streakText,
    required this.success,
    required this.warning,
    required this.danger,
    required this.dangerSoft,
    required this.info,
    required this.infoSoft,
  });

  static const light = SahPalette(
    bg:           Color(0xFFFAF7F2),
    bgAlt:        Color(0xFFF4F0E8),
    surface:      Color(0xFFFFFFFF),
    surfaceAlt:   Color(0xFFFBF8F3),
    border:       Color(0x14000000),
    borderStrong: Color(0x29000000),
    text:         Color(0xFF2A2622),
    textMuted:    Color(0xFF6B655D),
    textFaint:    Color(0xFF9B958B),
    primary:      Color(0xFF4A7C59),
    primaryHover: Color(0xFF3E6B4C),
    primarySoft:  Color(0xFFDCEAE0),
    primaryFaint: Color(0xFFEEF5F0),
    accent:       Color(0xFF6B5B95),
    accentHover:  Color(0xFF584A7E),
    accentSoft:   Color(0xFFE5E0ED),
    accentFaint:  Color(0xFFF2EFF5),
    streak:       Color(0xFFC89B3C),
    streakSoft:   Color(0xFFF4E8CC),
    streakText:   Color(0xFF8A6820),
    success:      Color(0xFF4A7C59),
    warning:      Color(0xFFC89B3C),
    danger:       Color(0xFFB8544A),
    dangerSoft:   Color(0xFFF2DAD7),
    info:         Color(0xFF5B7FA8),
    infoSoft:     Color(0xFFDCE5F0),
  );

  static const dark = SahPalette(
    bg:           Color(0xFF1A1714),
    bgAlt:        Color(0xFF221E1A),
    surface:      Color(0xFF26221E),
    surfaceAlt:   Color(0xFF2E2925),
    border:       Color(0x33FFFFFF),
    borderStrong: Color(0x4DFFFFFF),
    text:         Color(0xFFF2EDE6),
    textMuted:    Color(0xFFB8B0A4),
    textFaint:    Color(0xFF847C70),
    primary:      Color(0xFF6FA67E),
    primaryHover: Color(0xFF82B791),
    primarySoft:  Color(0xFF2D3F33),
    primaryFaint: Color(0xFF253029),
    accent:       Color(0xFF9182BC),
    accentHover:  Color(0xFFA395CE),
    accentSoft:   Color(0xFF332E45),
    accentFaint:  Color(0xFF2A2638),
    streak:       Color(0xFFE0B95C),
    streakSoft:   Color(0xFF3D3320),
    streakText:   Color(0xFFE8C977),
    success:      Color(0xFF6FA67E),
    warning:      Color(0xFFE0B95C),
    danger:       Color(0xFFD47A70),
    dangerSoft:   Color(0xFF3D2522),
    info:         Color(0xFF7FA0C5),
    infoSoft:     Color(0xFF253040),
  );
}
