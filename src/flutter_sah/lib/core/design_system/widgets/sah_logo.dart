import 'package:flutter/material.dart';
import '../tokens/sah_colors.dart';

class SahLogo extends StatelessWidget {
  final double size;
  final bool showText;
  final Color? color;

  const SahLogo({
    super.key,
    this.size = 28,
    this.showText = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(
          size: Size(size, size),
          painter: _LogoPainter(color: color ?? SahColors.primary),
        ),
        if (showText) ...[
          SizedBox(width: size * 0.36),
          Text(
            'SAH',
            style: TextStyle(
              fontFamily: 'GeneralSans',
              fontSize: size * 0.56,
              fontWeight: FontWeight.w700,
              color: SahColors.text,
              letterSpacing: -0.02 * size * 0.56,
              height: 1,
            ),
          ),
        ],
      ],
    );
  }
}

class _LogoPainter extends CustomPainter {
  final Color color;
  const _LogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Aura
    final auraPaint = Paint()
      ..color = color.withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(cx, cy), cx * 0.875, auraPaint);

    // Blob
    final blobPaint = Paint()
      ..color = color.withValues(alpha: 0.9)
      ..style = PaintingStyle.fill;
    final blobPath = Path()
      ..moveTo(size.width * 0.28, size.height * 0.625)
      ..quadraticBezierTo(
          size.width * 0.28, size.height * 0.34375, cx, size.height * 0.34375)
      ..quadraticBezierTo(
          size.width * 0.71875, size.height * 0.34375, size.width * 0.71875, cy)
      ..quadraticBezierTo(
          size.width * 0.71875, size.height * 0.65625, cx, size.height * 0.65625)
      ..quadraticBezierTo(size.width * 0.375, size.height * 0.65625,
          size.width * 0.28, size.height * 0.625)
      ..close();
    canvas.drawPath(blobPath, blobPaint);

    // Centro branco
    final centerPaint = Paint()
      ..color = SahColors.bg
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(cx, cy), size.width * 0.09375, centerPaint);

    // Dot dourado (streak)
    final dotPaint = Paint()
      ..color = SahColors.streak
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width * 0.6875, size.height * 0.3125),
        size.width * 0.078125, dotPaint);
  }

  @override
  bool shouldRepaint(_LogoPainter old) => old.color != color;
}
