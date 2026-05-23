import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/design_system/tokens/sah_colors.dart';
import '../../../core/design_system/tokens/sah_radius.dart';
import '../../../core/design_system/tokens/sah_spacing.dart';

class ComingSoonCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> rfCodes;

  ComingSoonCard({
    super.key,
    required this.title,
    required this.description,
    this.rfCodes = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(SahSpacing.pagePadding),
      padding: EdgeInsets.all(SahSpacing.cardPadding),
      decoration: BoxDecoration(
        color: SahColors.surface,
        borderRadius: BorderRadius.circular(SahRadius.lg),
        border: Border.all(color: SahColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: SahColors.accentFaint,
              borderRadius: BorderRadius.circular(SahRadius.md),
            ),
            child: Icon(Icons.construction_rounded, size: 22, color: SahColors.accent),
          ),
          SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'GeneralSans',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: SahColors.text,
              letterSpacing: -0.4,
            ),
          ),
          SizedBox(height: 6),
          Text(
            description,
            style: GoogleFonts.interTight(
              fontSize: 14,
              color: SahColors.textMuted,
              height: 1.5,
            ),
          ),
          if (rfCodes.isNotEmpty) ...[
            SizedBox(height: 16),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: rfCodes.map((code) => _RfChip(code)).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _RfChip extends StatelessWidget {
  final String code;
  _RfChip(this.code);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: SahColors.primarySoft,
        borderRadius: BorderRadius.circular(SahRadius.full),
      ),
      child: Text(
        code,
        style: GoogleFonts.interTight(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: SahColors.primary,
        ),
      ),
    );
  }
}
