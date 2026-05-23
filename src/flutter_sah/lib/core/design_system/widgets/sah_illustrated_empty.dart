import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
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
  factory SahIllustratedEmpty.todayFree({Widget? primaryAction}) =>
      SahIllustratedEmpty(
        icon: PhosphorIconsRegular.sunHorizon,
        color: SahColors.streak,
        title: 'Dia livre!',
        description:
            'Nenhum hábito agendado para hoje. Aproveite o descanso ou crie um novo hábito.',
        primaryAction: primaryAction,
      );

  /// "Sem hábitos ainda" — usuário ainda não cadastrou nenhum hábito.
  factory SahIllustratedEmpty.noHabits({Widget? primaryAction}) =>
      SahIllustratedEmpty(
        icon: PhosphorIconsRegular.sparkle,
        color: SahColors.accent,
        title: 'Comece sua jornada',
        description:
            'Você ainda não tem hábitos. Crie o primeiro pra acompanhar seu progresso.',
        primaryAction: primaryAction,
      );

  /// "Sem hábitos arquivados".
  factory SahIllustratedEmpty.noArchived({Widget? primaryAction}) =>
      SahIllustratedEmpty(
        icon: PhosphorIconsRegular.archive,
        color: SahColors.textMuted,
        title: 'Nenhum hábito arquivado',
        description:
            'Quando você arquivar um hábito, ele aparece aqui sem perder o histórico.',
        primaryAction: primaryAction,
      );

  /// "Sem registros no histórico".
  factory SahIllustratedEmpty.noHistory({Widget? primaryAction}) =>
      SahIllustratedEmpty(
        icon: PhosphorIconsRegular.chartLine,
        color: SahColors.info,
        title: 'Sem registros',
        description:
            'Quando você marcar check-ins, o histórico aparece aqui.',
        primaryAction: primaryAction,
      );

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
