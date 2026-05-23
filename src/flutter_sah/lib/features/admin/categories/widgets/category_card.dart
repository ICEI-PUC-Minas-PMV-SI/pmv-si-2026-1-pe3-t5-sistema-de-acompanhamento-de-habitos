import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/design_system/icons/sah_icon_data.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/design_system/tokens/sah_shadows.dart';
import '../../../../core/design_system/widgets/sah_badge.dart';
import '../../../../data/models/category.dart';
import '../../../../l10n/app_localizations.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final int habitCount;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool readOnly;
  final bool showGlobalBadge;

  const CategoryCard({
    super.key,
    required this.category,
    required this.habitCount,
    required this.onEdit,
    required this.onDelete,
    this.readOnly = false,
    this.showGlobalBadge = false,
  });

  Color _parseColor(String hex) {
    try {
      final h = hex.replaceAll('#', '');
      return Color(int.parse('FF$h', radix: 16));
    } catch (_) {
      return SahColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context)!;
    final catColor = _parseColor(category.cor);
    final bg = catColor.withAlpha(26);

    return Container(
      padding: const EdgeInsets.all(14),
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
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(SahRadius.md),
                ),
                child: Center(
                  child: Icon(sahIconData(SahIconName.grid), size: 18, color: catColor),
                ),
              ),
              const Spacer(),
              if (showGlobalBadge)
                SahBadge.neutral(l.adminCategoriesGlobalBadge, size: SahBadgeSize.sm),
              if (!readOnly)
                PopupMenuButton<String>(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.more_vert_rounded, size: 18, color: SahColors.textMuted),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(SahRadius.md),
                  ),
                  color: SahColors.surface,
                  onSelected: (v) {
                    if (v == 'edit') onEdit();
                    if (v == 'delete') onDelete();
                  },
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Text(l.commonEdit, style: GoogleFonts.interTight(fontSize: 14, color: SahColors.text)),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text(l.commonDelete, style: GoogleFonts.interTight(fontSize: 14, color: SahColors.danger)),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 10),
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
          const SizedBox(height: 2),
          Text(
            l.adminCategoriesHabitCount(habitCount),
            style: GoogleFonts.interTight(fontSize: 12, color: SahColors.textMuted),
          ),
        ],
      ),
    );
  }
}
