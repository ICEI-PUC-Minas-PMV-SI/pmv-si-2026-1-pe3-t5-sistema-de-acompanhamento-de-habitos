import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../habits/utils/reminder_suggestions.dart';

class ReminderSuggestionCard extends StatelessWidget {
  final ReminderSuggestion suggestion;
  final String habitName;
  final VoidCallback onApply;
  final VoidCallback onDismiss;

  const ReminderSuggestionCard({
    super.key,
    required this.suggestion,
    required this.habitName,
    required this.onApply,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
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
              Icon(PhosphorIconsRegular.lightbulb,
                  size: 18, color: SahColors.accent),
              const SizedBox(width: 8),
              Text(
                'Insight',
                style: TextStyle(
                  fontFamily: 'GeneralSans',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: SahColors.accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Você costuma marcar "$habitName" perto das ${suggestion.suggestedReminder}, '
            'mas o lembrete está às ${suggestion.currentReminder}. '
            'Quer ajustar?',
            style: GoogleFonts.interTight(
              fontSize: 13,
              color: SahColors.text,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              TextButton(
                onPressed: onDismiss,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                child: Text(
                  'Agora não',
                  style: GoogleFonts.interTight(
                    fontSize: 13,
                    color: SahColors.textMuted,
                  ),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: onApply,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                child: Text(
                  'Ajustar para ${suggestion.suggestedReminder}',
                  style: GoogleFonts.interTight(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: SahColors.accent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
