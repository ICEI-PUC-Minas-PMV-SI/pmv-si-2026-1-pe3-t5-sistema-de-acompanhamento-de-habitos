import 'package:flutter/foundation.dart';

/// Bus de eventos de mudanças em categorias.
///
/// Por que existe: o `StatefulShellRoute.indexedStack` mantém todas as abas
/// vivas em memória. Quando o usuário cria/edita/exclui uma categoria em
/// "Minhas categorias" ou no painel admin, o `HabitsController` (instanciado
/// uma vez ao entrar na aba Hábitos) tem a lista de categorias congelada. Esse
/// bus avisa os interessados para recarregarem.
class CategoriesBus extends ChangeNotifier {
  void notifyChanged() => notifyListeners();
}
