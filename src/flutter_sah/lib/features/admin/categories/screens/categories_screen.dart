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
import '../../../../l10n/app_localizations.dart';
import '../controllers/categories_controller.dart';
import '../widgets/category_card.dart';
import '../widgets/category_form_modal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => CategoriesController(ctx.read<CategoryRepository>()),
      child: const _CategoriesContent(),
    );
  }
}

class _CategoriesContent extends StatelessWidget {
  const _CategoriesContent();

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<CategoriesController>();
    final l = AppL10n.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(SahSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l.adminCategoriesShortTitle,
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
                label: l.adminCategoriesNewButton,
                icon: const Icon(Icons.add_rounded, size: 16, color: Colors.white),
                size: SahButtonSize.sm,
                onPressed: () => _showCreate(context, ctrl),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(child: _buildBody(context, ctrl)),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, CategoriesController ctrl) {
    final l = AppL10n.of(context)!;
    if (ctrl.status == ListStatus.loading) {
      return const Center(child: SahSpinner(size: 28));
    }
    if (ctrl.status == ListStatus.error) {
      return Center(
        child: Text(
          ctrl.error ?? l.adminCategoriesLoadError,
          style: GoogleFonts.interTight(fontSize: 14, color: SahColors.textMuted),
        ),
      );
    }
    if (ctrl.categories.isEmpty) {
      return SahEmptyState(
        title: l.adminCategoriesEmptyTitle,
        description: l.adminCategoriesEmptyDescription,
        primaryAction: SahButton.primary(
          label: l.adminCategoriesCreateButton,
          onPressed: () => _showCreate(context, ctrl),
        ),
      );
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
    final l = AppL10n.of(context)!;
    if (count > 0) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: SahColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SahRadius.lg),
          ),
          title: Text(
            l.adminCategoriesInUseTitle,
            style: TextStyle(fontFamily: 'GeneralSans', fontSize: 18, color: SahColors.text),
          ),
          content: Text(
            l.adminCategoriesInUseBody(count),
            style: GoogleFonts.interTight(fontSize: 14, color: SahColors.textMuted, height: 1.5),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l.commonCancel, style: GoogleFonts.interTight(color: SahColors.textMuted)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(l.adminCategoriesForceDelete, style: GoogleFonts.interTight(color: SahColors.danger)),
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
          l.adminCategoriesDeleteTitle,
          style: TextStyle(fontFamily: 'GeneralSans', fontSize: 18, color: SahColors.text),
        ),
        content: Text(
          l.adminCategoriesDeleteBody,
          style: GoogleFonts.interTight(fontSize: 14, color: SahColors.textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l.commonCancel, style: GoogleFonts.interTight(color: SahColors.textMuted)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l.commonDelete, style: GoogleFonts.interTight(color: SahColors.danger)),
          ),
        ],
      ),
    );
    if (confirm == true && context.mounted) {
      await ctrl.delete(id);
    }
  }
}
