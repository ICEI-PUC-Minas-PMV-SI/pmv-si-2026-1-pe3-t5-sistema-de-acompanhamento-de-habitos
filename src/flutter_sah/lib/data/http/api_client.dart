// HTTP client stub — descomentar dio em pubspec.yaml para ativar.
//
// Para usar:
//   1. Descomentar `dio: ^5.7.0` em pubspec.yaml e rodar `flutter pub get`
//   2. Remover os comentários abaixo
//   3. Em main.dart, passar ApiClient para os HttpRepository
//
// import 'package:dio/dio.dart';
// import '../../core/env/env.dart';
//
// class ApiClient {
//   late final Dio _dio;
//
//   ApiClient() {
//     _dio = Dio(BaseOptions(
//       baseUrl: Env.baseUrl,
//       connectTimeout: const Duration(seconds: 10),
//       receiveTimeout: const Duration(seconds: 15),
//       headers: {'Content-Type': 'application/json'},
//     ));
//
//     _dio.interceptors.addAll([
//       _AuthInterceptor(),
//       LogInterceptor(requestBody: true, responseBody: true),
//       _ErrorInterceptor(),
//     ]);
//   }
//
//   Dio get client => _dio;
// }
//
// class _AuthInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     // TODO: injetar token de sessão quando shared_preferences estiver ativo
//     // final token = SessionStorage.token;
//     // if (token != null) options.headers['Authorization'] = 'Bearer $token';
//     handler.next(options);
//   }
// }
//
// class _ErrorInterceptor extends Interceptor {
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     // Converte DioException para Failure<T> — ver core/utils/result.dart
//     handler.next(err);
//   }
// }

// Placeholder para evitar erro de arquivo vazio durante a fase de fakes.
abstract final class ApiClient {}
