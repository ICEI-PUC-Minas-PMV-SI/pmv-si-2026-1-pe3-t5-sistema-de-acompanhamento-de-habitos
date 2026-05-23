import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/design_system/widgets/sah_button.dart';
import '../../../../core/routing/routes.dart';
import '../../../../l10n/app_localizations.dart';

class OnboardingHintCard extends StatelessWidget {
  const OnboardingHintCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context)!;
    return Semantics(
      container: true,
      label: '${l.onboardingHintTitle}. ${l.onboardingHintBody}',
      child: ExcludeSemantics(
        child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: SahColors.accentFaint,
        borderRadius: BorderRadius.circular(SahRadius.lg),
        border: Border.all(color: SahColors.accentSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                PhosphorIconsRegular.sparkle,
                size: 18,
                color: SahColors.accent,
              ),
              const SizedBox(width: 8),
              Text(
                l.onboardingHintTitle,
                style: TextStyle(
                  fontFamily: 'GeneralSans',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: SahColors.text,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            l.onboardingHintBody,
            style: GoogleFonts.interTight(
              fontSize: 13,
              color: SahColors.textMuted,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14),
          SahButton.primary(
            label: l.onboardingHintAction,
            size: SahButtonSize.sm,
            onPressed: () => context.push(Routes.onboarding),
          ),
        ],
      ),
        ),
      ),
    );
  }
}
