import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../data/models/audit_log.dart';

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
    };
  }

  static String _typeLabel(AuditEventType t) {
    return switch (t) {
      AuditEventType.login => 'Login',
      AuditEventType.logout => 'Logout',
      AuditEventType.cadastro => 'Cadastro',
      AuditEventType.bloqueio => 'Bloqueio',
      AuditEventType.desbloqueio => 'Desbloqueio',
      AuditEventType.erroSistema => 'Erro',
      AuditEventType.adminAction => 'Admin',
      AuditEventType.profileUpdate => 'Perfil',
      AuditEventType.passwordChanged => 'Senha',
      AuditEventType.passwordReset => 'Reset',
      AuditEventType.contaExcluida => 'Exclusão',
    };
  }

  @override
  Widget build(BuildContext context) {
    final color = _typeColor(log.tipoEvento);
    final bg = _typeBg(log.tipoEvento);
    final label = _typeLabel(log.tipoEvento);

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
