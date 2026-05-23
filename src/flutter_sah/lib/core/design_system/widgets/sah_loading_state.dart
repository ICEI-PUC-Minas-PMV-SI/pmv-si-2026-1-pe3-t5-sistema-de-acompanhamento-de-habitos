import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../tokens/sah_colors.dart';
import 'sah_spinner.dart';

class SahLoadingState extends StatelessWidget {
  final String message;

  const SahLoadingState({
    super.key,
    this.message = 'Carregando…',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SahSpinner(size: 32),
          const SizedBox(height: 16),
          Text(
            message,
            style: GoogleFonts.interTight(
              fontSize: 14,
              color: SahColors.textMuted,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
