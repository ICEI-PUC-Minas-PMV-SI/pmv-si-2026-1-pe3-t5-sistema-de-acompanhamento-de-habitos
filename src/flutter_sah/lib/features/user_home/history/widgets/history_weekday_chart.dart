import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/widgets/sah_card.dart';
import '../../../../l10n/app_localizations.dart';

const _kLabels = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];

class HistoryWeekdayChart extends StatelessWidget {
  /// Map<int dayOfWeek, int count> com 0=dom..6=sab
  final Map<int, int> data;

  const HistoryWeekdayChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final total = data.values.fold<int>(0, (a, b) => a + b);
    if (total == 0) return const SizedBox.shrink();
    final maxY = data.values.reduce((a, b) => a > b ? a : b).toDouble();
    final l = AppL10n.of(context)!;

    return SahCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.historyWeekdayTitle,
            style: TextStyle(
              fontFamily: 'GeneralSans',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: SahColors.text,
            ),
          ),
          Text(
            l.historyWeekdaySubtitle,
            style: GoogleFonts.interTight(
              fontSize: 11,
              color: SahColors.textMuted,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 140,
            child: BarChart(
              BarChartData(
                maxY: maxY * 1.2,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 24,
                      getTitlesWidget: (v, _) {
                        final i = v.toInt();
                        if (i < 0 || i > 6) return const SizedBox();
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            _kLabels[i],
                            style: GoogleFonts.interTight(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: SahColors.textMuted,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: [
                  for (var i = 0; i < 7; i++)
                    BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: (data[i] ?? 0).toDouble(),
                          color: SahColors.primary,
                          width: 18,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(4),
                          ),
                        ),
                      ],
                    ),
                ],
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => SahColors.text,
                    tooltipPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    getTooltipItem: (group, _, rod, __) => BarTooltipItem(
                      l.historyCheckInsTooltip(rod.toY.toInt()),
                      GoogleFonts.interTight(
                        color: SahColors.surface,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
