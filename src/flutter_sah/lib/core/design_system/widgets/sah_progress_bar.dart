import 'package:flutter/material.dart';
import '../tokens/sah_colors.dart';

class SahProgressBar extends StatelessWidget {
  final double value; // 0.0 a 1.0
  final Color? color;
  final double height;

  const SahProgressBar({
    super.key,
    required this.value,
    this.color,
    this.height = 6,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: SizedBox(
        height: height,
        child: LinearProgressIndicator(
          value: value.clamp(0.0, 1.0),
          backgroundColor: SahColors.bgAlt,
          valueColor: AlwaysStoppedAnimation(color ?? SahColors.primary),
          minHeight: height,
        ),
      ),
    );
  }
}
