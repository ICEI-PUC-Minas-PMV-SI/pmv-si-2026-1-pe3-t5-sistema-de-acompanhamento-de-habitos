import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../data/models/audit_log.dart';
import '../../../../l10n/app_localizations.dart';

class LogListItem extends StatelessWidget {
  final AuditLog log;

  const LogListItem({super.key, required this.log});

  static Color _typeColor(AuditEventType t) {
    return switch (t) {
      AuditEventType.login || AuditEventType.logout => SahColors.primary,
      AuditEventType.cadastro => SahColors.accent,
      AuditEventType.bloqueio => SahColors.danger,
      AuditEventType.desbloqueio => SahColors.primary,
      AuditEventType.erroSistema => SahColors.danger,
      AuditEventType.adminAction => SahColors.streak,
      AuditEventType.profileUpdate => SahColors.info,
      AuditEventType.passwordChanged || AuditEventType.passwordReset => SahColors.warning,
      AuditEventType.contaExcluida => SahColors.danger,
      AuditEventType.dataBackup => SahColors.info,
    };
  }

  static Color _typeBg(AuditEventType t) {
    return switch (t) {
      AuditEventType.login || AuditEventType.logout => SahColors.primaryFaint,
      AuditEventType.cadastro => SahColors.accentFaint,
      AuditEventType.bloqueio => SahColors.dangerSoft,
      AuditEventType.desbloqueio => SahColors.primaryFaint,
      AuditEventType.erroSistema => SahColors.dangerSoft,
      AuditEventType.adminAction => SahColors.streakSoft,
      AuditEventType.profileUpdate => SahColors.infoSoft,
      AuditEventType.passwordChanged || AuditEventType.passwordReset => SahColors.streakSoft,
      AuditEventType.contaExcluida => SahColors.dangerSoft,
      AuditEventType.dataBackup => SahColors.infoSoft,
    };
  }

  static String _typeLabel(AppL10n l, AuditEventType t) {
    return switch (t) {
      AuditEventType.login => l.adminLogsTypeLogin,
      AuditEventType.logout => l.adminLogsTypeLogout,
      AuditEventType.cadastro => l.adminLogsTypeSignup,
      AuditEventType.bloqueio => l.adminLogsTypeBlock,
      AuditEventType.desbloqueio => l.adminLogsTypeUnblock,
      AuditEventType.erroSistema => l.adminLogsTypeError,
      AuditEventType.adminAction => l.adminLogsTypeAdmin,
      AuditEventType.profileUpdate => l.adminLogsTypeProfile,
      AuditEventType.passwordChanged => l.adminLogsTypePassword,
      AuditEventType.passwordReset => l.adminLogsTypeReset,
      AuditEventType.contaExcluida => l.adminLogsTypeAccountDeleted,
      AuditEventType.dataBackup => l.adminLogsTypeBackup,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context)!;
    final color = _typeColor(log.tipoEvento);
    final bg = _typeBg(log.tipoEvento);
    final label = _typeLabel(l, log.tipoEvento);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(SahRadius.full)),
            child: Text(
              label,
              style: GoogleFonts.interTight(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  log.evento,
                  style: GoogleFonts.interTight(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: SahColors.text,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    if (log.userNome != null) ...[
                      Text(
                        log.userNome!,
                        style: GoogleFonts.interTight(fontSize: 11, color: SahColors.textMuted),
                      ),
                      Text(' · ', style: GoogleFonts.interTight(fontSize: 11, color: SahColors.textFaint)),
                    ],
                    Text(
                      SahFormatters.dateTime(log.data),
                      style: GoogleFonts.jetBrainsMono(fontSize: 10, color: SahColors.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
