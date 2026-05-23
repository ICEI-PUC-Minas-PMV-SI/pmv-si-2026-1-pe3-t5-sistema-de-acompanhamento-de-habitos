import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/design_system/tokens/sah_spacing.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../data/models/audit_log.dart';
import '../../../../l10n/app_localizations.dart';
import 'log_list_item.dart';

Future<void> showLogDetailModal(BuildContext context, AuditLog log) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _LogDetailModal(log: log),
  );
}

class _LogDetailModal extends StatelessWidget {
  final AuditLog log;
  const _LogDetailModal({required this.log});

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context)!;
    final mq = MediaQuery.of(context);

    return Container(
      constraints: BoxConstraints(maxHeight: mq.size.height * 0.85),
      padding: EdgeInsets.fromLTRB(
        SahSpacing.pagePadding,
        12,
        SahSpacing.pagePadding,
        SahSpacing.pagePadding + mq.viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: SahColors.surface,
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(SahRadius.xl)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: SahColors.border,
                  borderRadius: BorderRadius.circular(SahRadius.full),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                _TypeBadge(tipo: log.tipoEvento),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l.adminLogsDetailTitle,
                    style: TextStyle(
                      fontFamily: 'GeneralSans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: SahColors.text,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _DetailRow(
              label: l.adminLogsDetailWhen,
              value: SahFormatters.dateTimeFull(log.data),
              mono: true,
            ),
            _DetailRow(
              label: l.adminLogsDetailEvent,
              value: log.evento,
            ),
            _DetailRow(
              label: l.adminLogsDetailUser,
              value: log.userNome ?? l.adminLogsDetailEmpty,
            ),
            _DetailRow(
              label: l.adminLogsDetailEmail,
              value: log.userEmail ?? l.adminLogsDetailEmpty,
              mono: true,
            ),
            _DetailRow(
              label: l.adminLogsDetailUserId,
              value: log.userId ?? l.adminLogsDetailEmpty,
              mono: true,
            ),
            _DetailRow(
              label: l.adminLogsDetailRoute,
              value: log.route ?? l.adminLogsDetailEmpty,
              mono: true,
            ),
            _DetailRow(
              label: l.adminLogsDetailIp,
              value: log.ipAddress ?? l.adminLogsDetailEmpty,
              mono: true,
            ),
            _DetailRow(
              label: l.adminLogsDetailPlatform,
              value: log.platform ?? l.adminLogsDetailEmpty,
            ),
            if (log.metadata != null && log.metadata!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                l.adminLogsDetailMetadata,
                style: GoogleFonts.interTight(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: SahColors.textMuted,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: SahColors.bgAlt,
                  borderRadius: BorderRadius.circular(SahRadius.sm),
                  border: Border.all(color: SahColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: log.metadata!.entries
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              '${e.key}: ${e.value}',
                              style: GoogleFonts.jetBrainsMono(
                                fontSize: 12,
                                color: SahColors.text,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
            const SizedBox(height: 12),
            _DetailRow(
              label: l.adminLogsDetailLogId,
              value: log.id,
              mono: true,
              copyable: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool mono;
  final bool copyable;

  const _DetailRow({
    required this.label,
    required this.value,
    this.mono = false,
    this.copyable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.interTight(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: SahColors.textMuted,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SelectableText(
                  value,
                  style: mono
                      ? GoogleFonts.jetBrainsMono(
                          fontSize: 13,
                          color: SahColors.text,
                        )
                      : GoogleFonts.interTight(
                          fontSize: 14,
                          color: SahColors.text,
                          height: 1.4,
                        ),
                ),
              ),
              if (copyable)
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    Icons.copy_rounded,
                    size: 16,
                    color: SahColors.textMuted,
                  ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: value));
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final AuditEventType tipo;
  const _TypeBadge({required this.tipo});

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context)!;
    final color = LogListItem.typeColor(tipo);
    final bg = LogListItem.typeBg(tipo);
    final label = LogListItem.typeLabel(l, tipo);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(SahRadius.full),
      ),
      child: Text(
        label,
        style: GoogleFonts.interTight(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
