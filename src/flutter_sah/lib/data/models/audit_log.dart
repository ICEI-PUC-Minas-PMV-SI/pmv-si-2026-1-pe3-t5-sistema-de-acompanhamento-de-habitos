enum AuditEventType {
  login,
  logout,
  cadastro,
  bloqueio,
  desbloqueio,
  erroSistema,
  adminAction,
  profileUpdate,
  passwordChanged,
  passwordReset,
  contaExcluida,
  dataBackup,
}

class AuditLog {
  final String id;
  final AuditEventType tipoEvento;
  final String evento;
  final DateTime data;
  final String? userId;
  final String? userNome;

  const AuditLog({
    required this.id,
    required this.tipoEvento,
    required this.evento,
    required this.data,
    this.userId,
    this.userNome,
  });

  factory AuditLog.fromJson(Map<String, dynamic> j) => AuditLog(
        id: j['id'] as String,
        tipoEvento: AuditEventType.values.firstWhere(
          (e) => e.name == j['tipo_evento'],
          orElse: () => AuditEventType.adminAction,
        ),
        evento: j['evento'] as String,
        data: DateTime.parse(j['data'] as String),
        userId: j['user_id'] as String?,
        userNome: j['user_nome'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'tipo_evento': tipoEvento.name,
        'evento': evento,
        'data': data.toIso8601String(),
        'user_id': userId,
        'user_nome': userNome,
      };
}
