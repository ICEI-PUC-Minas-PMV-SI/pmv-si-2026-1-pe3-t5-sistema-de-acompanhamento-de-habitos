import '../../core/utils/result.dart';
import '../models/user.dart';

abstract interface class AuthRepository {
  Future<Result<User>> login(String email, String password);
  Future<Result<User>> signup({
    required String nome,
    required String email,
    required String password,
  });
  Future<Result<void>> requestPasswordReset(String email);
  Future<Result<void>> confirmPasswordReset({
    required String token,
    required String newPassword,
  });
  Future<Result<void>> changePassword({
    required String userId,
    required String currentPassword,
    required String newPassword,
  });
  Future<Result<void>> logout();
  Future<Result<User?>> currentUser();
  Future<Result<void>> deleteAccount({required String userId});
}
