import 'package:flutter/material.dart';
import '../tokens/sah_colors.dart';
import '../tokens/sah_radius.dart';
import '../tokens/sah_shadows.dart';

Future<T?> showSahModal<T>({
  required BuildContext context,
  required String title,
  required Widget content,
  List<Widget>? actions,
  bool barrierDismissible = true,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: const Color.fromRGBO(40, 30, 20, 0.45),
    builder: (ctx) => _SahModal(
      title: title,
      content: content,
      actions: actions,
    ),
  );
}

class _SahModal extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget>? actions;

  const _SahModal(
      {required this.title, required this.content, this.actions});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 440),
        decoration: BoxDecoration(
          color: SahColors.surface,
          borderRadius: BorderRadius.circular(SahRadius.xl),
          boxShadow: SahShadows.lg,
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'GeneralSans',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: SahColors.text,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 16),
            content,
            if (actions != null) ...[
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!
                    .expand((w) => [w, const SizedBox(width: 8)])
                    .toList()
                  ..removeLast(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
