import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/design_system/tokens/sah_colors.dart';
import '../../../core/utils/validators.dart';

class PasswordStrengthMeter extends StatelessWidget {
  final String password;

  PasswordStrengthMeter({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty) return SizedBox.shrink();
    final strength = SahValidators.passwordStrength(password);
    final (color, label, segments) = switch (strength) {
      PasswordStrength.none => (SahColors.bgAlt, '', 0),
      PasswordStrength.weak => (SahColors.danger, 'Fraca', 1),
      PasswordStrength.fair => (SahColors.streak, 'Razoável', 2),
      PasswordStrength.good => (SahColors.primary, 'Boa', 3),
      PasswordStrength.strong => (SahColors.primary, 'Forte', 4),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Row(
          children: List.generate(4, (i) {
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
                height: 4,
                decoration: BoxDecoration(
                  color: i < segments ? color : SahColors.bgAlt,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        if (label.isNotEmpty) ...[
          SizedBox(height: 4),
          Text(
            'Senha $label',
            style: GoogleFonts.interTight(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}
