import 'package:flutter/material.dart';

import '../tokens/sah_colors.dart';
import '../tokens/sah_durations.dart';
import '../tokens/sah_radius.dart';

class SahSkeleton extends StatefulWidget {
  final double? width;
  final double height;
  final double radius;

  const SahSkeleton({
    super.key,
    this.width,
    this.height = 16,
    this.radius = SahRadius.sm,
  });

  @override
  State<SahSkeleton> createState() => _SahSkeletonState();
}

class _SahSkeletonState extends State<SahSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: SahDurations.slow)
      ..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Color.lerp(SahColors.bgAlt, SahColors.surfaceAlt, _anim.value),
          borderRadius: BorderRadius.circular(widget.radius),
        ),
      ),
    );
  }
}
