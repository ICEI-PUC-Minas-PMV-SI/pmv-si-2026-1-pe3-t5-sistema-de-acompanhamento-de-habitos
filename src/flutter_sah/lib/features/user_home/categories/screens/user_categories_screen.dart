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
import '../../../admin/categories/widgets/category_form_modal.dart';
import '../../../admin/categories/widgets/category_tile.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../controllers/user_categories_controller.dart';

class UserCategoriesScreen extends StatelessWidget {
  const UserCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = context.read<AuthController>().currentUser!.id;
    return ChangeNotifierProvider(
      create: (ctx) => UserCategoriesController(
        ctx.read<CategoryRepository>(),
        userId: userId,
        bus: ctx.read<CategoriesBus>(),
      ),
      child: const _UserCategoriesContent(),
    );
  }
}

class _UserCategoriesContent extends StatelessWidget {
  const _UserCategoriesContent();

  @override
  Widget build(BuildContext context) {
    SahPaletteScope.subscribe(context);
    final ctrl = context.watch<UserCategoriesController>();
    final userId = context.read<AuthController>().currentUser!.id;
    final l = AppL10n.of(context)!;

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
          l.userCategoriesTitle,
          style: TextStyle(
            fontFamily: 'GeneralSans',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: SahColors.text,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: SahSpacing.pagePadding),
            child: SahButton.primary(
              label: l.adminCategoriesNewButton,
              icon: const Icon(Icons.add_rounded, size: 16, color: Colors.white),
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

    return SingleChildScrollView(
      padding: const EdgeInsets.all(SahSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(title: l.userCategoriesYourSection),
          const SizedBox(height: 10),
          if (ctrl.personal.isEmpty)
            SahEmptyState(
              title: l.userCategoriesEmptyTitle,
              description: l.userCategoriesEmptyDescription,
              primaryAction: SahButton.primary(
                label: l.userCategoriesCreateFirst,
                onPressed: () => _showCreate(context, ctrl, userId),
              ),
            )
          else
            ..._tilesFor(
              ctrl.personal,
              ctrl.habitCounts,
              readOnly: false,
              showGlobalBadge: false,
              onEdit: (cat) => _showEdit(context, ctrl, cat, userId),
              onDelete: (cat) => _confirmDelete(
                context,
                ctrl,
                cat.id,
                ctrl.habitCounts[cat.id] ?? 0,
              ),
            ),
          const SizedBox(height: 24),
          _SectionHeader(title: l.userCategoriesGlobalsSection),
          const SizedBox(height: 4),
          Text(
            l.userCategoriesGlobalsHint,
            style: GoogleFonts.interTight(fontSize: 12, color: SahColors.textMuted),
          ),
          const SizedBox(height: 10),
          ..._tilesFor(
            ctrl.globals,
            ctrl.habitCounts,
            readOnly: true,
            showGlobalBadge: true,
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
            style: TextStyle(
              fontFamily: 'GeneralSans',
              fontSize: 18,
              color: SahColors.text,
            ),
          ),
          content: Text(
            l.adminCategoriesInUseBody(count),
            style: GoogleFonts.interTight(
                fontSize: 14, color: SahColors.textMuted, height: 1.5),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l.commonCancel,
                  style: GoogleFonts.interTight(color: SahColors.textMuted)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(l.adminCategoriesForceDelete,
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
          l.adminCategoriesDeleteTitle,
          style: TextStyle(
            fontFamily: 'GeneralSans',
            fontSize: 18,
            color: SahColors.text,
          ),
        ),
        content: Text(
          l.adminCategoriesDeleteBody,
          style: GoogleFonts.interTight(fontSize: 14, color: SahColors.textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l.commonCancel,
                style: GoogleFonts.interTight(color: SahColors.textMuted)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l.commonDelete,
                style: GoogleFonts.interTight(color: SahColors.danger)),
          ),
        ],
      ),
    );
    if (confirm == true && context.mounted) {
      await ctrl.delete(id);
    }
  }

  List<Widget> _tilesFor(
    List<Category> items,
    Map<String, int> habitCounts, {
    required bool readOnly,
    required bool showGlobalBadge,
    required void Function(Category) onEdit,
    required void Function(Category) onDelete,
  }) {
    final widgets = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      final cat = items[i];
      widgets.add(CategoryTile(
        category: cat,
        habitCount: habitCounts[cat.id] ?? 0,
        readOnly: readOnly,
        showGlobalBadge: showGlobalBadge,
        onEdit: () => onEdit(cat),
        onDelete: () => onDelete(cat),
      ));
      if (i < items.length - 1) widgets.add(const SizedBox(height: 8));
    }
    return widgets;
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

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
