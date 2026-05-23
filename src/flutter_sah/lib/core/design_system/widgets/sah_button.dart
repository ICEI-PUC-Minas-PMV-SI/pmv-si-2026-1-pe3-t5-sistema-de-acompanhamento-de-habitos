import 'package:flutter/material.dart';
import '../tokens/sah_colors.dart';
import '../tokens/sah_radius.dart';
import '../tokens/sah_durations.dart';

enum SahButtonVariant { primary, accent, secondary, ghost, danger, dangerGhost }

enum SahButtonSize { sm, lg, md }

class SahButton extends StatefulWidget {
  final String? label;
  final Widget? icon;
  final Widget? iconRight;
  final VoidCallback? onPressed;
  final SahButtonVariant variant;
  final SahButtonSize size;
  final bool fullWidth;
  final bool loading;
  final bool disabled;
  final String? semanticLabel;

  const SahButton({
    super.key,
    this.label,
    this.icon,
    this.iconRight,
    this.onPressed,
    this.variant = SahButtonVariant.primary,
    this.size = SahButtonSize.md,
    this.fullWidth = false,
    this.loading = false,
    this.disabled = false,
    this.semanticLabel,
  });

  const SahButton.primary({
    super.key,
    this.label,
    this.icon,
    this.iconRight,
    this.onPressed,
    this.size = SahButtonSize.md,
    this.fullWidth = false,
    this.loading = false,
    this.disabled = false,
    this.semanticLabel,
  }) : variant = SahButtonVariant.primary;

  const SahButton.accent({
    super.key,
    this.label,
    this.icon,
    this.iconRight,
    this.onPressed,
    this.size = SahButtonSize.md,
    this.fullWidth = false,
    this.loading = false,
    this.disabled = false,
    this.semanticLabel,
  }) : variant = SahButtonVariant.accent;

  const SahButton.secondary({
    super.key,
    this.label,
    this.icon,
    this.iconRight,
    this.onPressed,
    this.size = SahButtonSize.md,
    this.fullWidth = false,
    this.loading = false,
    this.disabled = false,
    this.semanticLabel,
  }) : variant = SahButtonVariant.secondary;

  const SahButton.ghost({
    super.key,
    this.label,
    this.icon,
    this.iconRight,
    this.onPressed,
    this.size = SahButtonSize.md,
    this.fullWidth = false,
    this.loading = false,
    this.disabled = false,
    this.semanticLabel,
  }) : variant = SahButtonVariant.ghost;

  const SahButton.danger({
    super.key,
    this.label,
    this.icon,
    this.iconRight,
    this.onPressed,
    this.size = SahButtonSize.md,
    this.fullWidth = false,
    this.loading = false,
    this.disabled = false,
    this.semanticLabel,
  }) : variant = SahButtonVariant.danger;

  const SahButton.dangerGhost({
    super.key,
    this.label,
    this.icon,
    this.iconRight,
    this.onPressed,
    this.size = SahButtonSize.md,
    this.fullWidth = false,
    this.loading = false,
    this.disabled = false,
    this.semanticLabel,
  }) : variant = SahButtonVariant.dangerGhost;

  @override
  State<SahButton> createState() => _SahButtonState();
}

class _SahButtonState extends State<SahButton> {
  bool _hovered = false;

  double get _minHeight => switch (widget.size) {
        SahButtonSize.sm => 30,
        SahButtonSize.md => 40,
        SahButtonSize.lg => 48,
      };

  EdgeInsetsGeometry get _padding => switch (widget.size) {
        SahButtonSize.sm =>
          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        SahButtonSize.md =>
          const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        SahButtonSize.lg =>
          const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      };

  double get _fontSize => switch (widget.size) {
        SahButtonSize.sm => 13,
        SahButtonSize.md => 14,
        SahButtonSize.lg => 15,
      };

  (Color bg, Color fg, Color? border) get _colors {
    final h = _hovered;
    return switch (widget.variant) {
      SahButtonVariant.primary => (
          h ? SahColors.primaryHover : SahColors.primary,
          Colors.white,
          null
        ),
      SahButtonVariant.accent => (
          h ? SahColors.accentHover : SahColors.accent,
          Colors.white,
          null
        ),
      SahButtonVariant.secondary => (
          h ? SahColors.bgAlt : SahColors.surface,
          SahColors.text,
          SahColors.borderStrong
        ),
      SahButtonVariant.ghost => (
          h ? SahColors.bgAlt : Colors.transparent,
          h ? SahColors.text : SahColors.textMuted,
          null
        ),
      SahButtonVariant.danger => (
          h ? Color(0xFFA04840) : SahColors.danger,
          Colors.white,
          null
        ),
      SahButtonVariant.dangerGhost => (
          h ? SahColors.dangerSoft : Colors.transparent,
          SahColors.danger,
          SahColors.dangerSoft
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.disabled || widget.loading;
    final (bg, fg, border) = _colors;
    final a11yLabel = widget.semanticLabel ?? widget.label ?? '';

    return Semantics(
      button: true,
      enabled: !isDisabled,
      label: a11yLabel,
      excludeSemantics: true,
      onTap: isDisabled ? null : widget.onPressed,
      child: MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedOpacity(
        duration: SahDurations.fast,
        opacity: isDisabled ? 0.55 : 1.0,
        child: GestureDetector(
          onTap: isDisabled ? null : widget.onPressed,
          child: AnimatedContainer(
            duration: SahDurations.fast,
            constraints: BoxConstraints(minHeight: _minHeight),
            width: widget.fullWidth ? double.infinity : null,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(SahRadius.md),
              border: border != null ? Border.all(color: border) : null,
            ),
            padding: _padding,
            child: Row(
              mainAxisSize:
                  widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.loading)
                  _ButtonSpinner(color: fg, size: _fontSize)
                else if (widget.icon != null) ...[
                  IconTheme(data: IconThemeData(color: fg, size: _fontSize + 2), child: widget.icon!),
                ],
                if ((widget.loading || widget.icon != null) &&
                    widget.label != null)
                  const SizedBox(width: 8),
                if (widget.label != null)
                  Text(
                    widget.label!,
                    style: TextStyle(
                      fontFamily: 'GeneralSans',
                      fontSize: _fontSize,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.005 * _fontSize,
                      color: fg,
                      height: 1,
                    ),
                  ),
                if (widget.iconRight != null) ...[
                  const SizedBox(width: 8),
                  IconTheme(data: IconThemeData(color: fg, size: _fontSize + 2), child: widget.iconRight!),
                ],
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}

class _ButtonSpinner extends StatefulWidget {
  final Color color;
  final double size;
  const _ButtonSpinner({required this.color, required this.size});
  @override
  State<_ButtonSpinner> createState() => _ButtonSpinnerState();
}

class _ButtonSpinnerState extends State<_ButtonSpinner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: SahDurations.spinner)
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
          color: widget.color,
        ),
      ),
    );
  }
}
