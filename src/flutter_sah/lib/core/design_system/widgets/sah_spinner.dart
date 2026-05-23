import 'package:flutter/material.dart';
import '../tokens/sah_colors.dart';
import '../tokens/sah_durations.dart';

class SahSpinner extends StatefulWidget {
  final double size;
  final Color? color;

  const SahSpinner({
    super.key,
    this.size = 24,
    this.color,
  });

  @override
  State<SahSpinner> createState() => _SahSpinnerState();
}

class _SahSpinnerState extends State<SahSpinner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: SahDurations.spinner)
      ..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _ctrl,
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: widget.color ?? SahColors.primary,
          backgroundColor: (widget.color ?? SahColors.primary).withValues(alpha: 0.18),
        ),
      ),
    );
  }
}
