import 'package:flutter/material.dart';
import '../../../../core/utils/result.dart';
import '../../../../data/models/habit.dart';
import '../../../../data/models/user.dart';
import '../../../../data/repositories/habit_repository.dart';
import '../../../../data/repositories/user_repository.dart';

enum DashboardStatus { loading, loaded, error }

class DashboardController extends ChangeNotifier {
  final UserRepository _userRepo;
  final HabitRepository _habitRepo;

  DashboardStatus _status = DashboardStatus.loading;
  Map<String, dynamic> _metrics = {};
  String? _error;

  DashboardStatus get status => _status;
  Map<String, dynamic> get metrics => _metrics;
  String? get error => _error;

  DashboardController({
    required UserRepository userRepo,
    required HabitRepository habitRepo,
  })  : _userRepo = userRepo,
        _habitRepo = habitRepo {
    load();
  }

  Future<void> load() async {
    _status = DashboardStatus.loading;
    _error = null;
    notifyListeners();

    final Result<List<User>> usersResult = await _userRepo.list();
    final users = usersResult.fold<List<User>>(
      onSuccess: (l) => l,
      onFailure: (_) => [],
    );

    final ativos = users.where((u) => !u.isBlocked).length;
    final bloqueios = users.where((u) => u.isBlocked).length;

    var habitosCriados = 0;
    for (final user in users) {
      final Result<List<Habit>> result = await _habitRepo.listForUser(
        user.id,
        includeArchived: true,
      );
      habitosCriados += result.fold<int>(
        onSuccess: (l) => l.length,
        onFailure: (_) => 0,
      );
    }

    _metrics = {
      'usuariosAtivos': ativos,
      'habitosCriados': habitosCriados,
      'streakMedioDias': 0,
      'bloqueios': bloqueios,
    };
    _status = DashboardStatus.loaded;
    notifyListeners();
  }
}
