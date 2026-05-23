import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/design_system/tokens/sah_spacing.dart';
import '../../../../core/design_system/widgets/sah_button.dart';
import '../../../../core/design_system/widgets/sah_empty_state.dart';
import '../../../../core/design_system/widgets/sah_spinner.dart';
import '../../../../core/utils/base_list_controller.dart';
import '../../../../data/models/category.dart';
import '../../../../data/repositories/category_repository.dart';
import '../controllers/categories_controller.dart';
import '../widgets/category_card.dart';
import '../widgets/category_form_modal.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => CategoriesController(ctx.read<CategoryRepository>()),
      child: _CategoriesContent(),
    );
  }
}

class _CategoriesContent extends StatelessWidget {
  _CategoriesContent();

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<CategoriesController>();

    return Padding(
      padding: EdgeInsets.all(SahSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Categorias',
                  style: TextStyle(
                    fontFamily: 'GeneralSans',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: SahColors.text,
                    letterSpacing: -0.44,
                  ),
                ),
              ),
              SahButton.primary(
                label: 'Nova',
                icon: Icon(Icons.add_rounded, size: 16, color: Colors.white),
                size: SahButtonSize.sm,
                onPressed: () => _showCreate(context, ctrl),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(child: _buildBody(context, ctrl)),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, CategoriesController ctrl) {
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
    if (ctrl.categories.isEmpty) {
      return SahEmptyState(
        title: 'Nenhuma categoria',
        description: 'Crie a primeira categoria global para os usuários.',
        primaryAction: SahButton.primary(
          label: 'Criar categoria',
          onPressed: () => _showCreate(context, ctrl),
        ),
      );
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemCount: ctrl.categories.length,
      itemBuilder: (ctx, i) {
        final cat = ctrl.categories[i];
        final count = ctrl.habitCounts[cat.id] ?? 0;
        return CategoryCard(
          category: cat,
          habitCount: count,
          onEdit: () => _showEdit(context, ctrl, cat),
          onDelete: () => _confirmDelete(context, ctrl, cat.id, count),
        );
      },
    );
  }

  Future<void> _showCreate(BuildContext context, CategoriesController ctrl) async {
    final category = await showCategoryFormModal(context);
    if (category != null) await ctrl.create(category);
  }

  Future<void> _showEdit(BuildContext context, CategoriesController ctrl, Category cat) async {
    final updated = await showCategoryFormModal(context, existing: cat);
    if (updated != null) await ctrl.update(updated.copyWith(id: cat.id));
  }

  Future<void> _confirmDelete(
    BuildContext context,
    CategoriesController ctrl,
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
            style: TextStyle(fontFamily: 'GeneralSans', fontSize: 18, color: SahColors.text),
          ),
          content: Text(
            'Esta categoria está vinculada a $count hábito${count != 1 ? "s" : ""}. Deseja excluir mesmo assim?',
            style: GoogleFonts.interTight(fontSize: 14, color: SahColors.textMuted, height: 1.5),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancelar', style: GoogleFonts.interTight(color: SahColors.textMuted)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Excluir assim mesmo', style: GoogleFonts.interTight(color: SahColors.danger)),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SahRadius.lg)),
        title: Text(
          'Excluir categoria?',
          style: TextStyle(fontFamily: 'GeneralSans', fontSize: 18, color: SahColors.text),
        ),
        content: Text(
          'Esta ação não pode ser desfeita.',
          style: GoogleFonts.interTight(fontSize: 14, color: SahColors.textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancelar', style: GoogleFonts.interTight(color: SahColors.textMuted)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Excluir', style: GoogleFonts.interTight(color: SahColors.danger)),
          ),
        ],
      ),
    );
    if (confirm == true && context.mounted) {
      await ctrl.delete(id);
    }
  }
}
