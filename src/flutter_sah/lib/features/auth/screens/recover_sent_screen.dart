import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/design_system/tokens/sah_colors.dart';
import '../../../core/design_system/tokens/sah_spacing.dart';
import '../../../core/design_system/widgets/sah_button.dart';
import '../../../core/routing/routes.dart';

class RecoverSentScreen extends StatelessWidget {
  const RecoverSentScreen({super.key});

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
                // Ilustração envelope
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: SahColors.primaryFaint,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.mail_outline_rounded,
                    size: 56,
                    color: SahColors.primary,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Link enviado.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'GeneralSans',
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: SahColors.text,
                    letterSpacing: -0.52,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Acesse sua caixa de entrada e clique no link recebido para redefinir sua senha.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.interTight(
                    fontSize: 15,
                    color: SahColors.textMuted,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 32),
                SahButton.primary(
                  label: 'Voltar ao login',
                  onPressed: () => context.go(Routes.login),
                ),
                const SizedBox(height: 12),
                SahButton.ghost(
                  label: 'Tenho meu código',
                  onPressed: () => context.go(Routes.resetPassword),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
