import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../icons/sah_icon.dart';
import '../icons/sah_icon_data.dart';
import '../tokens/sah_colors.dart';
import '../tokens/sah_durations.dart';
import '../tokens/sah_radius.dart';

class SahInput extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final String? initialValue;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixSlot;
  final String? hint;
  final String? errorText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final List<String>? autofillHints;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;

  const SahInput({
    super.key,
    required this.label,
    this.controller,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixSlot,
    this.hint,
    this.errorText,
    this.autofocus = false,
    this.onChanged,
    this.autofillHints,
    this.textInputAction,
    this.onEditingComplete,
  });

  @override
  State<SahInput> createState() => _SahInputState();
}

class _SahInputState extends State<SahInput> {
  late final FocusNode _focus;
  bool _focused = false;
  bool _obscured = true;

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscureText;
    _focus = FocusNode();
    _focus.addListener(() => setState(() => _focused = _focus.hasFocus));
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;
    final borderColor = hasError
        ? SahColors.danger
        : _focused
            ? SahColors.primary
            : SahColors.borderStrong;
    final borderWidth = (_focused || hasError) ? 1.5 : 1.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.interTight(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: SahColors.textMuted,
          ),
        ),
        const SizedBox(height: 6),
        AnimatedContainer(
          duration: SahDurations.fast,
          decoration: BoxDecoration(
            color: SahColors.surface,
            borderRadius: BorderRadius.circular(SahRadius.md),
            border: Border.all(color: borderColor, width: borderWidth),
          ),
          child: Row(
            children: [
              if (widget.prefixIcon != null) ...[
                const SizedBox(width: 14),
                IconTheme(
                  data: IconThemeData(
                      color: SahColors.textFaint, size: 16),
                  child: widget.prefixIcon!,
                ),
              ],
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focus,
                  autofocus: widget.autofocus,
                  keyboardType: widget.keyboardType,
                  obscureText: widget.obscureText ? _obscured : false,
                  autofillHints: widget.autofillHints,
                  textInputAction: widget.textInputAction,
                  onEditingComplete: widget.onEditingComplete,
                  onChanged: widget.onChanged,
                  style: GoogleFonts.interTight(
                    fontSize: 14,
                    color: SahColors.text,
                    height: 1,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    hintStyle: GoogleFonts.interTight(
                      fontSize: 14,
                      color: SahColors.textFaint,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 13),
                    isDense: true,
                  ),
                  cursorColor: SahColors.primary,
                ),
              ),
              if (widget.obscureText)
                GestureDetector(
                  onTap: () => setState(() => _obscured = !_obscured),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SahIcon(
                      _obscured ? SahIconName.eye : SahIconName.eyeOff,
                      size: 16,
                      color: SahColors.textFaint,
                    ),
                  ),
                )
              else if (widget.suffixSlot != null) ...[
                widget.suffixSlot!,
                const SizedBox(width: 12),
              ],
            ],
          ),
        ),
        if (widget.errorText != null) ...[
          const SizedBox(height: 6),
          Row(
            children: [
              SahIcon(SahIconName.alert,
                  size: 12, color: SahColors.danger),
              const SizedBox(width: 4),
              Text(
                widget.errorText!,
                style: GoogleFonts.interTight(
                    fontSize: 12, color: SahColors.danger),
              ),
            ],
          ),
        ] else if (widget.hint != null && !_focused) ...[
          const SizedBox(height: 6),
          Text(
            widget.hint!,
            style: GoogleFonts.interTight(
                fontSize: 12, color: SahColors.textFaint),
          ),
        ],
      ],
    );
  }
}
