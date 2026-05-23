import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/design_system/tokens/sah_colors.dart';
import '../../../core/design_system/tokens/sah_palette_scope.dart';
import '../../../core/design_system/tokens/sah_radius.dart';
import '../../../core/design_system/tokens/sah_spacing.dart';
import '../../../core/design_system/widgets/sah_button.dart';
import '../../../core/routing/routes.dart';
import '../../../core/utils/result.dart';
import '../../../data/local/onboarding_store.dart';
import '../../../data/models/category.dart';
import '../../../data/models/habit.dart';
import '../../../data/repositories/category_repository.dart';
import '../../../data/repositories/habit_repository.dart';
import '../../auth/controllers/auth_controller.dart';
import '../data/onboarding_suggestions.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final Set<int> _selected = {};
  List<Category> _categories = [];
  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final repo = context.read<CategoryRepository>();
    final result = await repo.listGlobal();
    if (!mounted) return;
    setState(() {
      _categories = result.fold(
        onSuccess: (List<Category> l) => l,
        onFailure: (_) => <Category>[],
      );
      _loading = false;
    });
  }

  Color _parseColor(String hex) {
    try {
      return Color(int.parse('FF${hex.replaceAll('#', '')}', radix: 16));
    } catch (_) {
      return SahColors.primary;
    }
  }

  Future<void> _finishAndGoToToday() async {
    final userId = context.read<AuthController>().currentUser!.id;
    await context.read<OnboardingStore>().markCompleted(userId);
    if (!mounted) return;
    context.go(Routes.userToday);
  }

  Future<void> _skip() async {
    await _finishAndGoToToday();
  }

  Future<void> _createSelected() async {
    if (_selected.isEmpty) return;
    setState(() => _saving = true);

    final repo = context.read<HabitRepository>();
    final userId = context.read<AuthController>().currentUser!.id;
    var failures = 0;

    for (final i in _selected) {
      final s = onboardingSuggestions[i];
      final habit = Habit(
        id: '',
        userId: userId,
        nome: s.nome,
        categoriaId: s.categoriaId,
      );
      final res = await repo.create(habit);
      if (res.isFailure) failures++;
    }

    if (!mounted) return;
    if (failures > 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '$failures hábito(s) falharam ao criar.',
          style: GoogleFonts.interTight(fontSize: 14),
        ),
        backgroundColor: SahColors.danger,
      ));
    }
    await _finishAndGoToToday();
  }

  @override
  Widget build(BuildContext context) {
    SahPaletteScope.subscribe(context);
    if (_loading) {
      return Scaffold(
        backgroundColor: SahColors.bg,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final nome = context.read<AuthController>().currentUser?.nome.split(' ').first ?? '';

    return Scaffold(
      backgroundColor: SahColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  SahSpacing.pagePadding,
                  SahSpacing.x6,
                  SahSpacing.pagePadding,
                  SahSpacing.x4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nome.isEmpty ? 'Bem-vindo!' : 'Bem-vindo, $nome!',
                      style: TextStyle(
                        fontFamily: 'GeneralSans',
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: SahColors.text,
                        letterSpacing: -0.52,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Escolha os hábitos que combinam com você. Você pode ajustar tudo depois.',
                      style: GoogleFonts.interTight(
                        fontSize: 14,
                        color: SahColors.textMuted,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 24),
                    ..._categories.map(_buildCategorySection),
                  ],
                ),
              ),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(Category cat) {
    final color = _parseColor(cat.cor);
    final suggestions = onboardingSuggestions
        .asMap()
        .entries
        .where((e) => e.value.categoriaId == cat.id)
        .toList();
    if (suggestions.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(bottom: SahSpacing.x6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              borderRadius: BorderRadius.circular(SahRadius.full),
            ),
            child: Text(
              cat.nome,
              style: GoogleFonts.interTight(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: suggestions.map((e) {
              final i = e.key;
              final s = e.value;
              final selected = _selected.contains(i);
              return GestureDetector(
                onTap: () => setState(() {
                  if (selected) {
                    _selected.remove(i);
                  } else {
                    _selected.add(i);
                  }
                }),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 150),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: selected ? color.withAlpha(30) : SahColors.surface,
                    borderRadius: BorderRadius.circular(SahRadius.full),
                    border: Border.all(
                      color: selected ? color : SahColors.border,
                      width: selected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        selected ? Icons.check_circle : Icons.add_circle_outline,
                        size: 14,
                        color: selected ? color : SahColors.textMuted,
                      ),
                      SizedBox(width: 6),
                      Text(
                        s.nome,
                        style: GoogleFonts.interTight(
                          fontSize: 13,
                          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                          color: selected ? color : SahColors.text,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    final count = _selected.length;
    return Container(
      padding: EdgeInsets.fromLTRB(
        SahSpacing.pagePadding,
        12,
        SahSpacing.pagePadding,
        16,
      ),
      decoration: BoxDecoration(
        color: SahColors.surface,
        border: Border(top: BorderSide(color: SahColors.border)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SahButton.primary(
            label: count == 0
                ? 'Selecione ao menos um hábito'
                : 'Começar com $count hábito${count == 1 ? '' : 's'}',
            fullWidth: true,
            disabled: count == 0,
            loading: _saving,
            onPressed: _createSelected,
          ),
          SizedBox(height: 6),
          SahButton.ghost(
            label: 'Pular',
            fullWidth: true,
            onPressed: _saving ? null : _skip,
          ),
        ],
      ),
    );
  }
}
