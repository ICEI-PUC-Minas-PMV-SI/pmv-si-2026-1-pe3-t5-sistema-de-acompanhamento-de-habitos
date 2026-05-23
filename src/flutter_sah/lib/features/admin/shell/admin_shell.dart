import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/design_system/icons/sah_icon.dart';
import '../../../core/design_system/icons/sah_icon_data.dart';
import '../../../core/design_system/tokens/sah_colors.dart';
import '../../../core/design_system/tokens/sah_palette_scope.dart';
import '../../../core/design_system/tokens/sah_shadows.dart';
import '../../../core/design_system/widgets/sah_logo.dart';
import '../../../core/routing/routes.dart';
import '../../auth/controllers/auth_controller.dart';

class AdminShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AdminShell({super.key, required this.navigationShell});

  static const _items = [
    (icon: SahIconName.chart, label: 'Dashboard', path: Routes.adminDashboard),
    (icon: SahIconName.users, label: 'Usuários', path: Routes.adminUsers),
    (icon: SahIconName.grid, label: 'Categorias', path: Routes.adminCategories),
    (icon: SahIconName.logs, label: 'Logs', path: Routes.adminLogs),
  ];

  void _onTap(BuildContext ctx, int idx) {
    navigationShell.goBranch(idx,
        initialLocation: idx == navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final isTablet = constraints.maxWidth >= 600;
        if (isTablet) return _TabletLayout(navigationShell: navigationShell, items: _items, onTap: _onTap);
        return _PhoneLayout(navigationShell: navigationShell, items: _items, onTap: _onTap);
      },
    );
  }
}

class _PhoneLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final List<({SahIconName icon, String label, String path})> items;
  final void Function(BuildContext, int) onTap;

  const _PhoneLayout({required this.navigationShell, required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    SahPaletteScope.subscribe(context);
    final idx = navigationShell.currentIndex;
    return Scaffold(
      backgroundColor: SahColors.bg,
      appBar: AppBar(
        backgroundColor: SahColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: SahIcon(SahIconName.menu, size: 22, color: SahColors.text),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: const SahLogo(size: 24),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: SahIcon(SahIconName.logout, size: 20, color: SahColors.textMuted),
              onPressed: () => _confirmLogout(context),
              tooltip: 'Sair',
            ),
          ),
        ],
      ),
      drawer: _AdminDrawer(items: items, currentIndex: idx, onTap: (i) {
        onTap(context, i);
        Navigator.of(context).pop();
      }),
      body: navigationShell,
    );
  }

  void _confirmLogout(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: SahColors.surface,
        title: Text('Sair?', style: TextStyle(fontFamily: 'GeneralSans', color: SahColors.text)),
        content: Text('Deseja encerrar a sessão?', style: GoogleFonts.interTight(color: SahColors.textMuted)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancelar', style: GoogleFonts.interTight(color: SahColors.textMuted))),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Sair', style: GoogleFonts.interTight(color: SahColors.danger))),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      await context.read<AuthController>().logout();
      if (context.mounted) context.go(Routes.login);
    }
  }
}

class _TabletLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final List<({SahIconName icon, String label, String path})> items;
  final void Function(BuildContext, int) onTap;

  const _TabletLayout({required this.navigationShell, required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    SahPaletteScope.subscribe(context);
    final idx = navigationShell.currentIndex;
    return Scaffold(
      backgroundColor: SahColors.bg,
      body: Row(
        children: [
          Container(
            width: 220,
            decoration: BoxDecoration(
              color: SahColors.surface,
              boxShadow: SahShadows.sm,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                    child: SahLogo(size: 28),
                  ),
                  Divider(color: SahColors.border, height: 1),
                  const SizedBox(height: 8),
                  ...items.asMap().entries.map((e) {
                    final selected = idx == e.key;
                    return _NavItem(
                      icon: e.value.icon,
                      label: e.value.label,
                      selected: selected,
                      onTap: () => onTap(context, e.key),
                    );
                  }),
                  const Spacer(),
                  Divider(color: SahColors.border, height: 1),
                  ListTile(
                    leading: SahIcon(SahIconName.logout, size: 20, color: SahColors.textMuted),
                    title: Text('Sair', style: GoogleFonts.interTight(fontSize: 14, color: SahColors.textMuted)),
                    onTap: () async {
                      await context.read<AuthController>().logout();
                      if (context.mounted) context.go(Routes.login);
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}

class _AdminDrawer extends StatelessWidget {
  final List<({SahIconName icon, String label, String path})> items;
  final int currentIndex;
  final void Function(int) onTap;

  const _AdminDrawer({required this.items, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: SahColors.surface,
      child: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Align(alignment: Alignment.centerLeft, child: SahLogo(size: 28)),
            ),
            Divider(color: SahColors.border, height: 1),
            const SizedBox(height: 8),
            ...items.asMap().entries.map((e) => _NavItem(
                  icon: e.value.icon,
                  label: e.value.label,
                  selected: currentIndex == e.key,
                  onTap: () => onTap(e.key),
                )),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final SahIconName icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({required this.icon, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        tileColor: selected ? SahColors.primaryFaint : Colors.transparent,
        leading: SahIcon(icon, size: 20, color: selected ? SahColors.primary : SahColors.textMuted),
        title: Text(
          label,
          style: GoogleFonts.interTight(
            fontSize: 14,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            color: selected ? SahColors.primary : SahColors.textMuted,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
