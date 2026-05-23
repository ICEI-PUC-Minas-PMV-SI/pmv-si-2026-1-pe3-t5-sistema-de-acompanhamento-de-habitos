import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/design_system/tokens/sah_spacing.dart';
import '../../../../core/design_system/widgets/sah_empty_state.dart';
import '../../../../core/design_system/widgets/sah_spinner.dart';
import '../../../../core/utils/base_list_controller.dart';
import '../../../../data/models/audit_log.dart';
import '../../../../data/repositories/audit_log_repository.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/logs_controller.dart';
import '../widgets/log_list_item.dart';

class LogsScreen extends StatelessWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => LogsController(ctx.read<AuditLogRepository>()),
      child: const _LogsContent(),
    );
  }
}

class _LogsContent extends StatelessWidget {
  const _LogsContent();

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<LogsController>();
    final l = AppL10n.of(context)!;
    final typeFilters = [
      (label: l.adminLogsFilterAll, value: null),
      (label: l.adminLogsFilterLogin, value: AuditEventType.login),
      (label: l.adminLogsFilterSignup, value: AuditEventType.cadastro),
      (label: l.adminLogsFilterBlock, value: AuditEventType.bloqueio),
      (label: l.adminLogsFilterAdmin, value: AuditEventType.adminAction),
      (label: l.adminLogsFilterError, value: AuditEventType.erroSistema),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            SahSpacing.pagePadding,
            SahSpacing.pagePadding,
            SahSpacing.pagePadding,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.adminLogsTitle,
                style: TextStyle(
                  fontFamily: 'GeneralSans',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: SahColors.text,
                  letterSpacing: -0.44,
                ),
              ),
              const SizedBox(height: 12),
              _FilterBar(
                filters: typeFilters,
                current: ctrl.selectedType,
                onChanged: ctrl.setType,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Expanded(child: _buildBody(context, ctrl)),
      ],
    );
  }

  Widget _buildBody(BuildContext context, LogsController ctrl) {
    final l = AppL10n.of(context)!;
    if (ctrl.status == ListStatus.loading) {
      return const Center(child: SahSpinner(size: 28));
    }
    if (ctrl.status == ListStatus.error) {
      return Center(
        child: Text(
          ctrl.error ?? l.commonError,
          style: GoogleFonts.interTight(fontSize: 14, color: SahColors.textMuted),
        ),
      );
    }
    if (ctrl.logs.isEmpty) {
      return SahEmptyState(
        title: l.adminLogsEmpty,
        description: ctrl.selectedType != null
            ? l.adminLogsEmptyFiltered
            : l.adminLogsEmptyAll,
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: SahSpacing.pagePadding),
      itemCount: ctrl.logs.length,
      separatorBuilder: (_, __) => Divider(color: SahColors.border, height: 1),
      itemBuilder: (_, i) => LogListItem(log: ctrl.logs[i]),
    );
  }
}

class _FilterBar extends StatelessWidget {
  final List<({String label, AuditEventType? value})> filters;
  final AuditEventType? current;
  final void Function(AuditEventType?) onChanged;

  const _FilterBar({
    required this.filters,
    required this.current,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((f) {
          final selected = current == f.value;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => onChanged(f.value),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: selected ? SahColors.primary : SahColors.surface,
                  borderRadius: BorderRadius.circular(SahRadius.full),
                  border: Border.all(
                    color: selected ? SahColors.primary : SahColors.border,
                  ),
                ),
                child: Text(
                  f.label,
                  style: GoogleFonts.interTight(
                    fontSize: 13,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    color: selected ? Colors.white : SahColors.textMuted,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
