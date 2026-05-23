import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_spacing.dart';
import '../../../../core/design_system/widgets/sah_card.dart';
import '../../../../core/design_system/widgets/sah_progress_bar.dart';

class HistorySummaryCard extends StatelessWidget {
  final int checkIns;
  final int scheduledDays;
  final double adherence;
  final int bestStreak;

  const HistorySummaryCard({
    super.key,
    required this.checkIns,
    required this.scheduledDays,
    required this.adherence,
    required this.bestStreak,
  });

  @override
  Widget build(BuildContext context) {
    final adherencePct = scheduledDays > 0
        ? '${(adherence * 100).round()}%'
        : '—';

    return SahCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: SahSpacing.x4,
            runSpacing: SahSpacing.x4,
            children: [
              _MetricTile(label: 'Check-ins', value: '$checkIns'),
              _MetricTile(label: 'Dias agendados', value: '$scheduledDays'),
              _MetricTile(label: 'Melhor streak', value: '$bestStreak dias'),
              _MetricTile(label: 'Aderência', value: adherencePct),
            ],
          ),
          if (scheduledDays > 0) ...[
            SizedBox(height: 12),
            SahProgressBar(value: adherence, height: 8),
          ],
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final String label;
  final String value;

  const _MetricTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.interTight(
              fontSize: 11,
              color: SahColors.textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'GeneralSans',
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: SahColors.text,
              letterSpacing: -0.4,
            ),
          ),
        ],
      ),
    );
  }
}
