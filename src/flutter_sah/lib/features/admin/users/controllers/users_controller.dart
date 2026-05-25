import 'package:flutter/material.dart';
import '../../../../core/utils/result.dart';
import '../../../../data/models/user.dart';
import '../../../../data/repositories/user_repository.dart';

enum UsersStatus { loading, loaded, error }

class UsersController extends ChangeNotifier {
  final UserRepository _repo;

  UsersStatus _status = UsersStatus.loading;
  List<User> _users = [];
  String? _error;
  String _query = '';
  UserStatusFilter _filter = UserStatusFilter.all;

  UsersController(this._repo) {
    load();
  }

  UsersStatus get status => _status;
  List<User> get users => _users;
  String? get error => _error;
  String get query => _query;
  UserStatusFilter get filter => _filter;

  Future<void> load() async {
    _status = UsersStatus.loading;
    _error = null;
    notifyListeners();
    final result = await _repo.list(
      query: _query.isEmpty ? null : _query,
      status: _filter,
    );
    result.fold(
      onSuccess: (list) {
        _users = list;
        _status = UsersStatus.loaded;
      },
      onFailure: (msg) {
        _error = msg;
        _status = UsersStatus.error;
      },
    );
    notifyListeners();
  }

  void setQuery(String q) {
    _query = q;
    load();
  }

  void setFilter(UserStatusFilter f) {
    _filter = f;
    load();
  }

  Future<bool> block(String id, {required String motivo}) async {
    final result = await _repo.block(id, motivo: motivo);
    return result.fold(
      onSuccess: (_) {
        load();
        return true;
      },
      onFailure: (_) => false,
    );
  }

  Future<bool> unblock(String id) async {
    final result = await _repo.unblock(id);
    return result.fold(
      onSuccess: (_) {
        load();
        return true;
      },
      onFailure: (_) => false,
    );
  }

  Future<bool> setAdmin(String id, {required bool isAdmin}) async {
    final result = await _repo.setAdmin(id, isAdmin: isAdmin);
    return result.fold(
      onSuccess: (_) {
        load();
        return true;
      },
      onFailure: (_) => false,
    );
  }
}
