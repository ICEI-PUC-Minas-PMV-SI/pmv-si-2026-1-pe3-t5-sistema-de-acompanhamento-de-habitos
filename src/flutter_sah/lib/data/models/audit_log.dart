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
  final String? userEmail;
  final String? route;
  final String? ipAddress;
  final String? platform;
  final Map<String, String>? metadata;

  const AuditLog({
    required this.id,
    required this.tipoEvento,
    required this.evento,
    required this.data,
    this.userId,
    this.userNome,
    this.userEmail,
    this.route,
    this.ipAddress,
    this.platform,
    this.metadata,
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
        userEmail: j['user_email'] as String?,
        route: j['route'] as String?,
        ipAddress: j['ip_address'] as String?,
        platform: j['platform'] as String?,
        metadata: (j['metadata'] as Map<String, dynamic>?)
            ?.map((k, v) => MapEntry(k, v.toString())),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'tipo_evento': tipoEvento.name,
        'evento': evento,
        'data': data.toIso8601String(),
        if (userId != null) 'user_id': userId,
        if (userNome != null) 'user_nome': userNome,
        if (userEmail != null) 'user_email': userEmail,
        if (route != null) 'route': route,
        if (ipAddress != null) 'ip_address': ipAddress,
        if (platform != null) 'platform': platform,
        if (metadata != null && metadata!.isNotEmpty) 'metadata': metadata,
      };
}
