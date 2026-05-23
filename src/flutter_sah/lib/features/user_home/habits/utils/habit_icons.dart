import 'package:flutter/widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// Catálogo de ícones disponíveis pro usuário escolher ao criar/editar hábito.
/// As chaves são strings simples persistidas no campo `Habit.icone`.
class HabitIcons {
  static const Map<String, IconData> catalog = {
    'drop': PhosphorIconsRegular.drop,
    'book': PhosphorIconsRegular.book,
    'barbell': PhosphorIconsRegular.barbell,
    'brain': PhosphorIconsRegular.brain,
    'fire': PhosphorIconsRegular.fire,
    'leaf': PhosphorIconsRegular.leaf,
    'heart': PhosphorIconsRegular.heart,
    'moon': PhosphorIconsRegular.moon,
    'sun': PhosphorIconsRegular.sun,
    'sparkle': PhosphorIconsRegular.sparkle,
    'alarm': PhosphorIconsRegular.alarm,
    'bicycle': PhosphorIconsRegular.bicycle,
    'basketball': PhosphorIconsRegular.basketball,
    'musicNote': PhosphorIconsRegular.musicNote,
    'pen': PhosphorIconsRegular.pencil,
    'code': PhosphorIconsRegular.code,
    'palette': PhosphorIconsRegular.palette,
    'chat': PhosphorIconsRegular.chats,
    'coffee': PhosphorIconsRegular.coffee,
    'pawPrint': PhosphorIconsRegular.pawPrint,
    'plant': PhosphorIconsRegular.plant,
    'forkKnife': PhosphorIconsRegular.forkKnife,
    'wallet': PhosphorIconsRegular.wallet,
    'gameController': PhosphorIconsRegular.gameController,
  };

  /// Retorna o IconData pra um nome do catálogo, ou `sparkle` como fallback.
  static IconData iconFor(String? name) {
    if (name == null) return PhosphorIconsRegular.sparkle;
    return catalog[name] ?? PhosphorIconsRegular.sparkle;
  }

  static List<String> names() => catalog.keys.toList();
}
