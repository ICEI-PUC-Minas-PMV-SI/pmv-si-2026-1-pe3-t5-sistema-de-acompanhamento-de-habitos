import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/design_system/widgets/sah_action_sheet.dart';
import '../../../../core/design_system/tokens/sah_shadows.dart';
import '../../../../core/design_system/tokens/sah_spacing.dart';
import '../../../../core/design_system/widgets/sah_badge.dart';
import '../../../../core/design_system/widgets/sah_button.dart';
import '../../../../core/design_system/widgets/sah_empty_state.dart';
import '../../../../core/design_system/widgets/sah_spinner.dart';
import '../../../../core/utils/base_list_controller.dart';
import '../../../../data/models/category.dart';
import '../../../../data/repositories/category_repository.dart';
import '../../../admin/categories/widgets/category_form_modal.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../controllers/user_categories_controller.dart';

class UserCategoriesScreen extends StatelessWidget {
  UserCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = context.read<AuthController>().currentUser!.id;
    return ChangeNotifierProvider(
      create: (ctx) => UserCategoriesController(
        ctx.read<CategoryRepository>(),
        userId: userId,
      ),
      child: _UserCategoriesContent(),
    );
  }
}

class _UserCategoriesContent extends StatelessWidget {
  _UserCategoriesContent();

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<UserCategoriesController>();
    final userId = context.read<AuthController>().currentUser!.id;

    return Scaffold(
      backgroundColor: SahColors.bg,
      appBar: AppBar(
        backgroundColor: SahColors.bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: SahColors.text),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Minhas categorias',
          style: TextStyle(
            fontFamily: 'GeneralSans',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: SahColors.text,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: SahSpacing.pagePadding),
            child: SahButton.primary(
              label: 'Nova',
              icon: Icon(Icons.add_rounded, size: 16, color: Colors.white),
              size: SahButtonSize.sm,
              onPressed: () => _showCreate(context, ctrl, userId),
            ),
          ),
        ],
      ),
      body: _buildBody(context, ctrl, userId),
    );
  }

  Widget _buildBody(
    BuildContext context,
    UserCategoriesController ctrl,
    String userId,
  ) {
    if (ctrl.status == ListStatus.loading) {
      return Center(child: SahSpinner(size: 28));
    }
    if (ctrl.status == ListStatus.error) {
      return Center(
        child: Text(
          ctrl.error ?? 'Erro ao carregar categorias',
          style: GoogleFonts.interTight(fontSize: 14, color: SahColors.textMuted),
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(SahSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(title: 'Suas categorias'),
          SizedBox(height: 10),
          if (ctrl.personal.isEmpty)
            SahEmptyState(
              title: 'Nenhuma categoria pessoal',
              description: 'Crie categorias próprias para organizar seus hábitos.',
              primaryAction: SahButton.primary(
                label: 'Criar primeira',
                onPressed: () => _showCreate(context, ctrl, userId),
              ),
            )
          else
            _CategoryList(
              categories: ctrl.personal,
              habitCounts: ctrl.habitCounts,
              readOnly: false,
              onEdit: (cat) => _showEdit(context, ctrl, cat, userId),
              onDelete: (cat) => _confirmDelete(
                context,
                ctrl,
                cat.id,
                ctrl.habitCounts[cat.id] ?? 0,
              ),
            ),
          SizedBox(height: 24),
          _SectionHeader(title: 'Globais'),
          SizedBox(height: 4),
          Text(
            'Disponíveis para todos — somente leitura.',
            style: GoogleFonts.interTight(fontSize: 12, color: SahColors.textMuted),
          ),
          SizedBox(height: 10),
          _CategoryList(
            categories: ctrl.globals,
            habitCounts: ctrl.habitCounts,
            readOnly: true,
            onEdit: (_) {},
            onDelete: (_) {},
          ),
        ],
      ),
    );
  }

  Future<void> _showCreate(
    BuildContext context,
    UserCategoriesController ctrl,
    String userId,
  ) async {
    final category = await showCategoryFormModal(context, userId: userId);
    if (category != null && context.mounted) {
      await ctrl.create(category);
    }
  }

  Future<void> _showEdit(
    BuildContext context,
    UserCategoriesController ctrl,
    Category cat,
    String userId,
  ) async {
    final updated = await showCategoryFormModal(
      context,
      existing: cat,
      userId: userId,
    );
    if (updated != null && context.mounted) {
      await ctrl.update(updated.copyWith(id: cat.id));
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    UserCategoriesController ctrl,
    String id,
    int count,
  ) async {
    if (count > 0) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: SahColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SahRadius.lg),
          ),
          title: Text(
            'Categoria em uso',
            style: TextStyle(
              fontFamily: 'GeneralSans',
              fontSize: 18,
              color: SahColors.text,
            ),
          ),
          content: Text(
            'Esta categoria está vinculada a $count hábito${count != 1 ? "s" : ""}. Deseja excluir mesmo assim?',
            style: GoogleFonts.interTight(
                fontSize: 14, color: SahColors.textMuted, height: 1.5),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancelar',
                  style: GoogleFonts.interTight(color: SahColors.textMuted)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Excluir assim mesmo',
                  style: GoogleFonts.interTight(color: SahColors.danger)),
            ),
          ],
        ),
      );
      if (confirm == true && context.mounted) {
        await ctrl.forceDelete(id);
      }
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: SahColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SahRadius.lg),
        ),
        title: Text(
          'Excluir categoria?',
          style: TextStyle(
            fontFamily: 'GeneralSans',
            fontSize: 18,
            color: SahColors.text,
          ),
        ),
        content: Text(
          'Esta ação não pode ser desfeita.',
          style: GoogleFonts.interTight(fontSize: 14, color: SahColors.textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancelar',
                style: GoogleFonts.interTight(color: SahColors.textMuted)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Excluir',
                style: GoogleFonts.interTight(color: SahColors.danger)),
          ),
        ],
      ),
    );
    if (confirm == true && context.mounted) {
      await ctrl.delete(id);
    }
  }
}

