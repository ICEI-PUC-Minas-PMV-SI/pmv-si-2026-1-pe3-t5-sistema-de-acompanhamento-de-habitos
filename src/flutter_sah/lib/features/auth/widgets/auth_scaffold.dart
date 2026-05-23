import 'package:flutter/material.dart';
import '../../../core/design_system/tokens/sah_colors.dart';
import '../../../core/design_system/tokens/sah_palette_scope.dart';
import '../../../core/design_system/tokens/sah_spacing.dart';
import '../../../core/design_system/widgets/sah_logo.dart';

class AuthScaffold extends StatelessWidget {
  final Widget child;
  final bool showLogo;

  AuthScaffold({super.key, required this.child, this.showLogo = true});

  @override
  Widget build(BuildContext context) {
    SahPaletteScope.subscribe(context);
    return Scaffold(
      backgroundColor: SahColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: SahSpacing.pagePadding,
              vertical: SahSpacing.sectionGap),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showLogo) ...[
                SahLogo(size: 32),
                SizedBox(height: SahSpacing.x10),
              ],
              child,
            ],
          ),
        ),
      ),
    );
  }
}
