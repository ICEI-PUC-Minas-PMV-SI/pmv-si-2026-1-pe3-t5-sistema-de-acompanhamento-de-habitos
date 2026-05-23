import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../tokens/sah_colors.dart';
import '../tokens/sah_spacing.dart';
import 'sah_button.dart';

class SahErrorState extends StatelessWidget {
  final Widget illustration;
  final String title;
  final String description;
  final String? refCode;
  final VoidCallback? onRetry;
  final VoidCallback? onHome;

  const SahErrorState({
    super.key,
    required this.illustration,
    this.title = 'Algo deu errado no nosso lado',
    this.description =
        'Não foi possível carregar os dados. A equipe já foi notificada e está investigando.',
    this.refCode,
    this.onRetry,
    this.onHome,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SahSpacing.x10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 160, height: 160, child: illustration),
            const SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'GeneralSans',
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: SahColors.text,
                letterSpacing: -0.33,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.interTight(
                fontSize: 15,
                color: SahColors.textMuted,
                height: 1.6,
              ),
            ),
            if (refCode != null) ...[
              const SizedBox(height: 6),
              Text(
                refCode!,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11,
                  color: SahColors.textFaint,
                ),
              ),
            ],
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (onHome != null)
                  SahButton.secondary(
                    label: 'Voltar ao início',
                    onPressed: onHome,
                  ),
                if (onHome != null && onRetry != null)
                  const SizedBox(width: 10),
                if (onRetry != null)
                  SahButton.primary(
                    label: 'Tentar novamente',
                    onPressed: onRetry,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
