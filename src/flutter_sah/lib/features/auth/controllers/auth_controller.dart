import 'package:flutter/material.dart';
import '../../../core/utils/result.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../data/widgets/home_widget_service.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthController extends ChangeNotifier {
  final AuthRepository _repo;
  final UserRepository _userRepo;
  final HomeWidgetService _widget;

  AuthStatus _status = AuthStatus.unknown;
  User? _currentUser;
  String? _error;

  AuthController(this._repo, this._userRepo, this._widget) {
    _init();
  }

  AuthStatus get status => _status;
  User? get currentUser => _currentUser;
  String? get error => _error;
  bool get isAdmin => _currentUser?.isAdmin ?? false;

  Future<void> _init() async {
    final result = await _repo.currentUser();
    result.fold(
      onSuccess: (user) {
        _currentUser = user;
        _status =
            user != null ? AuthStatus.authenticated : AuthStatus.unauthenticated;
      },
      onFailure: (_) => _status = AuthStatus.unauthenticated,
    );
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _error = null;
    notifyListeners();
    final result = await _repo.login(email, password);
    return result.fold(
      onSuccess: (user) {
        _currentUser = user;
        _status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      },
      onFailure: (msg) {
        _error = msg;
        notifyListeners();
        return false;
      },
    );
  }

  Future<bool> signup({
    required String nome,
    required String email,
    required String password,
  }) async {
    _error = null;
    notifyListeners();
    final result = await _repo.signup(nome: nome, email: email, password: password);
    return result.fold(
      onSuccess: (user) {
        _currentUser = user;
        _status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      },
      onFailure: (msg) {
        _error = msg;
        notifyListeners();
        return false;
      },
    );
  }

  Future<bool> requestPasswordReset(String email) async {
    _error = null;
    final result = await _repo.requestPasswordReset(email);
    return result.fold(
      onSuccess: (_) => true,
      onFailure: (msg) {
        _error = msg;
        notifyListeners();
        return false;
      },
    );
  }

  Future<bool> confirmPasswordReset({
    required String token,
    required String newPassword,
  }) async {
    _error = null;
    final result = await _repo.confirmPasswordReset(token: token, newPassword: newPassword);
    return result.fold(
      onSuccess: (_) => true,
      onFailure: (msg) {
        _error = msg;
        notifyListeners();
        return false;
      },
    );
  }

  Future<bool> updateProfile({required String nome}) async {
    if (_currentUser == null) return false;
    _error = null;
    final result = await _userRepo.updateProfile(_currentUser!.id, nome: nome);
    return result.fold(
      onSuccess: (updated) {
        _currentUser = updated;
        notifyListeners();
        return true;
      },
      onFailure: (msg) {
        _error = msg;
        notifyListeners();
        return false;
      },
    );
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (_currentUser == null) return false;
    _error = null;
    final result = await _repo.changePassword(
      userId: _currentUser!.id,
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    return result.fold(
      onSuccess: (_) => true,
      onFailure: (msg) {
        _error = msg;
        notifyListeners();
        return false;
      },
    );
  }

  Future<void> logout() async {
    await _repo.logout();
    _currentUser = null;
    _status = AuthStatus.unauthenticated;
    await _widget.clear();
    notifyListeners();
  }

  Future<bool> deleteAccount() async {
    final id = _currentUser?.id;
    if (id == null) return false;
    _error = null;
    final result = await _repo.deleteAccount(userId: id);
    return result.fold(
      onSuccess: (_) {
        _currentUser = null;
        _status = AuthStatus.unauthenticated;
        _widget.clear();
        notifyListeners();
        return true;
      },
      onFailure: (msg) {
        _error = msg;
        notifyListeners();
        return false;
      },
    );
  }
}
