import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/design_system/icons/sah_icon_data.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_palette_scope.dart';
import '../../../../core/design_system/tokens/sah_spacing.dart';
import '../../../../core/design_system/widgets/sah_spinner.dart';
import '../../../../data/repositories/habit_repository.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/metric_card.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => DashboardController(
        userRepo: ctx.read<UserRepository>(),
        habitRepo: ctx.read<HabitRepository>(),
      ),
      child: const _DashboardContent(),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent();

  String _formatNumber(int n) {
    if (n >= 1000) {
      return '${(n / 1000).toStringAsFixed(1)}k';
    }
    return n.toString();
  }

  @override
  Widget build(BuildContext context) {
    SahPaletteScope.subscribe(context);
    final ctrl = context.watch<DashboardController>();
    final l = AppL10n.of(context)!;

    if (ctrl.status == DashboardStatus.loading) {
      return const Center(child: SahSpinner(size: 28));
    }

    final m = ctrl.metrics;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(SahSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.adminDashboardTitle,
            style: TextStyle(
              fontFamily: 'GeneralSans',
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: SahColors.text,
              letterSpacing: -0.44,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l.adminDashboardSubtitle,
            style: GoogleFonts.interTight(fontSize: 14, color: SahColors.textMuted),
          ),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              MetricCard(
                label: l.adminDashboardActiveUsers,
                value: _formatNumber(m['usuariosAtivos'] as int? ?? 0),
                icon: SahIconName.users,
                iconColor: SahColors.primary,
                iconBg: SahColors.primaryFaint,
              ),
              MetricCard(
                label: l.adminDashboardTotalHabits,
                value: _formatNumber(m['habitosCriados'] as int? ?? 0),
                icon: SahIconName.sparkle,
                iconColor: SahColors.accent,
                iconBg: SahColors.accentFaint,
              ),
              MetricCard(
                label: l.adminDashboardAvgStreak,
                value: (m['streakMedioDias'] as int? ?? 0).toString(),
                icon: SahIconName.flame,
                iconColor: SahColors.streak,
                iconBg: SahColors.streakSoft,
              ),
              MetricCard(
                label: l.adminDashboardBlockedUsers,
                value: (m['bloqueios'] as int? ?? 0).toString(),
                icon: SahIconName.block,
                iconColor: SahColors.danger,
                iconBg: SahColors.dangerSoft,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
