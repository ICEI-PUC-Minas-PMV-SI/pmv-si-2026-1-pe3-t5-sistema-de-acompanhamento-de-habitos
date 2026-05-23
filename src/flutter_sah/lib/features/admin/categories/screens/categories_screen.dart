import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_palette_scope.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/design_system/tokens/sah_spacing.dart';
import '../../../../core/design_system/widgets/sah_button.dart';
import '../../../../core/design_system/widgets/sah_empty_state.dart';
import '../../../../core/design_system/widgets/sah_spinner.dart';
import '../../../../core/utils/base_list_controller.dart';
import '../../../../data/events/categories_bus.dart';
import '../../../../data/models/category.dart';
import '../../../../data/repositories/category_repository.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/categories_controller.dart';
import '../widgets/category_form_modal.dart';
import '../widgets/category_tile.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => CategoriesController(
        ctx.read<CategoryRepository>(),
        bus: ctx.read<CategoriesBus>(),
      ),
      child: const _CategoriesContent(),
    );
  }
}

class _CategoriesContent extends StatelessWidget {
  const _CategoriesContent();

  @override
  Widget build(BuildContext context) {
    SahPaletteScope.subscribe(context);
    final ctrl = context.watch<CategoriesController>();
    final l = AppL10n.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            SahSpacing.pagePadding,
            SahSpacing.pagePadding,
            SahSpacing.pagePadding,
            0,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.adminCategoriesShortTitle,
                      style: TextStyle(
                        fontFamily: 'GeneralSans',
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: SahColors.text,
                        letterSpacing: -0.44,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l.adminCategoriesSubtitle,
                      style: GoogleFonts.interTight(
                        fontSize: 13,
                        color: SahColors.textMuted,
                      ),
                    ),
                  ],
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
        ),
        const SizedBox(height: 16),
        Expanded(child: _buildBody(context, ctrl)),
      ],
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

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        SahSpacing.pagePadding,
        0,
        SahSpacing.pagePadding,
        SahSpacing.pagePadding,
      ),
      itemCount: ctrl.categories.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (ctx, i) {
        final cat = ctrl.categories[i];
        final count = ctrl.habitCounts[cat.id] ?? 0;
        return CategoryTile(
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
