import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/design_system/tokens/sah_colors.dart';
import '../../../core/design_system/tokens/sah_palette_scope.dart';
import '../../../core/design_system/widgets/sah_logo.dart';
import '../../../l10n/app_localizations.dart';
import '../../user_home/settings/widgets/settings_modal.dart';

class AdminShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AdminShell({super.key, required this.navigationShell});

  void _onTap(int idx) {
    navigationShell.goBranch(idx,
        initialLocation: idx == navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    SahPaletteScope.subscribe(context);
    final l = AppL10n.of(context)!;
    return Scaffold(
      backgroundColor: SahColors.bg,
      appBar: AppBar(
        backgroundColor: SahColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const SahLogo(size: 24),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              PhosphorIconsRegular.gear,
              size: 22,
              color: SahColors.textMuted,
            ),
            tooltip: l.tooltipSettings,
            onPressed: () => showSettingsModal(context),
          ),
        ],
      ),
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        backgroundColor: SahColors.surface,
        indicatorColor: SahColors.accentFaint,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onTap,
        destinations: [
          NavigationDestination(
            icon: const Icon(PhosphorIconsRegular.chartLine),
            selectedIcon: Icon(PhosphorIconsFill.chartLine, color: SahColors.accent),
            label: l.navAdminDashboard,
          ),
          NavigationDestination(
            icon: const Icon(PhosphorIconsRegular.usersThree),
            selectedIcon: Icon(PhosphorIconsFill.usersThree, color: SahColors.accent),
            label: l.navAdminUsers,
          ),
          NavigationDestination(
            icon: const Icon(PhosphorIconsRegular.squaresFour),
            selectedIcon: Icon(PhosphorIconsFill.squaresFour, color: SahColors.accent),
            label: l.navAdminCategories,
          ),
          NavigationDestination(
            icon: const Icon(PhosphorIconsRegular.fileText),
            selectedIcon: Icon(PhosphorIconsFill.fileText, color: SahColors.accent),
            label: l.navAdminLogs,
          ),
        ],
      ),
    );
  }
}