// ─── Widgets de layout ───────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'GeneralSans',
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: SahColors.text,
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  final List<Category> categories;
  final Map<String, int> habitCounts;
  final bool readOnly;
  final void Function(Category) onEdit;
  final void Function(Category) onDelete;

  _CategoryList({
    required this.categories,
    required this.habitCounts,
    required this.readOnly,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < categories.length; i++) ...[
          _CategoryTile(
            category: categories[i],
            habitCount: habitCounts[categories[i].id] ?? 0,
            readOnly: readOnly,
            onEdit: () => onEdit(categories[i]),
            onDelete: () => onDelete(categories[i]),
          ),
          if (i < categories.length - 1) SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final Category category;
  final int habitCount;
  final bool readOnly;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  _CategoryTile({
    required this.category,
    required this.habitCount,
    required this.readOnly,
    required this.onEdit,
    required this.onDelete,
  });

  Color get _color {
    try {
      return Color(
        int.parse('FF${category.cor.replaceAll('#', '')}', radix: 16),
      );
    } catch (_) {
      return SahColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _color;

    return Material(
      color: SahColors.surface,
      borderRadius: BorderRadius.circular(SahRadius.md),
      child: InkWell(
        onTap: readOnly ? null : onEdit,
        borderRadius: BorderRadius.circular(SahRadius.md),
        splashColor: color.withAlpha(20),
        highlightColor: color.withAlpha(10),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SahRadius.md),
            border: Border.all(color: SahColors.border),
            boxShadow: SahShadows.sm,
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(width: 4, color: color),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: color.withAlpha(25),
                            borderRadius: BorderRadius.circular(SahRadius.sm),
                          ),
                          child: Center(
                            child: Text(
                              category.nome
                                  .substring(0, 1)
                                  .toUpperCase(),
                              style: GoogleFonts.interTight(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: color,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                category.nome,
                                style: TextStyle(
                                  fontFamily: 'GeneralSans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: SahColors.text,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '$habitCount hábito${habitCount != 1 ? "s" : ""}',
                                style: GoogleFonts.interTight(
                                  fontSize: 11,
                                  color: SahColors.textFaint,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (readOnly)
                          SahBadge.neutral(
                            'Global',
                            size: SahBadgeSize.sm,
                          )
                        else
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon: Icon(
                              Icons.more_vert_rounded,
                              size: 18,
                              color: SahColors.textMuted,
                            ),
                            onPressed: () => showSahActionSheet(
                              context,
                              title: category.nome,
                              actions: [
                                SahActionItem(
                                  icon: Icons.edit_outlined,
                                  label: 'Editar',
                                  onTap: () {
                                    Navigator.pop(context);
                                    onEdit();
                                  },
                                ),
                                SahActionItem(
                                  icon: Icons.delete_outline,
                                  label: 'Excluir',
                                  destructive: true,
                                  onTap: () {
                                    Navigator.pop(context);
                                    onDelete();
                                  },
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
