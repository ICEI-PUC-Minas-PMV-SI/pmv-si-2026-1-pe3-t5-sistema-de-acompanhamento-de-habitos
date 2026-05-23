import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/design_system/tokens/sah_colors.dart';
import '../../../core/design_system/tokens/sah_radius.dart';
import '../../../core/design_system/tokens/sah_spacing.dart';
import '../../../core/design_system/widgets/sah_empty_state.dart';
import '../../../core/design_system/widgets/sah_spinner.dart';
import '../../../data/repositories/execution_log_repository.dart';
import '../../../data/repositories/habit_repository.dart';
import '../../auth/controllers/auth_controller.dart';
import '../history/controllers/history_controller.dart';
import '../history/widgets/history_list.dart';
import '../history/widgets/history_summary_card.dart';

class HistoryPlaceholderScreen extends StatelessWidget {
  const HistoryPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthController>();
    return ChangeNotifierProvider(
      create: (ctx) => HistoryController(
        ctx.read<HabitRepository>(),
        ctx.read<ExecutionLogRepository>(),
        userId: auth.currentUser?.id ?? '',
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

    return SingleChildScrollView(
      padding: EdgeInsets.all(SahSpacing.pagePadding),
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
          SizedBox(height: 12),

          if (ctrl.loading && ctrl.habits.isEmpty)
            Center(child: SahSpinner(size: 28))
          else if (ctrl.habits.isEmpty)
            SahEmptyState(
              title: 'Nenhum hábito',
              description: 'Crie um hábito na aba Hábitos para ver seu histórico.',
            )
          else ...[
            _HabitFilterBar(
              habits: ctrl.habits.map((h) => (id: h.id, nome: h.nome)).toList(),
              selectedId: ctrl.selectedHabitId,
              onSelect: ctrl.selectHabit,
            ),
            SizedBox(height: 8),
            _PeriodFilterBar(
              periods: _periods,
              current: ctrl.periodDays,
              onSelect: ctrl.selectPeriod,
            ),
            SizedBox(height: 16),
            if (ctrl.loading)
              Center(child: SahSpinner(size: 24))
            else ...[
              HistorySummaryCard(
                checkIns: ctrl.checkInCount,
                scheduledDays: ctrl.scheduledDays,
                adherence: ctrl.adherence,
                bestStreak: ctrl.bestStreak,
              ),
              SizedBox(height: 16),
              if (ctrl.logs.isEmpty)
                SahEmptyState(
                  title: 'Sem registros',
                  description: 'Nenhum check-in encontrado neste período.',
                )
              else
                HistoryList(logsByDay: ctrl.logsByDay),
            ],
          ],
        ],
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
        separatorBuilder: (_, __) => SizedBox(width: 8),
        itemBuilder: (_, i) {
          final h = habits[i];
          final selected = h.id == selectedId;
          return GestureDetector(
            onTap: () => onSelect(h.id),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 150),
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
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
            padding: EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => onSelect(p.days),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
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
