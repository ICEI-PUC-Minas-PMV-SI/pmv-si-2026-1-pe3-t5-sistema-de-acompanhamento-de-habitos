import 'package:flutter/material.dart';
import '../design_system/tokens/sah_colors.dart';
import '../design_system/tokens/sah_radius.dart';
import '../design_system/widgets/sah_button.dart';

Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'Confirmar',
  String cancelLabel = 'Cancelar',
  bool isDangerous = false,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: SahColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SahRadius.lg),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'GeneralSans',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: SahColors.text,
        ),
      ),
      content: Text(
        message,
        style: TextStyle(
          fontFamily: 'InterTight',
          fontSize: 14,
          color: SahColors.textMuted,
        ),
      ),
      actions: [
        SahButton.ghost(
          label: cancelLabel,
          onPressed: () => Navigator.of(ctx).pop(false),
        ),
        isDangerous
            ? SahButton.danger(
                label: confirmLabel,
                onPressed: () => Navigator.of(ctx).pop(true),
              )
            : SahButton.primary(
                label: confirmLabel,
                onPressed: () => Navigator.of(ctx).pop(true),
              ),
      ],
    ),
  );
  return result ?? false;
}
