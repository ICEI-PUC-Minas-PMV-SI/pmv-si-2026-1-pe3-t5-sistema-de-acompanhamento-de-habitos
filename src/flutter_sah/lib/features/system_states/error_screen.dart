import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/design_system/tokens/sah_colors.dart';
import '../../core/design_system/tokens/sah_radius.dart';
import '../../core/design_system/tokens/sah_spacing.dart';
import '../../core/design_system/widgets/sah_button.dart';
import '../../core/routing/routes.dart';

class ErrorScreen extends StatelessWidget {
  final String? message;
  final String? refCode;

  const ErrorScreen({super.key, this.message, this.refCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SahColors.bg,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(SahSpacing.x8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: SahColors.dangerSoft,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.error_outline_rounded,
                    size: 48,
                    color: SahColors.danger,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Algo deu errado.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'GeneralSans',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: SahColors.text,
                    letterSpacing: -0.48,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  message ?? 'Não foi possível carregar esta página. Tente novamente.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.interTight(
                    fontSize: 15,
                    color: SahColors.textMuted,
                    height: 1.6,
                  ),
                ),
                if (refCode != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: SahColors.bgAlt,
                      borderRadius: BorderRadius.circular(SahRadius.sm),
                      border: Border.all(color: SahColors.border),
                    ),
                    child: Text(
                      'Ref: $refCode',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12,
                        color: SahColors.textMuted,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                SahButton.primary(
                  label: 'Ir para o início',
                  onPressed: () => context.go(Routes.login),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
