import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/design_system/icons/sah_icon.dart';
import '../../../../core/design_system/icons/sah_icon_data.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/design_system/tokens/sah_shadows.dart';

class MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final SahIconName icon;
  final Color iconColor;
  final Color iconBg;

  const MetricCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: SahColors.surface,
        borderRadius: BorderRadius.circular(SahRadius.lg),
        boxShadow: SahShadows.sm,
        border: Border.all(color: SahColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(SahRadius.md),
            ),
            child: Center(
              child: SahIcon(icon, size: 20, color: iconColor),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: GoogleFonts.interTight(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: SahColors.text,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.interTight(
              fontSize: 13,
              color: SahColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
