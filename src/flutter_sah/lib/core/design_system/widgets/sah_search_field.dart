import 'package:flutter/material.dart';
import '../icons/sah_icon.dart';
import '../icons/sah_icon_data.dart';
import 'sah_input.dart';

class SahSearchField extends StatefulWidget {
  final String label;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const SahSearchField({
    super.key,
    this.label = 'Buscar',
    this.hint = 'Pesquisar…',
    this.onChanged,
    this.controller,
  });

  @override
  State<SahSearchField> createState() => _SahSearchFieldState();
}

class _SahSearchFieldState extends State<SahSearchField> {
  DateTime? _lastChange;

  void _handleChange(String value) {
    _lastChange = DateTime.now();
    Future.delayed(const Duration(milliseconds: 250), () {
      if (DateTime.now().difference(_lastChange!) >=
          const Duration(milliseconds: 250)) {
        widget.onChanged?.call(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SahInput(
      label: widget.label,
      controller: widget.controller,
      hint: widget.hint,
      keyboardType: TextInputType.text,
      prefixIcon: const SahIcon(SahIconName.search, size: 16),
      onChanged: _handleChange,
    );
  }
}
