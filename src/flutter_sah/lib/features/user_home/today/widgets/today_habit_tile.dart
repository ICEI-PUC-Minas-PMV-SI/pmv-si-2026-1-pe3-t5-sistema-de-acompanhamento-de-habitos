import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/design_system/tokens/sah_shadows.dart';
import '../controllers/today_controller.dart';

class TodayHabitTile extends StatelessWidget {
  final TodayHabitEntry entry;
  final VoidCallback onToggle;

  const TodayHabitTile({
    super.key,
    required this.entry,
    required this.onToggle,
  });

  Color get _catColor {
    if (entry.category == null) return SahColors.primary;
    try {
      return Color(
        int.parse(
          'FF${entry.category!.cor.replaceAll('#', '')}',
          radix: 16,
        ),
      );
    } catch (_) {
      return SahColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final done = entry.doneToday;
    final streakText = entry.streak == 0
        ? 'sem sequência'
        : 'sequência de ${entry.streak} ${entry.streak == 1 ? "dia" : "dias"}';
    final label =
        'Hábito ${entry.habit.nome}, ${done ? "feito hoje" : "pendente"}, $streakText';

    return Semantics(
      button: true,
      enabled: true,
      label: label,
      excludeSemantics: true,
      onTap: onToggle,
      child: GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: done ? _catColor.withAlpha(12) : SahColors.surface,
          borderRadius: BorderRadius.circular(SahRadius.lg),
          boxShadow: SahShadows.sm,
          border: Border.all(
            color: done ? _catColor.withAlpha(80) : SahColors.border,
            width: done ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // Checkbox
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: done ? _catColor : SahColors.surface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: done ? _catColor : SahColors.border,
                  width: 2,
                ),
              ),
              child: done
                  ? Icon(
                      Icons.check_rounded,
                      size: 16,
                      color: SahColors.surface,
                    )
                  : null,
            ),
            const SizedBox(width: 14),
            // Conteúdo
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      fontFamily: 'GeneralSans',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: done ? SahColors.textMuted : SahColors.text,
                      decoration:
                          done ? TextDecoration.lineThrough : TextDecoration.none,
                      decorationColor: SahColors.textFaint,
                    ),
                    child: Text(entry.habit.nome, overflow: TextOverflow.ellipsis),
                  ),
                  if (entry.category != null) ...[
                    const SizedBox(height: 3),
                    _CategoryChip(
                      label: entry.category!.nome,
                      color: _catColor,
                    ),
                  ],
                ],
              ),
            ),
            // Streak badge
            if (entry.streak > 0) ...[
              const SizedBox(width: 8),
              _StreakBadge(streak: entry.streak),
            ],
          ],
        ),
      ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final Color color;
  const _CategoryChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(SahRadius.full),
      ),
      child: Text(
        label,
        style: GoogleFonts.interTight(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}

class _StreakBadge extends StatelessWidget {
  final int streak;
  const _StreakBadge({required this.streak});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: SahColors.streakSoft,
        borderRadius: BorderRadius.circular(SahRadius.full),
        border: Border.all(color: SahColors.streak.withAlpha(60)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.local_fire_department_rounded,
              size: 13, color: SahColors.streak),
          const SizedBox(width: 2),
          Text(
            '$streak',
            style: GoogleFonts.interTight(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: SahColors.streak,
              fontFeatures: [const FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}
