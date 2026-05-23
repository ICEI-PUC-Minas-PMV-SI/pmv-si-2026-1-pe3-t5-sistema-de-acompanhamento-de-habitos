import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../tokens/sah_colors.dart';
import '../tokens/sah_spacing.dart';

class SahEmptyState extends StatelessWidget {
  final Widget? illustration;
  final String title;
  final String description;
  final Widget? primaryAction;

  SahEmptyState({
    super.key,
    this.illustration,
    required this.title,
    required this.description,
    this.primaryAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(SahSpacing.x8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (illustration != null)
              SizedBox(width: 140, height: 140, child: illustration)
            else
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: SahColors.bgAlt,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.inbox_rounded, size: 36, color: SahColors.textFaint),
              ),
            SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'GeneralSans',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: SahColors.text,
                letterSpacing: -0.3,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.interTight(
                fontSize: 14,
                color: SahColors.textMuted,
                height: 1.6,
              ),
            ),
            if (primaryAction != null) ...[
              SizedBox(height: 24),
              primaryAction!,
            ],
          ],
        ),
      ),
    );
  }
}
