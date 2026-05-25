import '../../core/utils/result.dart';
import '../models/audit_log.dart';

abstract interface class AuditLogRepository {
  Future<Result<List<AuditLog>>> list({
    DateTime? from,
    DateTime? to,
    AuditEventType? eventType,
    String? userId,
    int limit = 50,
    int offset = 0,
  });
}
