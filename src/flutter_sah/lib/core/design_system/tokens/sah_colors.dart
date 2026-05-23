import 'package:flutter/material.dart';
import 'sah_palette.dart';

class _PaletteHolder {
  static SahPalette current = SahPalette.light;
}

void setActiveSahPalette(SahPalette palette) {
  _PaletteHolder.current = palette;
}

abstract final class SahColors {
  static Color get bg           => _PaletteHolder.current.bg;
  static Color get bgAlt        => _PaletteHolder.current.bgAlt;
  static Color get surface      => _PaletteHolder.current.surface;
  static Color get surfaceAlt   => _PaletteHolder.current.surfaceAlt;
  static Color get border       => _PaletteHolder.current.border;
  static Color get borderStrong => _PaletteHolder.current.borderStrong;
  static Color get text         => _PaletteHolder.current.text;
  static Color get textMuted    => _PaletteHolder.current.textMuted;
  static Color get textFaint    => _PaletteHolder.current.textFaint;
  static Color get primary      => _PaletteHolder.current.primary;
  static Color get primaryHover => _PaletteHolder.current.primaryHover;
  static Color get primarySoft  => _PaletteHolder.current.primarySoft;
  static Color get primaryFaint => _PaletteHolder.current.primaryFaint;
  static Color get accent       => _PaletteHolder.current.accent;
  static Color get accentHover  => _PaletteHolder.current.accentHover;
  static Color get accentSoft   => _PaletteHolder.current.accentSoft;
  static Color get accentFaint  => _PaletteHolder.current.accentFaint;
  static Color get streak       => _PaletteHolder.current.streak;
  static Color get streakSoft   => _PaletteHolder.current.streakSoft;
  static Color get streakText   => _PaletteHolder.current.streakText;
  static Color get success      => _PaletteHolder.current.success;
  static Color get warning      => _PaletteHolder.current.warning;
  static Color get danger       => _PaletteHolder.current.danger;
  static Color get dangerSoft   => _PaletteHolder.current.dangerSoft;
  static Color get info         => _PaletteHolder.current.info;
  static Color get infoSoft     => _PaletteHolder.current.infoSoft;
}
