import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/widgets/sah_card.dart';
import '../../../../l10n/app_localizations.dart';

/// Heatmap estilo GitHub-contributions: cada célula representa um dia.
/// Verde quando há check-in, cinza claro quando não.
class HistoryHeatmap extends StatelessWidget {
  final List<({DateTime day, bool done})> data;

  const HistoryHeatmap({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox.shrink();
    final l = AppL10n.of(context)!;

    // Agrupa em colunas semanais (segunda como início)
    // Cada coluna é uma lista de 7 entradas (dom..sab) nullable
    final columns = <List<({DateTime day, bool done})?>>[];
    var currentColumn = List<({DateTime day, bool done})?>.filled(7, null);
    DateTime? prevWeekStart;
    for (final entry in data) {
      final weekday = entry.day.weekday % 7; // 0=dom..6=sab
      final weekStart = entry.day
          .subtract(Duration(days: (entry.day.weekday - DateTime.monday) % 7));
      if (prevWeekStart != null && weekStart != prevWeekStart) {
        columns.add(currentColumn);
        currentColumn = List<({DateTime day, bool done})?>.filled(7, null);
      }
      currentColumn[weekday] = entry;
      prevWeekStart = weekStart;
    }
    columns.add(currentColumn);

    return SahCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.historyHeatmapTitle,
            style: TextStyle(
              fontFamily: 'GeneralSans',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: SahColors.text,
            ),
          ),
          Text(
            l.historyHeatmapSubtitle,
            style: GoogleFonts.interTight(
              fontSize: 11,
              color: SahColors.textMuted,
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true, // começa pelo mais recente (esquerda da viewport)
            child: Row(
              children: [
                for (final col in columns) ...[
                  _Column(entries: col),
                  const SizedBox(width: 3),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Column extends StatelessWidget {
  final List<({DateTime day, bool done})?> entries;

  const _Column({required this.entries});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final e in entries) ...[
          _Cell(entry: e),
          const SizedBox(height: 3),
        ],
      ],
    );
  }
}

class _Cell extends StatelessWidget {
  final ({DateTime day, bool done})? entry;

  const _Cell({required this.entry});

  @override
  Widget build(BuildContext context) {
    final color = entry == null
        ? Colors.transparent
        : (entry!.done ? SahColors.primary : SahColors.bgAlt);
    final l = AppL10n.of(context)!;
    return Tooltip(
      message: entry == null
          ? ''
          : '${_formatDate(entry!.day)} · ${entry!.done ? l.historyDoneStatus : l.historyMissedStatus}',
      child: Container(
        width: 13,
        height: 13,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3),
          border: entry != null && !entry!.done
              ? Border.all(color: SahColors.border)
              : null,
        ),
      ),
    );
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}
