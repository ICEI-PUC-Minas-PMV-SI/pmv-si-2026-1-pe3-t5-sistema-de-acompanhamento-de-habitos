import 'package:flutter/material.dart';
import '../../core/design_system/tokens/sah_colors.dart';
import '../../core/design_system/widgets/sah_logo.dart';
import '../../core/design_system/widgets/sah_spinner.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SahColors.bg,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SahLogo(size: 48),
            SizedBox(height: 32),
            SahSpinner(size: 20, color: SahColors.textFaint),
          ],
        ),
      ),
    );
  }
}
