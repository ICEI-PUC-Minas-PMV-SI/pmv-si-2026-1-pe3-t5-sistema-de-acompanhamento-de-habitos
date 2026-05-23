import '../../../../core/utils/base_list_controller.dart';
import '../../../../core/utils/result.dart';
import '../../../../data/models/audit_log.dart';
import '../../../../data/repositories/audit_log_repository.dart';

class LogsController extends BaseListController<AuditLog> {
  final AuditLogRepository _repo;

  AuditEventType? _selectedType;

  LogsController(this._repo) {
    load();
  }

  AuditEventType? get selectedType => _selectedType;
  List<AuditLog> get logs => items;

  @override
  Future<Result<List<AuditLog>>> fetchItems() =>
      _repo.list(eventType: _selectedType, limit: 50);

  void setType(AuditEventType? type) {
    _selectedType = type;
    load();
  }
}
