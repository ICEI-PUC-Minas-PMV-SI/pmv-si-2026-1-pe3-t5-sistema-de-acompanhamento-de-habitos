import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/design_system/tokens/sah_shadows.dart';
import '../../../../core/design_system/widgets/sah_progress_bar.dart';

class ProgressSummaryCard extends StatelessWidget {
  final int completed;
  final int total;

  ProgressSummaryCard({
    super.key,
    required this.completed,
    required this.total,
  });

  double get _progress => total == 0 ? 0.0 : completed / total;

  String get _microcopy {
    if (total == 0) return 'Nenhum hábito para hoje.';
    if (completed == 0) return 'Comece pelo primeiro hábito!';
    if (completed == total) return 'Parabéns! Todos os hábitos concluídos!';
    if (_progress >= 0.5) return 'Bom trabalho! Continue assim.';
    return 'Você consegue! Falta pouco.';
  }

  @override
  Widget build(BuildContext context) {
    final pct = total == 0 ? 0 : ((_progress * 100).round());

    return Semantics(
      container: true,
      label: total == 0
          ? 'Nenhum hábito para hoje'
          : '$completed de $total hábitos concluídos hoje, $pct por cento',
      child: ExcludeSemantics(
        child: Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: SahColors.surface,
        borderRadius: BorderRadius.circular(SahRadius.lg),
        boxShadow: SahShadows.sm,
        border: Border.all(color: SahColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$completed',
                style: TextStyle(
                  fontFamily: 'GeneralSans',
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: SahColors.primary,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 6, left: 4),
                child: Text(
                  '/ $total',
                  style: GoogleFonts.interTight(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: SahColors.textMuted,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ),
              Spacer(),
              Text(
                '$pct%',
                style: GoogleFonts.interTight(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: completed == total && total > 0
                      ? SahColors.primary
                      : SahColors.textMuted,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          SahProgressBar(value: _progress),
          SizedBox(height: 10),
          Text(
            _microcopy,
            style: GoogleFonts.interTight(
              fontSize: 13,
              color: SahColors.textMuted,
            ),
          ),
        ],
      ),
        ),
      ),
    );
  }
}
