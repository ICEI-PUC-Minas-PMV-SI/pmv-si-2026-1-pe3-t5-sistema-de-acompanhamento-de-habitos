// HTTP API endpoint constants — reserved for future integration phase.
// Currently unused; data is served by fake in-memory repositories.
abstract final class ApiEndpoints {
  static const String auth = '/auth';
  static const String login = '/auth/login';
  static const String signup = '/auth/signup';
  static const String logout = '/auth/logout';
  static const String passwordReset = '/auth/password-reset';
  static const String me = '/auth/me';

  static const String users = '/users';
  static String userById(String id) => '/users/$id';
  static String userBlock(String id) => '/users/$id/block';
  static String userUnblock(String id) => '/users/$id/unblock';

  static const String categories = '/categories';
  static String categoryById(String id) => '/categories/$id';
  static String categoryHabitsCount(String id) => '/categories/$id/habits/count';

  static const String habits = '/habits';
  static String habitById(String id) => '/habits/$id';

  static const String logs = '/logs';
}
