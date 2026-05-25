import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/design_system/tokens/sah_shadows.dart';
import '../../../../core/design_system/widgets/sah_action_sheet.dart';
import '../../../../core/design_system/widgets/sah_badge.dart';
import '../../../../data/models/category.dart';
import '../../../../l10n/app_localizations.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  final int habitCount;
  final bool readOnly;
  final bool showGlobalBadge;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CategoryTile({
    super.key,
    required this.category,
    required this.habitCount,
    required this.onEdit,
    required this.onDelete,
    this.readOnly = false,
    this.showGlobalBadge = false,
  });

  Color get _color {
    try {
      return Color(
        int.parse('FF${category.cor.replaceAll('#', '')}', radix: 16),
      );
    } catch (_) {
      return SahColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context)!;
    final color = _color;

    return Material(
      color: SahColors.surface,
      borderRadius: BorderRadius.circular(SahRadius.md),
      child: InkWell(
        onTap: readOnly ? null : onEdit,
        borderRadius: BorderRadius.circular(SahRadius.md),
        splashColor: color.withAlpha(20),
        highlightColor: color.withAlpha(10),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SahRadius.md),
            border: Border.all(color: SahColors.border),
            boxShadow: SahShadows.sm,
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(width: 4, color: color),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: color.withAlpha(25),
                            borderRadius: BorderRadius.circular(SahRadius.sm),
                          ),
                          child: Center(
                            child: Text(
                              category.nome.isNotEmpty
                                  ? category.nome.substring(0, 1).toUpperCase()
                                  : '?',
                              style: GoogleFonts.interTight(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: color,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                category.nome,
                                style: TextStyle(
                                  fontFamily: 'GeneralSans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: SahColors.text,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                l.adminCategoriesHabitCount(habitCount),
                                style: GoogleFonts.interTight(
                                  fontSize: 11,
                                  color: SahColors.textFaint,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (showGlobalBadge)
                          SahBadge.neutral(
                            l.adminCategoriesGlobalBadge,
                            size: SahBadgeSize.sm,
                          )
                        else if (!readOnly)
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: Icon(
                              Icons.more_vert_rounded,
                              size: 18,
                              color: SahColors.textMuted,
                            ),
                            onPressed: () => showSahActionSheet(
                              context,
                              title: category.nome,
                              actions: [
                                SahActionItem(
                                  icon: Icons.edit_outlined,
                                  label: l.commonEdit,
                                  onTap: () {
                                    Navigator.pop(context);
                                    onEdit();
                                  },
                                ),
                                SahActionItem(
                                  icon: Icons.delete_outline,
                                  label: l.commonDelete,
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
    );
  }
}
