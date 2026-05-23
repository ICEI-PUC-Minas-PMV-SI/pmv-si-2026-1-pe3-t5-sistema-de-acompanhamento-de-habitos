import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../tokens/sah_colors.dart';
import '../tokens/sah_radius.dart';
import '../icons/sah_icon.dart';
import '../icons/sah_icon_data.dart';

class SahFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onRemove;
  final VoidCallback? onTap;

  const SahFilterChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onRemove,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: selected ? SahColors.primaryFaint : SahColors.bgAlt,
          borderRadius: BorderRadius.circular(SahRadius.full),
          border: Border.all(
            color: selected ? SahColors.primarySoft : SahColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.interTight(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color:
                    selected ? SahColors.primary : SahColors.textMuted,
              ),
            ),
            if (onRemove != null) ...[
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onRemove,
                child: SahIcon(
                  SahIconName.close,
                  size: 12,
                  color: selected ? SahColors.primary : SahColors.textFaint,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
