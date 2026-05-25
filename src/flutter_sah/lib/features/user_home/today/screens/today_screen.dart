import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_palette_scope.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/design_system/tokens/sah_spacing.dart';
import '../../../../core/design_system/widgets/sah_action_sheet.dart';
import '../../../../core/design_system/widgets/sah_button.dart';
import '../../../../core/design_system/widgets/sah_illustrated_empty.dart';
import '../../../../core/design_system/widgets/sah_input.dart';
import '../../../../core/design_system/widgets/sah_spinner.dart';
import '../../../../data/backup/auto_backup_service.dart';
import '../../../../data/events/habits_bus.dart';
import '../../../../data/notifications/notification_service.dart';
import '../../../../data/repositories/category_repository.dart';
import '../../../../data/repositories/execution_log_repository.dart';
import '../../../../data/repositories/habit_repository.dart';
import '../../../../data/widgets/home_widget_service.dart';
import '../../../../features/auth/controllers/auth_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/today_controller.dart';
import '../widgets/onboarding_hint_card.dart';
import '../widgets/progress_summary_card.dart';
import '../widgets/today_habit_tile.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthController>();
    return ChangeNotifierProvider(
      create: (ctx) => TodayController(
        userId: auth.currentUser!.id,
        habitRepo: ctx.read<HabitRepository>(),
        execRepo: ctx.read<ExecutionLogRepository>(),
        catRepo: ctx.read<CategoryRepository>(),
        widget: ctx.read<HomeWidgetService>(),
        autoBackup: ctx.read<AutoBackupService>(),
        notifications: ctx.read<NotificationService>(),
        bus: ctx.read<HabitsBus>(),
      ),
      child: const _TodayView(),
    );
  }
}

class _TodayView extends StatelessWidget {
  const _TodayView();

  String _greeting(AppL10n l, String nome) {
    final hour = DateTime.now().hour;
    if (hour < 12) return l.todayGreetingMorning(nome);
    if (hour < 18) return l.todayGreetingAfternoon(nome);
    return l.todayGreetingEvening(nome);
  }

  String _formatDate(BuildContext context, DateTime d) {
    final locale = Localizations.localeOf(context).toString();
    final formatted = DateFormat('EEEE, d MMMM', locale).format(d);
    return formatted[0].toUpperCase() + formatted.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    SahPaletteScope.subscribe(context);
    final ctrl = context.watch<TodayController>();
    final auth = context.read<AuthController>();
    final l = AppL10n.of(context)!;
    final nome = auth.currentUser?.nome.split(' ').first ?? '';
    final today = DateTime.now();

    return Scaffold(
      backgroundColor: SahColors.bg,
      body: SafeArea(
        child: RefreshIndicator(
          color: SahColors.accent,
          onRefresh: ctrl.load,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  SahSpacing.pagePadding,
                  SahSpacing.x6,
                  SahSpacing.pagePadding,
                  0,
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _greeting(l, nome),
                        style: TextStyle(
                          fontFamily: 'GeneralSans',
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: SahColors.text,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _formatDate(context, today),
                        style: GoogleFonts.interTight(
                          fontSize: 14,
                          color: SahColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              // Corpo
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  SahSpacing.pagePadding,
                  0,
                  SahSpacing.pagePadding,
                  SahSpacing.pagePadding,
                ),
                sliver: _buildContent(context, ctrl),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, TodayController ctrl) {
    if (ctrl.status == TodayStatus.loading) {
      return const SliverFillRemaining(
        child: Center(child: SahSpinner()),
      );
    }

    if (ctrl.status == TodayStatus.error) {
      final l = AppL10n.of(context)!;
      return SliverFillRemaining(
        child: Center(
          child: Text(
            ctrl.error ?? l.commonError,
            style: GoogleFonts.interTight(color: SahColors.danger),
          ),
        ),
      );
    }

    if (ctrl.entries.isEmpty) {
      if (!ctrl.hasAnyHabit) {
        return const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: 8),
            child: OnboardingHintCard(),
          ),
        );
      }
      return SliverFillRemaining(
        child: SahIllustratedEmpty.todayFree(context),
      );
    }

    return SliverList(
      delegate: SliverChildListDelegate([
        ProgressSummaryCard(
          completed: ctrl.completedCount,
          total: ctrl.totalCount,
        ),
        const SizedBox(height: 20),
        Text(
          AppL10n.of(context)!.todayHeading,
          style: TextStyle(
            fontFamily: 'GeneralSans',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: SahColors.text,
          ),
        ),
        const SizedBox(height: 12),
        ...ctrl.entries.map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Builder(builder: (context) {
              return TodayHabitTile(
                entry: entry,
                onToggle: () => ctrl.toggle(entry.habit.id),
                onLongPress: () => _showTileActions(context, ctrl, entry),
              );
            }),
          ),
        ),
      ]),
    );
  }

  void _showTileActions(
    BuildContext context,
    TodayController ctrl,
    TodayHabitEntry entry,
  ) {
    final l = AppL10n.of(context)!;
    showSahActionSheet(
      context,
      title: entry.habit.nome,
      actions: [
        SahActionItem(
          icon: entry.frozenToday ? Icons.replay : Icons.snooze_outlined,
          label: entry.frozenToday ? l.todayActionUndoSkip : l.todayActionSkipDay,
          onTap: () {
            Navigator.pop(context);
            ctrl.toggleFreeze(entry.habit.id);
          },
        ),
        SahActionItem(
          icon: entry.notaToday == null
              ? Icons.note_add_outlined
              : Icons.edit_note_outlined,
          label: entry.notaToday == null
              ? l.todayActionAddNote
              : l.todayActionEditNote,
          onTap: () {
            Navigator.pop(context);
            _showNoteDialog(context, ctrl, entry);
          },
        ),
      ],
    );
  }

  void _showNoteDialog(
    BuildContext context,
    TodayController ctrl,
    TodayHabitEntry entry,
  ) {
    final l = AppL10n.of(context)!;
    final controller = TextEditingController(text: entry.notaToday ?? '');
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: SahColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SahRadius.lg),
        ),
        title: Text(
          l.todayNoteDialogTitle,
          style: TextStyle(
            fontFamily: 'GeneralSans',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: SahColors.text,
          ),
        ),
        content: SahInput(
          label: l.todayNoteLabel,
          controller: controller,
          hint: l.todayNoteHint,
          autofocus: true,
        ),
        actions: [
          SahButton.ghost(
            label: l.commonCancel,
            onPressed: () => Navigator.pop(ctx),
          ),
          SahButton.primary(
            label: l.commonSave,
            onPressed: () {
              final text = controller.text.trim();
              Navigator.pop(ctx);
              ctrl.setNote(entry.habit.id, text.isEmpty ? null : text);
            },
          ),
        ],
      ),
    );
  }
}
