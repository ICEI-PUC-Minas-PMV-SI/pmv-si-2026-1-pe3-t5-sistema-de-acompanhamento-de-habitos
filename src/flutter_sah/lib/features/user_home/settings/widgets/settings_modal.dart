import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/design_system/tokens/sah_spacing.dart';
import '../../../../core/design_system/widgets/sah_action_sheet.dart';
import '../../../../core/design_system/widgets/sah_button.dart';
import '../../../../core/design_system/widgets/sah_input.dart';
import '../../../../core/i18n/locale_controller.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/theme_controller.dart';
import '../../../../data/local/mailtrap_config_store.dart';
import '../../../../data/models/mailtrap_config.dart';
import '../../../../data/notifications/notification_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/controllers/auth_controller.dart';

Future<void> showSettingsModal(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _SettingsModal(parentContext: context),
  );
}

class _SettingsModal extends StatelessWidget {
  final BuildContext parentContext;

  const _SettingsModal({required this.parentContext});

  @override
  Widget build(BuildContext context) {
    final themeCtrl = context.watch<ThemeController>();
    final localeCtrl = context.watch<LocaleController>();
    final auth = context.read<AuthController>();
    final store = context.read<MailtrapConfigStore>();
    final l = AppL10n.of(context)!;
    final currentLocation =
        GoRouterState.of(parentContext).matchedLocation;
    final inAdminArea = currentLocation.startsWith('/admin');

    final themeSubtitle = switch (themeCtrl.mode) {
      ThemeMode.light  => l.settingsThemeLight,
      ThemeMode.dark   => l.settingsThemeDark,
      ThemeMode.system => l.settingsThemeSystem,
    };

    String languageSubtitle() {
      final loc = localeCtrl.locale;
      if (loc == null) return l.settingsThemeSystem;
      return switch (loc.languageCode) {
        'pt' => l.settingsLanguagePortuguese,
        'en' => l.settingsLanguageEnglish,
        'es' => l.settingsLanguageSpanish,
        _ => loc.languageCode,
      };
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      decoration: BoxDecoration(
        color: SahColors.surface,
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(SahRadius.xl)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: SahColors.border,
                borderRadius: BorderRadius.circular(SahRadius.full),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            l.settingsTitle,
            style: TextStyle(
              fontFamily: 'GeneralSans',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: SahColors.text,
            ),
          ),
          const SizedBox(height: 16),
          if (!inAdminArea) ...[
            _SettingsTile(
              icon: PhosphorIconsRegular.tag,
              title: l.settingsManageCategories,
              subtitle: l.settingsManageCategoriesSubtitle,
              onTap: () {
                Navigator.pop(context);
                parentContext.push(Routes.userCategories);
              },
            ),
            const SizedBox(height: 4),
          ],
          _SettingsTile(
            icon: PhosphorIconsRegular.moon,
            title: l.settingsTheme,
            subtitle: themeSubtitle,
            onTap: () => _showThemePicker(context, themeCtrl),
          ),
          const SizedBox(height: 4),
          _SettingsTile(
            icon: PhosphorIconsRegular.translate,
            title: l.settingsLanguage,
            subtitle: languageSubtitle(),
            onTap: () => _showLanguagePicker(context, localeCtrl),
          ),
          if (!inAdminArea) ...[
            const SizedBox(height: 4),
            _SettingsTile(
              icon: PhosphorIconsRegular.cloudArrowUp,
              title: l.settingsBackup,
              subtitle: l.settingsBackupSubtitle,
              onTap: () {
                Navigator.pop(context);
                parentContext.push(Routes.backup);
              },
            ),
            const SizedBox(height: 4),
            _SettingsTile(
              icon: PhosphorIconsRegular.bell,
              title: l.settingsTestNotification,
              subtitle: l.settingsTestNotificationSubtitle,
              onTap: () async {
                await context.read<NotificationService>().showTestNotification();
                if (parentContext.mounted) Navigator.pop(context);
              },
            ),
          ],
          if (auth.isAdmin) ...[
            const SizedBox(height: 4),
            _SettingsTile(
              icon: inAdminArea
                  ? PhosphorIconsRegular.house
                  : PhosphorIconsRegular.shieldStar,
              title: inAdminArea
                  ? l.settingsSwitchToUser
                  : l.settingsSwitchToAdmin,
              subtitle: inAdminArea
                  ? l.settingsSwitchToUserSubtitle
                  : l.settingsSwitchToAdminSubtitle,
              onTap: () {
                Navigator.pop(context);
                parentContext.go(
                  inAdminArea ? Routes.userToday : Routes.adminDashboard,
                );
              },
            ),
            if (inAdminArea) ...[
              const SizedBox(height: 4),
              _SettingsTile(
                icon: Icons.mark_email_unread_outlined,
                title: l.settingsEmailIntegration,
                subtitle: store.isConfigured ? l.settingsEmailConfigured : l.settingsEmailNotConfigured,
                onTap: () => _showMailtrapConfigModal(context, store),
              ),
              const SizedBox(height: 4),
              _SettingsTile(
                icon: PhosphorIconsRegular.signOut,
                title: l.settingsLogout,
                subtitle: l.settingsLogoutSubtitle,
                isDangerous: true,
                onTap: () => _confirmLogout(context, parentContext),
              ),
            ],
          ],
        ],
      ),
    );
  }

  Future<void> _confirmLogout(
    BuildContext sheetContext,
    BuildContext parentContext,
  ) async {
    final l = AppL10n.of(sheetContext)!;
    final ok = await showDialog<bool>(
      context: sheetContext,
      builder: (ctx) => AlertDialog(
        backgroundColor: SahColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SahRadius.lg),
        ),
        title: Text(
          l.logoutDialogTitle,
          style: TextStyle(
            fontFamily: 'GeneralSans',
            fontSize: 18,
            color: SahColors.text,
          ),
        ),
        content: Text(
          l.logoutDialogBody,
          style: GoogleFonts.interTight(
            fontSize: 14,
            color: SahColors.textMuted,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              l.commonCancel,
              style: GoogleFonts.interTight(color: SahColors.textMuted),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              l.logoutDialogConfirm,
              style: GoogleFonts.interTight(color: SahColors.danger),
            ),
          ),
        ],
      ),
    );
    if (ok != true) return;
    if (sheetContext.mounted) Navigator.pop(sheetContext);
    if (!parentContext.mounted) return;
    await parentContext.read<AuthController>().logout();
    if (parentContext.mounted) parentContext.go(Routes.login);
  }

  Future<void> _showThemePicker(
      BuildContext ctx, ThemeController ctrl) {
    final l = AppL10n.of(ctx)!;
    return showSahActionSheet(
      ctx,
      title: l.settingsThemeAppTitle,
      actions: [
        SahActionItem(
          icon: Icons.smartphone_outlined,
          label: l.settingsThemeSystem,
          onTap: () {
            Navigator.pop(ctx);
            ctrl.setMode(ThemeMode.system);
          },
        ),
        SahActionItem(
          icon: Icons.light_mode_outlined,
          label: l.settingsThemeLight,
          onTap: () {
            Navigator.pop(ctx);
            ctrl.setMode(ThemeMode.light);
          },
        ),
        SahActionItem(
          icon: Icons.dark_mode_outlined,
          label: l.settingsThemeDark,
          onTap: () {
            Navigator.pop(ctx);
            ctrl.setMode(ThemeMode.dark);
          },
        ),
      ],
    );
  }

  Future<void> _showLanguagePicker(
      BuildContext ctx, LocaleController ctrl) {
    final l = AppL10n.of(ctx)!;
    return showSahActionSheet(
      ctx,
      title: l.settingsLanguageAppTitle,
      actions: [
        SahActionItem(
          icon: Icons.smartphone_outlined,
          label: l.settingsThemeSystem,
          onTap: () {
            Navigator.pop(ctx);
            ctrl.setLocale(null);
          },
        ),
        SahActionItem(
          icon: Icons.language,
          label: l.settingsLanguagePortuguese,
          onTap: () {
            Navigator.pop(ctx);
            ctrl.setLocale(const Locale('pt', 'BR'));
          },
        ),
        SahActionItem(
          icon: Icons.language,
          label: l.settingsLanguageEnglish,
          onTap: () {
            Navigator.pop(ctx);
            ctrl.setLocale(const Locale('en'));
          },
        ),
        SahActionItem(
          icon: Icons.language,
          label: l.settingsLanguageSpanish,
          onTap: () {
            Navigator.pop(ctx);
            ctrl.setLocale(const Locale('es'));
          },
        ),
      ],
    );
  }

  Future<void> _showMailtrapConfigModal(
      BuildContext ctx, MailtrapConfigStore store) {
    return showModalBottomSheet<void>(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _MailtrapConfigForm(store: store),
    );
  }
}

