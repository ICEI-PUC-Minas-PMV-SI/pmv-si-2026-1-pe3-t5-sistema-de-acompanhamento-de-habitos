import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/design_system/tokens/sah_colors.dart';
import '../../../core/design_system/tokens/sah_palette_scope.dart';
import '../../../core/design_system/widgets/sah_logo.dart';
import '../settings/widgets/settings_modal.dart';

class UserShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  UserShell({super.key, required this.navigationShell});

  void _onTap(int idx) {
    navigationShell.goBranch(idx,
        initialLocation: idx == navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    SahPaletteScope.subscribe(context);
    return Scaffold(
      backgroundColor: SahColors.bg,
      appBar: AppBar(
        backgroundColor: SahColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: SahLogo(size: 24),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              PhosphorIconsRegular.gear,
              size: 22,
              color: SahColors.textMuted,
            ),
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
            icon: Icon(PhosphorIconsRegular.house),
            selectedIcon: Icon(PhosphorIconsFill.house, color: SahColors.accent),
            label: 'Hoje',
          ),
          NavigationDestination(
            icon: Icon(PhosphorIconsRegular.sparkle),
            selectedIcon: Icon(PhosphorIconsFill.sparkle, color: SahColors.accent),
            label: 'Hábitos',
          ),
          NavigationDestination(
            icon: Icon(PhosphorIconsRegular.chartBar),
            selectedIcon: Icon(PhosphorIconsFill.chartBar, color: SahColors.accent),
            label: 'Histórico',
          ),
          NavigationDestination(
            icon: Icon(PhosphorIconsRegular.user),
            selectedIcon: Icon(PhosphorIconsFill.user, color: SahColors.accent),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
