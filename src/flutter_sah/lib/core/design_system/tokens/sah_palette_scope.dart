import 'package:flutter/widgets.dart';
import 'sah_palette.dart';

/// Propaga a paleta ativa pela árvore de widgets via InheritedWidget.
///
/// Por que existe: `SahColors.bg` lê de um estado global mutável (_PaletteHolder).
/// Widgets que usam esses getters não reagem a mudanças de tema, pois não escutam
/// nenhum InheritedWidget que mude. Esse scope envolve o MaterialApp.router e
/// muda quando a paleta muda. Telas que precisam rebuildar ao trocar tema chamam
/// `SahPaletteScope.subscribe(context)` no build para registrar dependência.
class SahPaletteScope extends InheritedWidget {
  final SahPalette palette;

  const SahPaletteScope({
    super.key,
    required this.palette,
    required super.child,
  });

  /// Registra o widget atual como dependente da paleta — ele rebuilda
  /// automaticamente quando a paleta muda. Chame no início de `build()`.
  static void subscribe(BuildContext context) {
    context.dependOnInheritedWidgetOfExactType<SahPaletteScope>();
  }

  static SahPalette of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<SahPaletteScope>();
    return scope?.palette ?? SahPalette.light;
  }

  @override
  bool updateShouldNotify(SahPaletteScope old) => old.palette != palette;
}
