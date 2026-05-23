import 'package:flutter/material.dart';
import '../tokens/sah_colors.dart';
import 'sah_icon_data.dart';

// Tamanhos canônicos: 14 (inline/badge), 16 (input prefix), 20 (nav/sidebar), 24 (empty-state)
class SahIcon extends StatelessWidget {
  final SahIconName name;
  final double size;
  final Color? color;

  const SahIcon(this.name, {super.key, this.size = 20, this.color});

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        color ?? DefaultTextStyle.of(context).style.color ?? SahColors.text;
    return Icon(sahIconData(name), size: size, color: effectiveColor);
  }
}
