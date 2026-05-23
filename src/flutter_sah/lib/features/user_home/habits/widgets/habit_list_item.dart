import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/design_system/tokens/sah_shadows.dart';
import '../../../../core/design_system/widgets/sah_action_sheet.dart';
import '../../../../data/models/category.dart';
import '../../../../data/models/habit.dart';

class HabitListItem extends StatelessWidget {
  final Habit habit;
  final Category? category;
  final int streak;
  final VoidCallback onEdit;
  final VoidCallback onArchive;
  final VoidCallback onDelete;

  HabitListItem({
    super.key,
    required this.habit,
    required this.category,
    required this.streak,
    required this.onEdit,
    required this.onArchive,
    required this.onDelete,
  });


  Color get _catColor {
    if (category == null) return SahColors.primary;
    try {
      return Color(
        int.parse('FF${category!.cor.replaceAll('#', '')}', radix: 16),
      );
    } catch (_) {
      return SahColors.primary;
    }
  }

  String _freqLabel(List<int> freq) {
    if (freq.length == 7) return 'Todos os dias';
    if (freq.length == 5 &&
        freq.contains(1) &&
        freq.contains(5) &&
        !freq.contains(0) &&
        !freq.contains(6)) {
      return 'Seg – Sex';
    }
    if (freq.length == 1) return '1x por semana';
    return '${freq.length}x por semana';
  }

  @override
  Widget build(BuildContext context) {
    final isArchived = habit.arquivado;

    return Opacity(
      opacity: isArchived ? 0.55 : 1.0,
      child: Material(
        color: SahColors.surface,
        borderRadius: BorderRadius.circular(SahRadius.lg),
        child: InkWell(
          onTap: onEdit,
          borderRadius: BorderRadius.circular(SahRadius.lg),
          splashColor: _catColor.withAlpha(20),
          highlightColor: _catColor.withAlpha(10),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SahRadius.lg),
              boxShadow: SahShadows.sm,
              border: Border.all(color: SahColors.border),
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Acento lateral colorido
                  Container(width: 4, color: _catColor),
                  // Conteúdo
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 12, 8, 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      // Ícone de categoria
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: _catColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(SahRadius.sm),
                        ),
                        child: Center(
                          child: Text(
                            category?.nome.substring(0, 1).toUpperCase() ?? '?',
                            style: GoogleFonts.interTight(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: _catColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      // Textos
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    habit.nome,
                                    style: TextStyle(
                                      fontFamily: 'GeneralSans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: SahColors.text,
                                      decoration: isArchived
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (streak > 0) ...[
                                  SizedBox(width: 6),
                                  _StreakBadge(streak: streak),
                                ],
                              ],
                            ),
                            if (habit.descricao.isNotEmpty) ...[
                              SizedBox(height: 2),
                              Text(
                                habit.descricao,
                                style: GoogleFonts.interTight(
                                  fontSize: 12,
                                  color: SahColors.textMuted,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                            SizedBox(height: 4),
                            Row(
                              children: [
                                if (category != null) ...[
                                  _CategoryChip(
                                      label: category!.nome, color: _catColor),
                                  SizedBox(width: 6),
                                ],
                                Text(
                                  _freqLabel(habit.frequencia),
                                  style: GoogleFonts.interTight(
                                    fontSize: 11,
                                    color: SahColors.textFaint,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Menu
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: Icon(
                          Icons.more_vert_rounded,
                          size: 18,
                          color: SahColors.textMuted,
                        ),
                        onPressed: () => showSahActionSheet(
                          context,
                          title: habit.nome,
                          actions: [
                            SahActionItem(
                              icon: Icons.edit_outlined,
                              label: 'Editar',
                              onTap: () {
                                Navigator.pop(context);
                                onEdit();
                              },
                            ),
                            SahActionItem(
                              icon: isArchived
                                  ? Icons.unarchive_outlined
                                  : Icons.archive_outlined,
                              label: isArchived ? 'Desarquivar' : 'Arquivar',
                              onTap: () {
                                Navigator.pop(context);
                                onArchive();
                              },
                            ),
                            SahActionItem(
                              icon: Icons.delete_outline,
                              label: 'Excluir',
                              destructive: true,
                              onTap: () {
                                Navigator.pop(context);
                                onDelete();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    ),
    );
  }
}

class _StreakBadge extends StatelessWidget {
  final int streak;
  _StreakBadge({required this.streak});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: SahColors.streakSoft,
        borderRadius: BorderRadius.circular(SahRadius.full),
        border: Border.all(color: SahColors.streak.withAlpha(60)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.local_fire_department_rounded,
              size: 11, color: SahColors.streak),
          SizedBox(width: 2),
          Text(
            '$streak',
            style: GoogleFonts.interTight(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: SahColors.streak,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final Color color;
  _CategoryChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
