import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_palette_scope.dart';
import '../../../../core/design_system/tokens/sah_spacing.dart';
import '../../../../core/design_system/widgets/sah_empty_state.dart';
import '../../../../core/design_system/widgets/sah_spinner.dart';
import '../../../../data/backup/auto_backup_service.dart';
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
  TodayScreen({super.key});

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
      ),
      child: _TodayView(),
    );
  }
}

class _TodayView extends StatelessWidget {
  _TodayView();

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
                padding: EdgeInsets.fromLTRB(
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
                      SizedBox(height: 2),
                      Text(
                        _formatDate(today),
                        style: GoogleFonts.interTight(
                          fontSize: 14,
                          color: SahColors.textMuted,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              // Corpo
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
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
      return SliverFillRemaining(
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
        return SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: 8),
            child: OnboardingHintCard(),
          ),
        );
      }
      return SliverFillRemaining(
        child: SahEmptyState(
          title: 'Dia livre!',
          description: 'Nenhum hábito agendado para hoje.',
        ),
      );
    }

    return SliverList(
      delegate: SliverChildListDelegate([
        ProgressSummaryCard(
          completed: ctrl.completedCount,
          total: ctrl.totalCount,
        ),
        SizedBox(height: 20),
        Text(
          'Hábitos de hoje',
          style: TextStyle(
            fontFamily: 'GeneralSans',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: SahColors.text,
          ),
        ),
        SizedBox(height: 12),
        ...ctrl.entries.map(
          (entry) => Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: TodayHabitTile(
              entry: entry,
              onToggle: () => ctrl.toggle(entry.habit.id),
            ),
          ),
        ),
      ]),
    );
  }
}