class _MailtrapConfigForm extends StatefulWidget {
  final MailtrapConfigStore store;
  const _MailtrapConfigForm({required this.store});

  @override
  State<_MailtrapConfigForm> createState() => _MailtrapConfigFormState();
}

class _MailtrapConfigFormState extends State<_MailtrapConfigForm> {
  late final TextEditingController _tokenCtrl;
  late final TextEditingController _inboxCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _nameCtrl;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final cfg = widget.store.read();
    _tokenCtrl = TextEditingController(text: cfg?.apiToken ?? '');
    _inboxCtrl = TextEditingController(text: cfg?.inboxId ?? '');
    _emailCtrl = TextEditingController(text: cfg?.fromEmail ?? '');
    _nameCtrl = TextEditingController(text: cfg?.fromName ?? '');
  }

  @override
  void dispose() {
    _tokenCtrl.dispose();
    _inboxCtrl.dispose();
    _emailCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l = AppL10n.of(context)!;
    final token = _tokenCtrl.text.trim();
    final inbox = _inboxCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final name = _nameCtrl.text.trim();

    if (token.isEmpty || inbox.isEmpty || email.isEmpty || name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l.settingsMailtrapFillAll,
              style: GoogleFonts.interTight(fontSize: 14)),
          backgroundColor: SahColors.danger,
        ),
      );
      return;
    }

    setState(() => _saving = true);
    await widget.store.write(MailtrapConfig(
      apiToken: token,
      inboxId: inbox,
      fromEmail: email,
      fromName: name,
    ));
    if (!mounted) return;
    setState(() => _saving = false);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l.settingsMailtrapSaved,
            style: GoogleFonts.interTight(fontSize: 14)),
        backgroundColor: SahColors.primary,
      ),
    );
  }

  Future<void> _clear() async {
    await widget.store.clear();
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context)!;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        decoration: BoxDecoration(
          color: SahColors.surface,
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(SahRadius.xl)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: SahColors.border,
                  borderRadius: BorderRadius.circular(SahRadius.full),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l.settingsMailtrapTitle,
              style: TextStyle(
                fontFamily: 'GeneralSans',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: SahColors.text,
              ),
            ),
            Text(
              l.settingsMailtrapSubtitle,
              style: GoogleFonts.interTight(fontSize: 13, color: SahColors.textMuted),
            ),
            const SizedBox(height: 20),
            SahInput(
              label: l.settingsMailtrapToken,
              controller: _tokenCtrl,
              obscureText: true,
              hint: l.settingsMailtrapTokenHint,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: SahSpacing.x4),
            SahInput(
              label: l.settingsMailtrapInbox,
              controller: _inboxCtrl,
              hint: l.settingsMailtrapInboxHint,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: SahSpacing.x4),
            SahInput(
              label: l.settingsMailtrapFromEmail,
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              hint: l.settingsMailtrapFromEmailHint,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: SahSpacing.x4),
            SahInput(
              label: l.settingsMailtrapFromName,
              controller: _nameCtrl,
              hint: l.settingsMailtrapFromNameHint,
              textInputAction: TextInputAction.done,
              onEditingComplete: _save,
            ),
            const SizedBox(height: 20),
            SahButton.primary(
              label: l.commonSave,
              fullWidth: true,
              loading: _saving,
              onPressed: _save,
            ),
            const SizedBox(height: 8),
            SahButton.ghost(
              label: l.settingsMailtrapClear,
              fullWidth: true,
              onPressed: _clear,
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool isDangerous;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.isDangerous = false,
  });

  @override
  Widget build(BuildContext context) {
    final accent = isDangerous ? SahColors.danger : SahColors.textMuted;
    final iconBg = isDangerous ? SahColors.dangerSoft : SahColors.bgAlt;
    final titleColor = isDangerous ? SahColors.danger : SahColors.text;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(SahRadius.md),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(SahRadius.sm),
                ),
                child: Icon(icon, size: 18, color: accent),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.interTight(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: titleColor,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.interTight(
                        fontSize: 12,
                        color: SahColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                PhosphorIconsRegular.caretRight,
                size: 16,
                color: SahColors.textFaint,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
