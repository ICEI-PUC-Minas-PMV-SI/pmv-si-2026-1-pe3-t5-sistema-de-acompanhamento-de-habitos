import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/design_system/tokens/sah_spacing.dart';
import '../../../../core/design_system/widgets/sah_button.dart';
import '../../../../core/design_system/widgets/sah_input.dart';
import '../../../../core/design_system/widgets/sah_modal.dart';
import '../../../../data/models/category.dart';
import '../../../../data/models/habit.dart';

Future<Habit?> showHabitFormModal(
  BuildContext context, {
  Habit? existing,
  required List<Category> categories,
}) {
  return showModalBottomSheet<Habit>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _HabitFormModal(
      existing: existing,
      categories: categories,
    ),
  );
}

const _kDayLabels = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];

class _HabitFormModal extends StatefulWidget {
  final Habit? existing;
  final List<Category> categories;

  const _HabitFormModal({this.existing, required this.categories});

  @override
  State<_HabitFormModal> createState() => _HabitFormModalState();
}

class _HabitFormModalState extends State<_HabitFormModal> {
  late final TextEditingController _nomeCtrl;
  late final TextEditingController _descCtrl;
  late List<int> _frequencia;
  late String? _categoriaId;
  late List<String> _lembretes;
  String? _nomeError;

