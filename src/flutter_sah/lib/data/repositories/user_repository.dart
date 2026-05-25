import '../../core/utils/result.dart';
import '../models/user.dart';

enum UserStatusFilter { all, active, blocked }

abstract interface class UserRepository {
  Future<Result<List<User>>> list({String? query, UserStatusFilter? status});
  Future<Result<User>> getById(String id);
  Future<Result<User>> block(String id, {required String motivo});
  Future<Result<User>> unblock(String id);
  Future<Result<User>> setAdmin(String id, {required bool isAdmin});
  Future<Result<User>> updateProfile(String id, {required String nome});
  Future<Result<void>> delete(String id);
}
