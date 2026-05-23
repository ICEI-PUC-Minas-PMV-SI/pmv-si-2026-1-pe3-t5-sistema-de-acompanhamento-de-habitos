import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/design_system/tokens/sah_spacing.dart';
import '../../../../core/design_system/widgets/sah_button.dart';
import '../../../../core/design_system/widgets/sah_input.dart';
import '../../../../data/models/category.dart';
import '../../../../l10n/app_localizations.dart';

Future<Category?> showCategoryFormModal(
  BuildContext context, {
  Category? existing,
  String? userId,
}) {
  return showModalBottomSheet<Category>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _CategoryFormModal(existing: existing, userId: userId),
  );
}

const _kColors = [
  '#4A7C59',
  '#6B5B95',
  '#5B7FA8',
  '#C89B3C',
  '#B8544A',
  '#4A6FA5',
  '#7C6F4A',
  '#4A7C7C',
];

class _CategoryFormModal extends StatefulWidget {
  final Category? existing;
  final String? userId;
  const _CategoryFormModal({this.existing, this.userId});

  @override
  State<_CategoryFormModal> createState() => _CategoryFormModalState();
}

class _CategoryFormModalState extends State<_CategoryFormModal> {
  late final TextEditingController _nomeCtrl;
  late String _selectedColor;
  String? _error;

  @override
  void initState() {
    super.initState();
    _nomeCtrl = TextEditingController(text: widget.existing?.nome ?? '');
    _selectedColor = widget.existing?.cor ?? _kColors.first;
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    super.dispose();
  }

  void _confirm() {
    final nome = _nomeCtrl.text.trim();
    if (nome.isEmpty) {
      setState(() => _error = AppL10n.of(context)!.adminCategoriesFormNameRequired);
      return;
    }
    final category = Category(
      id: widget.existing?.id ?? '',
      nome: nome,
      cor: _selectedColor,
      isGlobal: widget.userId == null,
      userId: widget.userId,
    );
    Navigator.pop(context, category);
  }

  Color _parseColor(String hex) {
    try {
      final h = hex.replaceAll('#', '');
      return Color(int.parse('FF$h', radix: 16));
    } catch (_) {
      return SahColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context)!;
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final isEditing = widget.existing != null;

    return Container(
      padding: EdgeInsets.fromLTRB(
        SahSpacing.pagePadding,
        SahSpacing.x6,
        SahSpacing.pagePadding,
        SahSpacing.pagePadding + bottomPadding,
      ),
      decoration: BoxDecoration(
        color: SahColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(SahRadius.xl)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: SahColors.border,
                borderRadius: BorderRadius.circular(SahRadius.full),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            isEditing ? l.adminCategoriesFormEditTitle : l.adminCategoriesFormNewTitle,
            style: TextStyle(
              fontFamily: 'GeneralSans',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: SahColors.text,
            ),
          ),
          const SizedBox(height: 20),
          SahInput(
            label: l.adminCategoriesFormNameLabel,
            controller: _nomeCtrl,
            hint: l.adminCategoriesFormNameHint,
            errorText: _error,
            autofocus: true,
            onChanged: (_) => setState(() => _error = null),
          ),
          const SizedBox(height: 16),
          Text(l.adminCategoriesFormColorLabel, style: GoogleFonts.interTight(fontSize: 13, fontWeight: FontWeight.w500, color: SahColors.text)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _kColors.map((hex) {
              final selected = _selectedColor == hex;
              return GestureDetector(
                onTap: () => setState(() => _selectedColor = hex),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: _parseColor(hex),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selected ? SahColors.text : Colors.transparent,
                      width: 2.5,
                    ),
                    boxShadow: selected
                        ? [BoxShadow(color: _parseColor(hex).withAlpha(100), blurRadius: 6)]
                        : null,
                  ),
                  child: selected
                      ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
                      : null,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: SahButton.ghost(
                  label: l.commonCancel,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SahButton.primary(
                  label: isEditing ? l.commonSave : l.adminCategoriesFormCreate,
                  onPressed: _confirm,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
