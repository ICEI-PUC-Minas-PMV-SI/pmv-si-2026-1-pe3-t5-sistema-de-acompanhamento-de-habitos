import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../tokens/sah_colors.dart';
import '../tokens/sah_radius.dart';

enum SahBadgeVariant { neutral, success, warning, danger, accent, info }

enum SahBadgeSize { sm, md }

class SahBadge extends StatelessWidget {
  final String text;
  final SahBadgeVariant variant;
  final SahBadgeSize size;
  final bool withDot;
  final Widget? icon;

  const SahBadge(
    this.text, {
    super.key,
    this.variant = SahBadgeVariant.neutral,
    this.size = SahBadgeSize.md,
    this.withDot = false,
    this.icon,
  });

  const SahBadge.neutral(this.text,
      {super.key,
      this.size = SahBadgeSize.md,
      this.withDot = false,
      this.icon})
      : variant = SahBadgeVariant.neutral;

  const SahBadge.success(this.text,
      {super.key,
      this.size = SahBadgeSize.md,
      this.withDot = false,
      this.icon})
      : variant = SahBadgeVariant.success;

  const SahBadge.warning(this.text,
      {super.key,
      this.size = SahBadgeSize.md,
      this.withDot = false,
      this.icon})
      : variant = SahBadgeVariant.warning;

  const SahBadge.danger(this.text,
      {super.key,
      this.size = SahBadgeSize.md,
      this.withDot = false,
      this.icon})
      : variant = SahBadgeVariant.danger;

  const SahBadge.accent(this.text,
      {super.key,
      this.size = SahBadgeSize.md,
      this.withDot = false,
      this.icon})
      : variant = SahBadgeVariant.accent;

  const SahBadge.info(this.text,
      {super.key,
      this.size = SahBadgeSize.md,
      this.withDot = false,
      this.icon})
      : variant = SahBadgeVariant.info;

  (Color bg, Color fg, Color dot) get _colors => switch (variant) {
        SahBadgeVariant.neutral => (
            SahColors.bgAlt,
            SahColors.textMuted,
            SahColors.textFaint
          ),
        SahBadgeVariant.success => (
            SahColors.primarySoft,
            SahColors.primary,
            SahColors.primary
          ),
        SahBadgeVariant.warning => (
            SahColors.streakSoft,
            SahColors.streakText,
            SahColors.streak
          ),
        SahBadgeVariant.danger => (
            SahColors.dangerSoft,
            SahColors.danger,
            SahColors.danger
          ),
        SahBadgeVariant.accent => (
            SahColors.accentSoft,
            SahColors.accent,
            SahColors.accent
          ),
        SahBadgeVariant.info => (SahColors.infoSoft, SahColors.info, SahColors.info),
      };

  @override
  Widget build(BuildContext context) {
    final (bg, fg, dot) = _colors;
    final padding = size == SahBadgeSize.sm
        ? const EdgeInsets.symmetric(horizontal: 8, vertical: 2)
        : const EdgeInsets.symmetric(horizontal: 10, vertical: 3);
    final fontSize = size == SahBadgeSize.sm ? 11.0 : 12.0;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(SahRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (withDot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: dot,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 6),
          ],
          if (icon != null) ...[
            IconTheme(data: IconThemeData(color: fg, size: fontSize), child: icon!),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: GoogleFonts.interTight(
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
              color: fg,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
