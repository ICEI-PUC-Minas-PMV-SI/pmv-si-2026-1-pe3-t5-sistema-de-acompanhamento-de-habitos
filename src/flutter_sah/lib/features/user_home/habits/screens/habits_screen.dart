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
import '../../../../core/design_system/tokens/sah_durations.dart';
import '../../../../core/utils/base_list_controller.dart';
import '../../../../core/utils/dialogs.dart';
import '../../../../data/models/habit.dart';
import '../../../../data/notifications/notification_service.dart';
import '../../../../data/repositories/category_repository.dart';
import '../../../../data/repositories/execution_log_repository.dart';
import '../../../../data/repositories/habit_repository.dart';
import '../../../../features/auth/controllers/auth_controller.dart';
import '../controllers/habits_controller.dart';
import '../widgets/habit_form_modal.dart';
import '../widgets/habit_list_item.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthController>();
    return ChangeNotifierProvider(
      create: (ctx) => HabitsController(
        ctx.read<HabitRepository>(),
        userId: auth.currentUser!.id,
        catRepo: ctx.read<CategoryRepository>(),
        execRepo: ctx.read<ExecutionLogRepository>(),
        notifications: ctx.read<NotificationService>(),
      ),
      child: const _HabitsView(),
    );
  }
}

class _HabitsView extends StatelessWidget {
  const _HabitsView();

  @override
  Widget build(BuildContext context) {
    SahPaletteScope.subscribe(context);
    final ctrl = context.watch<HabitsController>();

    return Scaffold(
      backgroundColor: SahColors.bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(
                SahSpacing.pagePadding,
                SahSpacing.x6,
                SahSpacing.pagePadding,
                0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Meus Hábitos',
                      style: TextStyle(
                        fontFamily: 'GeneralSans',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: SahColors.text,
                      ),
                    ),
                  ),
                  SahButton.primary(
                    label: 'Novo hábito',
                    onPressed: () => _showCreate(context, ctrl),
                    size: SahButtonSize.sm,
                  ),
                ],
              ),
            ),
            // Filtro arquivados
            Padding(
              padding: const EdgeInsets.fromLTRB(
                SahSpacing.pagePadding,
                8,
                SahSpacing.pagePadding,
                0,
              ),
              child: GestureDetector(
                onTap: ctrl.toggleShowArchived,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 36,
                      height: 20,
                      decoration: BoxDecoration(
                        color: ctrl.showArchived
                            ? SahColors.accent
                            : SahColors.border,
                        borderRadius: BorderRadius.circular(SahRadius.full),
                      ),
                      child: AnimatedAlign(
                        duration: const Duration(milliseconds: 200),
                        alignment: ctrl.showArchived
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          width: 16,
                          height: 16,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: SahColors.surface,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Mostrar arquivados',
                      style: GoogleFonts.interTight(
                        fontSize: 13,
                        color: SahColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Lista
            Expanded(child: _buildBody(context, ctrl)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, HabitsController ctrl) {
    final Widget body;

    if (ctrl.status == ListStatus.loading) {
      body = const Center(key: ValueKey('loading'), child: SahSpinner());
    } else if (ctrl.status == ListStatus.error) {
      body = Center(
        key: const ValueKey('error'),
        child: Text(
          ctrl.error ?? 'Erro ao carregar hábitos.',
          style: GoogleFonts.interTight(color: SahColors.danger),
        ),
      );
    } else if (ctrl.habits.isEmpty) {
      body = SahEmptyState(
        key: const ValueKey('empty'),
        title: ctrl.showArchived
            ? 'Nenhum hábito arquivado'
            : 'Nenhum hábito ainda',
        description: ctrl.showArchived
            ? 'Hábitos arquivados aparecerão aqui.'
            : 'Crie seu primeiro hábito para começar.',
        primaryAction: ctrl.showArchived
            ? null
            : SahButton.primary(
                label: 'Criar primeiro hábito',
                onPressed: () => _showCreate(context, ctrl),
              ),
      );
    } else {
      body = ListView.separated(
        key: const ValueKey('data'),
        padding: const EdgeInsets.fromLTRB(
          SahSpacing.pagePadding,
          0,
          SahSpacing.pagePadding,
          SahSpacing.pagePadding,
        ),
        itemCount: ctrl.habits.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) {
          final habit = ctrl.habits[i];
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: Duration(milliseconds: 280 + i * 40),
            curve: Curves.easeOutCubic,
            builder: (_, t, child) => Opacity(
              opacity: t,
              child: Transform.translate(
                offset: Offset(0, (1 - t) * 12),
                child: child,
              ),
            ),
            child: HabitListItem(
              habit: habit,
              category: ctrl.categoryFor(habit.categoriaId),
              streak: ctrl.streaks[habit.id] ?? 0,
              onEdit: () => _showEdit(context, ctrl, habit),
              onArchive: () => _archiveOrUnarchive(context, ctrl, habit),
              onDelete: () => _confirmDelete(context, ctrl, habit),
            ),
          );
        },
      );
    }

    return AnimatedSwitcher(
      duration: SahDurations.normal,
      switchInCurve: Curves.easeOutCubic,
      child: body,
    );
  }

  Future<void> _showCreate(BuildContext context, HabitsController ctrl) async {
    final habit = await showHabitFormModal(
      context,
      categories: ctrl.categories,
    );
    if (habit != null && context.mounted) {
      await ctrl.create(habit.copyWith(userId: ctrl.userId));
    }
  }

  Future<void> _showEdit(
    BuildContext context,
    HabitsController ctrl,
    Habit existing,
  ) async {
    final habit = await showHabitFormModal(
      context,
      existing: existing,
      categories: ctrl.categories,
    );
    if (habit != null && context.mounted) {
      await ctrl.update(habit.copyWith(id: existing.id, userId: existing.userId));
    }
  }

  Future<void> _archiveOrUnarchive(
    BuildContext context,
    HabitsController ctrl,
    Habit habit,
  ) async {
    if (habit.arquivado) {
      await ctrl.unarchive(habit.id);
      return;
    }
    final ok = await showConfirmDialog(
      context,
      title: 'Arquivar hábito?',
      message:
          'O hábito ficará oculto da lista principal. Você pode desarquivá-lo depois em "Mostrar arquivados".',
      confirmLabel: 'Arquivar',
    );
    if (ok && context.mounted) await ctrl.archive(habit.id);
  }

  Future<void> _confirmDelete(
    BuildContext context,
    HabitsController ctrl,
    Habit habit,
  ) async {
    final ok = await showConfirmDialog(
      context,
      title: 'Excluir hábito',
      message: 'Tem certeza? O histórico de check-ins também será removido.',
      confirmLabel: 'Excluir',
      isDangerous: true,
    );
    if (ok && context.mounted) await ctrl.delete(habit.id);
  }
}
