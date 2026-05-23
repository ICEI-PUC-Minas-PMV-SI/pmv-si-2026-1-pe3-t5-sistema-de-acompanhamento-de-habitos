import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/design_system/tokens/sah_colors.dart';
import '../../../core/design_system/tokens/sah_radius.dart';
import '../../../core/design_system/tokens/sah_spacing.dart';
import '../../../core/design_system/widgets/sah_illustrated_empty.dart';
import '../../../core/design_system/widgets/sah_spinner.dart';
import '../../../data/events/habits_bus.dart';
import '../../../data/notifications/notification_service.dart';
import '../../../data/repositories/execution_log_repository.dart';
import '../../../data/repositories/habit_repository.dart';
import '../../auth/controllers/auth_controller.dart';
import '../history/controllers/history_controller.dart';
import '../history/widgets/history_list.dart';
import '../history/widgets/history_summary_card.dart';
import '../history/widgets/history_weekly_chart.dart';
import '../history/widgets/reminder_suggestion_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthController>();
    return ChangeNotifierProvider(
      create: (ctx) => HistoryController(
        ctx.read<HabitRepository>(),
        ctx.read<ExecutionLogRepository>(),
        userId: auth.currentUser?.id ?? '',
        notifications: ctx.read<NotificationService>(),
        bus: ctx.read<HabitsBus>(),
      )..load(),
      child: const _HistoryContent(),
    );
  }
}

class _HistoryContent extends StatelessWidget {
  const _HistoryContent();

  static const _periods = [
    (label: '7 dias', days: 7),
    (label: '30 dias', days: 30),
    (label: '90 dias', days: 90),
    (label: 'Tudo', days: 0),
  ];

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<HistoryController>();

    return RefreshIndicator(
      color: SahColors.accent,
      onRefresh: ctrl.load,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(SahSpacing.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
            'Histórico',
            style: TextStyle(
              fontFamily: 'GeneralSans',
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: SahColors.text,
              letterSpacing: -0.44,
            ),
          ),
          const SizedBox(height: 12),

          if (ctrl.loading && ctrl.habits.isEmpty)
            const Center(child: SahSpinner(size: 28))
          else if (ctrl.habits.isEmpty)
            SahIllustratedEmpty.noHabits()
          else ...[
            _HabitFilterBar(
              habits: ctrl.habits.map((h) => (id: h.id, nome: h.nome)).toList(),
              selectedId: ctrl.selectedHabitId,
              onSelect: ctrl.selectHabit,
            ),
            const SizedBox(height: 8),
            _PeriodFilterBar(
              periods: _periods,
              current: ctrl.periodDays,
              onSelect: ctrl.selectPeriod,
            ),
            const SizedBox(height: 16),
            if (ctrl.loading)
              const Center(child: SahSpinner(size: 24))
            else if (ctrl.logs.isEmpty)
              // Nenhum check-in no período: tela limpa, só o empty state
              SahIllustratedEmpty.noHistory()
            else ...[
              HistorySummaryCard(
                checkIns: ctrl.checkInCount,
                scheduledDays: ctrl.scheduledDays,
                adherence: ctrl.adherence,
                bestStreak: ctrl.bestStreak,
              ),
              if (ctrl.reminderSuggestion != null &&
                  ctrl.selectedHabit != null &&
                  !ctrl.isSuggestionDismissed(ctrl.selectedHabit!.id)) ...[
                const SizedBox(height: 12),
                ReminderSuggestionCard(
                  suggestion: ctrl.reminderSuggestion!,
                  habitName: ctrl.selectedHabit!.nome,
                  onDismiss: () =>
                      ctrl.dismissSuggestion(ctrl.selectedHabit!.id),
                  onApply: () async {
                    final s = ctrl.reminderSuggestion!;
                    final ok = await ctrl.applyReminderSuggestion(s);
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        ok
                            ? 'Lembrete ajustado para ${s.suggestedReminder}'
                            : 'Não foi possível ajustar.',
                      ),
                      backgroundColor:
                          ok ? SahColors.primary : SahColors.danger,
                    ));
                  },
                ),
              ],
              if (ctrl.weeklyAdherence.length >= 2) ...[
                const SizedBox(height: 12),
                HistoryWeeklyChart(data: ctrl.weeklyAdherence),
              ],
              const SizedBox(height: 16),
              HistoryList(logsByDay: ctrl.logsByDay),
            ],
          ],
        ],
        ),
      ),
    );
  }
}

class _HabitFilterBar extends StatelessWidget {
  final List<({String id, String nome})> habits;
  final String? selectedId;
  final void Function(String) onSelect;

  const _HabitFilterBar({
    required this.habits,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: habits.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final h = habits[i];
          final selected = h.id == selectedId;
          return GestureDetector(
            onTap: () => onSelect(h.id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: selected ? SahColors.primary : SahColors.surface,
                borderRadius: BorderRadius.circular(SahRadius.full),
                border: Border.all(
                  color: selected ? SahColors.primary : SahColors.border,
                ),
              ),
              child: Text(
                h.nome,
                style: GoogleFonts.interTight(
                  fontSize: 13,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  color: selected ? Colors.white : SahColors.textMuted,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PeriodFilterBar extends StatelessWidget {
  final List<({String label, int days})> periods;
  final int current;
  final void Function(int) onSelect;

  const _PeriodFilterBar({
    required this.periods,
    required this.current,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: periods.map((p) {
          final selected = p.days == current;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => onSelect(p.days),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: selected ? SahColors.accentFaint : SahColors.bgAlt,
                  borderRadius: BorderRadius.circular(SahRadius.full),
                  border: Border.all(
                    color: selected ? SahColors.accentSoft : SahColors.border,
                  ),
                ),
                child: Text(
                  p.label,
                  style: GoogleFonts.interTight(
                    fontSize: 12,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    color: selected ? SahColors.accent : SahColors.textMuted,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
