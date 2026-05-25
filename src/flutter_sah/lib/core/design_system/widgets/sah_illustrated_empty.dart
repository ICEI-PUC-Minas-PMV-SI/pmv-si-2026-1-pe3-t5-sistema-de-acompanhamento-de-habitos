import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../l10n/app_localizations.dart';
import '../tokens/sah_colors.dart';
import '../tokens/sah_radius.dart';
import '../tokens/sah_spacing.dart';

/// Empty state com "ilustração" baseada em ícones grandes do Phosphor com
/// fundo colorido suave. Sem SVG externo — usa o que já temos.
class SahIllustratedEmpty extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String description;
  final Widget? primaryAction;

  const SahIllustratedEmpty({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
    this.primaryAction,
  });

  /// "Dia livre" — não há hábitos agendados pra hoje.
  static SahIllustratedEmpty todayFree(BuildContext context,
      {Widget? primaryAction}) {
    final l = AppL10n.of(context)!;
    return SahIllustratedEmpty(
      icon: PhosphorIconsRegular.sunHorizon,
      color: SahColors.streak,
      title: l.todayFreeDay,
      description: l.todayFreeDescription,
      primaryAction: primaryAction,
    );
  }

  /// "Sem hábitos ainda" — usuário ainda não cadastrou nenhum hábito.
  static SahIllustratedEmpty noHabits(BuildContext context,
      {Widget? primaryAction}) {
    final l = AppL10n.of(context)!;
    return SahIllustratedEmpty(
      icon: PhosphorIconsRegular.sparkle,
      color: SahColors.accent,
      title: l.habitsEmptyTitle,
      description: l.habitsEmptyDescription,
      primaryAction: primaryAction,
    );
  }

  /// "Sem hábitos arquivados".
  static SahIllustratedEmpty noArchived(BuildContext context,
      {Widget? primaryAction}) {
    final l = AppL10n.of(context)!;
    return SahIllustratedEmpty(
      icon: PhosphorIconsRegular.archive,
      color: SahColors.textMuted,
      title: l.habitsArchivedEmpty,
      description: l.habitsArchivedEmptyDescription,
      primaryAction: primaryAction,
    );
  }

  /// "Sem registros no histórico".
  static SahIllustratedEmpty noHistory(BuildContext context,
      {Widget? primaryAction}) {
    final l = AppL10n.of(context)!;
    return SahIllustratedEmpty(
      icon: PhosphorIconsRegular.chartLine,
      color: SahColors.info,
      title: l.historyEmptyTitle,
      description: l.historyEmptyDescription,
      primaryAction: primaryAction,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SahSpacing.x8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: color.withAlpha(25),
                borderRadius: BorderRadius.circular(SahRadius.xl),
              ),
              child: Center(
                child: Icon(icon, size: 44, color: color),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'GeneralSans',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: SahColors.text,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.interTight(
                fontSize: 14,
                color: SahColors.textMuted,
                height: 1.6,
              ),
            ),
            if (primaryAction != null) ...[
              const SizedBox(height: 24),
              primaryAction!,
            ],
          ],
        ),
      ),
    );
  }
}
