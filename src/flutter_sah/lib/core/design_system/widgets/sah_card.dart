import 'package:flutter/material.dart';
import '../tokens/sah_colors.dart';
import '../tokens/sah_radius.dart';
import '../tokens/sah_shadows.dart';
import '../tokens/sah_durations.dart';

enum SahCardElevation { sm, md }

class SahCard extends StatefulWidget {
  final Widget child;
  final double padding;
  final bool hoverable;
  final VoidCallback? onTap;
  final SahCardElevation elevation;
  final Color? color;

  const SahCard({
    super.key,
    required this.child,
    this.padding = 20,
    this.hoverable = false,
    this.onTap,
    this.elevation = SahCardElevation.sm,
    this.color,
  });

  @override
  State<SahCard> createState() => _SahCardState();
}

class _SahCardState extends State<SahCard> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final elevated = _hovered && widget.hoverable;
    final shadows = elevated ? SahShadows.md : SahShadows.sm;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedContainer(
          duration: SahDurations.normal,
          curve: Curves.easeOutCubic,
          transform: elevated && !_pressed
              ? Matrix4.translationValues(0, -1, 0)
              : Matrix4.identity(),
          decoration: BoxDecoration(
            color: widget.color ?? SahColors.surface,
            borderRadius: BorderRadius.circular(SahRadius.lg),
            boxShadow: shadows,
          ),
          padding: EdgeInsets.all(widget.padding),
          child: widget.child,
        ),
      ),
    );
  }
}