  @override
  void initState() {
    super.initState();
    _nomeCtrl = TextEditingController(text: widget.existing?.nome ?? '');
    _descCtrl = TextEditingController(text: widget.existing?.descricao ?? '');
    _frequencia = List<int>.from(
      widget.existing?.frequencia ?? [1, 2, 3, 4, 5],
    );
    _categoriaId = widget.existing?.categoriaId ??
        (widget.categories.isNotEmpty ? widget.categories.first.id : null);
    _lembretes = List<String>.from(widget.existing?.lembretes ?? []);
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _addReminder() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (ctx, child) => MediaQuery(
        data: MediaQuery.of(ctx).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (picked == null) return;
    final formatted =
        '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
    if (_lembretes.contains(formatted)) return;
    setState(() {
      _lembretes.add(formatted);
      _lembretes.sort();
    });
  }

  void _showCategoryInfoDialog(BuildContext context) {
    showSahModal<void>(
      context: context,
      title: 'Como funcionam as categorias',
      content: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _InfoBlock(
            icon: PhosphorIconsRegular.globe,
            title: 'Globais',
            description:
                'Criadas pelo administrador e disponíveis para todos. Não podem ser editadas.',
          ),
          SizedBox(height: 12),
          _InfoBlock(
            icon: PhosphorIconsRegular.userCircle,
            title: 'Minhas',
            description:
                'Criadas por você, visíveis só para você. Gerencie em Configurações → Gerenciar categorias.',
          ),
        ],
      ),
      actions: [
        SahButton.primary(
          label: 'Entendi',
          size: SahButtonSize.sm,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  void _confirm() {
    final nome = _nomeCtrl.text.trim();
    if (nome.isEmpty) {
      setState(() => _nomeError = 'Informe o nome do hábito');
      return;
    }
    if (_frequencia.isEmpty) {
      setState(() => _nomeError = 'Selecione ao menos um dia da semana');
      return;
    }
    final habit = Habit(
      id: widget.existing?.id ?? '',
      userId: widget.existing?.userId ?? '',
      nome: nome,
      descricao: _descCtrl.text.trim(),
      frequencia: List<int>.from(_frequencia)..sort(),
      categoriaId: _categoriaId,
      lembretes: List<String>.from(_lembretes),
    );
    Navigator.pop(context, habit);
  }

  Color _parseColor(String hex) {
    try {
      return Color(int.parse('FF${hex.replaceAll('#', '')}', radix: 16));
    } catch (_) {
      return SahColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
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
              isEditing ? 'Editar hábito' : 'Novo hábito',
              style: TextStyle(
                fontFamily: 'GeneralSans',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: SahColors.text,
              ),
            ),
            const SizedBox(height: 20),
            SahInput(
              label: 'Nome',
              controller: _nomeCtrl,
              hint: 'Ex: Meditar, Ler, Correr…',
              errorText: _nomeError,
              autofocus: true,
              onChanged: (_) => setState(() => _nomeError = null),
            ),
            const SizedBox(height: 12),
            SahInput(
              label: 'Descrição (opcional)',
              controller: _descCtrl,
              hint: 'Detalhes ou motivação',
            ),
            const SizedBox(height: 16),
            // Categoria
            if (widget.categories.isNotEmpty) ...[
              Row(
                children: [
                  Text(
                    'Categoria',
                    style: GoogleFonts.interTight(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: SahColors.text,
                    ),
                  ),
                  const SizedBox(width: 6),
                  InkWell(
                    onTap: () => _showCategoryInfoDialog(context),
                    borderRadius: BorderRadius.circular(SahRadius.full),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Icon(
                        PhosphorIconsRegular.info,
                        size: 15,
                        color: SahColors.textFaint,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (_, i) {
                    final cat = widget.categories[i];
                    final selected = _categoriaId == cat.id;
                    final catColor = _parseColor(cat.cor);
                    return GestureDetector(
                      onTap: () => setState(() => _categoriaId = cat.id),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? catColor.withAlpha(30)
                              : SahColors.bgAlt,
                          borderRadius:
                              BorderRadius.circular(SahRadius.full),
                          border: Border.all(
                            color: selected ? catColor : SahColors.border,
                            width: selected ? 1.5 : 1,
                          ),
                        ),
                        child: Text(
                          cat.nome,
                          style: GoogleFonts.interTight(
                            fontSize: 13,
                            fontWeight: selected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: selected ? catColor : SahColors.textMuted,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
            // Frequência
            Text(
              'Frequência',
              style: GoogleFonts.interTight(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: SahColors.text,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (day) {
                final selected = _frequencia.contains(day);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selected) {
                        _frequencia.remove(day);
                      } else {
                        _frequencia.add(day);
                      }
                      _nomeError = null;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: selected ? SahColors.accent : SahColors.bgAlt,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            selected ? SahColors.accent : SahColors.border,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _kDayLabels[day],
                        style: GoogleFonts.interTight(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: selected
                              ? SahColors.surface
                              : SahColors.textMuted,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            // Lembretes
            Text(
              'Lembretes',
              style: GoogleFonts.interTight(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: SahColors.text,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ..._lembretes.map((t) => _ReminderChip(
                      time: t,
                      onRemove: () => setState(() => _lembretes.remove(t)),
                    )),
                GestureDetector(
                  onTap: _addReminder,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: SahColors.bgAlt,
                      borderRadius: BorderRadius.circular(SahRadius.full),
                      border: Border.all(color: SahColors.border),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, size: 14, color: SahColors.textMuted),
                        const SizedBox(width: 4),
                        Text(
                          'Adicionar',
                          style: GoogleFonts.interTight(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: SahColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: SahButton.ghost(
                    label: 'Cancelar',
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SahButton.primary(
                    label: isEditing ? 'Salvar' : 'Criar',
                    onPressed: _confirm,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ReminderChip extends StatelessWidget {
  final String time;
  final VoidCallback onRemove;

  const _ReminderChip({required this.time, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: SahColors.accentFaint,
        borderRadius: BorderRadius.circular(SahRadius.full),
        border: Border.all(color: SahColors.accentSoft),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.alarm_outlined, size: 13, color: SahColors.accent),
          const SizedBox(width: 4),
          Text(
            time,
            style: GoogleFonts.interTight(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: SahColors.accent,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child: Icon(Icons.close, size: 12, color: SahColors.accent),
          ),
        ],
      ),
    );
  }
}

class _InfoBlock extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _InfoBlock({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: SahColors.bgAlt,
            borderRadius: BorderRadius.circular(SahRadius.sm),
          ),
          child: Icon(icon, size: 16, color: SahColors.textMuted),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.interTight(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: SahColors.text,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: GoogleFonts.interTight(
                  fontSize: 12,
                  color: SahColors.textMuted,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
