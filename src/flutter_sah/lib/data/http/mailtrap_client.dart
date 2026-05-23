import 'package:dio/dio.dart';
import '../../core/utils/result.dart';
import '../models/mailtrap_config.dart';

class MailtrapClient {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://sandbox.api.mailtrap.io',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<Result<void>> sendPasswordReset({
    required String toEmail,
    required String toName,
    required String token,
    required MailtrapConfig config,
  }) async {
    try {
      await _dio.post<Map<String, dynamic>>(
        '/api/send/${config.inboxId}',
        options: Options(headers: {
          'Api-Token': config.apiToken,
          'Content-Type': 'application/json',
        }),
        data: {
          'from': {'email': config.fromEmail, 'name': config.fromName},
          'to': [{'email': toEmail, 'name': toName}],
          'subject': 'Redefinição de senha — SAH',
          'text': _textBody(toName, token),
          'html': _htmlBody(toName, token),
          'category': 'Password Reset',
        },
      );
      return const Success(null);
    } on DioException catch (e) {
      final msg = e.response?.data?.toString() ?? e.message ?? 'Erro desconhecido';
      return Failure('Falha ao enviar e-mail: $msg');
    }
  }

  static String _textBody(String nome, String token) => '''
Olá, $nome!

Recebemos uma solicitação de redefinição de senha para a sua conta no SAH.

Seu código de redefinição:

  $token

Cole este código na tela de redefinição de senha do aplicativo.

O código é válido por 30 minutos.

Se você não solicitou a redefinição, ignore este e-mail. Sua senha permanecerá a mesma.

— Equipe SAH
''';

  static String _htmlBody(String nome, String token) => '''
<!DOCTYPE html>
<html>
<body style="font-family: sans-serif; color: #2A2622; background: #FAF7F2; padding: 32px;">
  <p>Olá, <strong>$nome</strong>!</p>
  <p>Recebemos uma solicitação de redefinição de senha para a sua conta no <strong>SAH</strong>.</p>
  <p>Seu código de redefinição:</p>
  <div style="background:#F4F0E8; border-radius:8px; padding:16px 24px; margin:16px 0; font-family:monospace; font-size:18px; letter-spacing:2px; color:#4A7C59; text-align:center;">
    $token
  </div>
  <p>Cole este código na tela de <strong>Redefinição de senha</strong> do aplicativo.</p>
  <p style="color:#6B655D; font-size:13px;">O código é válido por <strong>30 minutos</strong>.</p>
  <hr style="border:none; border-top:1px solid #e0dcd5; margin:24px 0;" />
  <p style="color:#9B958B; font-size:12px;">Se você não solicitou a redefinição, ignore este e-mail. Sua senha permanecerá a mesma.</p>
</body>
</html>
''';
}
