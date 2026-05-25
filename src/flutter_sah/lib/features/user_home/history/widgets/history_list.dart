import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/design_system/tokens/sah_spacing.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../data/models/execution_log.dart';

class HistoryList extends StatelessWidget {
  final Map<DateTime, List<ExecutionLog>> logsByDay;

  const HistoryList({super.key, required this.logsByDay});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: logsByDay.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: SahSpacing.x4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  SahFormatters.date(entry.key),
                  style: GoogleFonts.interTight(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: SahColors.textMuted,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: SahColors.surface,
                  borderRadius: BorderRadius.circular(SahRadius.md),
                  border: Border.all(color: SahColors.border),
                ),
                child: Column(
                  children: entry.value.asMap().entries.map((e) {
                    final isLast = e.key == entry.value.length - 1;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: SahColors.primaryFaint,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check,
                                  size: 14,
                                  color: SahColors.primary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Concluído',
                                style: GoogleFonts.interTight(
                                  fontSize: 13,
                                  color: SahColors.text,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                _timeOnly(e.value.dataHora),
                                style: GoogleFonts.jetBrainsMono(
                                  fontSize: 12,
                                  color: SahColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!isLast)
                          Divider(
                            height: 1,
                            color: SahColors.border,
                            indent: 56,
                          ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  String _timeOnly(DateTime dt) =>
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
}
