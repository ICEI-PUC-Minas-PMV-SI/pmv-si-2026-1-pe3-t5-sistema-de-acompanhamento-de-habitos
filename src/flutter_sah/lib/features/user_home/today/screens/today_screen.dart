import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
import '../../../../data/notifications/notification_service.dart';
import '../../../../data/repositories/category_repository.dart';
import '../../../../data/repositories/execution_log_repository.dart';
import '../../../../data/repositories/habit_repository.dart';
import '../../../../data/widgets/home_widget_service.dart';
import '../../../../features/auth/controllers/auth_controller.dart';
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
      ),
      child: const _TodayView(),
    );
  }
}

class _TodayView extends StatelessWidget {
  const _TodayView();

  String _greeting(String nome) {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Bom dia, $nome!';
    if (hour < 18) return 'Boa tarde, $nome!';
    return 'Boa noite, $nome!';
  }

  String _formatDate(DateTime d) {
    final weekdays = [
      'Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado',
    ];
    final months = [
      '', 'janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho',
      'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro',
    ];
    return '${weekdays[d.weekday % 7]}, ${d.day} de ${months[d.month]}';
  }

  @override
  Widget build(BuildContext context) {
    SahPaletteScope.subscribe(context);
    final ctrl = context.watch<TodayController>();
    final auth = context.read<AuthController>();
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
                        _greeting(nome),
                        style: TextStyle(
                          fontFamily: 'GeneralSans',
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: SahColors.text,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _formatDate(today),
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
                sliver: _buildContent(ctrl),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(TodayController ctrl) {
    if (ctrl.status == TodayStatus.loading) {
      return const SliverFillRemaining(
        child: Center(child: SahSpinner()),
      );
    }

    if (ctrl.status == TodayStatus.error) {
      return SliverFillRemaining(
        child: Center(
          child: Text(
            ctrl.error ?? 'Erro ao carregar hábitos.',
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
        child: SahIllustratedEmpty.todayFree(),
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
          'Hábitos de hoje',
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
    showSahActionSheet(
      context,
      title: entry.habit.nome,
      actions: [
        SahActionItem(
          icon: entry.frozenToday ? Icons.replay : Icons.snooze_outlined,
          label: entry.frozenToday ? 'Desfazer pulo' : 'Pular hoje',
          onTap: () {
            Navigator.pop(context);
            ctrl.toggleFreeze(entry.habit.id);
          },
        ),
        SahActionItem(
          icon: entry.notaToday == null
              ? Icons.note_add_outlined
              : Icons.edit_note_outlined,
          label: entry.notaToday == null ? 'Adicionar nota' : 'Editar nota',
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
    final controller = TextEditingController(text: entry.notaToday ?? '');
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: SahColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SahRadius.lg),
        ),
        title: Text(
          'Nota do dia',
          style: TextStyle(
            fontFamily: 'GeneralSans',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: SahColors.text,
          ),
        ),
        content: SahInput(
          label: 'Como foi?',
          controller: controller,
          hint: 'Opcional. Ex: dormi mal, treino curto…',
          autofocus: true,
        ),
        actions: [
          SahButton.ghost(
            label: 'Cancelar',
            onPressed: () => Navigator.pop(ctx),
          ),
          SahButton.primary(
            label: 'Salvar',
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
