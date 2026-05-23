import 'package:flutter/foundation.dart';

/// Bus de eventos de mudanças em hábitos.
///
/// Por que existe: o `StatefulShellRoute.indexedStack` mantém todas as abas
/// vivas em memória. Quando o usuário cria/edita/exclui um hábito na aba
/// Hábitos, os controllers da Hoje e do Histórico (instanciados uma vez) não
/// têm como saber que precisam recarregar. Esse bus notifica todos os
/// interessados de uma mudança relevante.
class HabitsBus extends ChangeNotifier {
  void notifyChanged() => notifyListeners();
}
