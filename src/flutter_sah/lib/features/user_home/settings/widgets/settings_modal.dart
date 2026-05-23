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
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/theme_controller.dart';
import '../../../../data/local/mailtrap_config_store.dart';
import '../../../../data/models/mailtrap_config.dart';
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
    final auth = context.read<AuthController>();
    final store = context.read<MailtrapConfigStore>();

    final themeSubtitle = switch (themeCtrl.mode) {
      ThemeMode.light  => 'Sempre claro',
      ThemeMode.dark   => 'Sempre escuro',
      ThemeMode.system => 'Sistema',
    };

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
            'Configurações',
            style: TextStyle(
              fontFamily: 'GeneralSans',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: SahColors.text,
            ),
          ),
          const SizedBox(height: 16),
          _SettingsTile(
            icon: PhosphorIconsRegular.tag,
            title: 'Gerenciar categorias',
            subtitle: 'Crie e edite suas próprias',
            onTap: () {
              Navigator.pop(context);
              parentContext.push(Routes.userCategories);
            },
          ),
          const SizedBox(height: 4),
          _SettingsTile(
            icon: PhosphorIconsRegular.moon,
            title: 'Tema',
            subtitle: themeSubtitle,
            onTap: () => _showThemePicker(context, themeCtrl),
          ),
          const SizedBox(height: 4),
          _SettingsTile(
            icon: PhosphorIconsRegular.cloudArrowUp,
            title: 'Backup e dados',
            subtitle: 'Exportar e importar',
            onTap: () {
              Navigator.pop(context);
              parentContext.push(Routes.backup);
            },
          ),
          if (auth.isAdmin) ...[
            const SizedBox(height: 4),
            _SettingsTile(
              icon: Icons.mark_email_unread_outlined,
              title: 'Integração de e-mail',
              subtitle: store.isConfigured ? 'Mailtrap configurado' : 'Não configurado',
              onTap: () => _showMailtrapConfigModal(context, store),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _showThemePicker(
      BuildContext ctx, ThemeController ctrl) {
    return showSahActionSheet(
      ctx,
      title: 'Tema do aplicativo',
      actions: [
        SahActionItem(
          icon: Icons.smartphone_outlined,
          label: 'Sistema',
          onTap: () {
            Navigator.pop(ctx);
            ctrl.setMode(ThemeMode.system);
          },
        ),
        SahActionItem(
          icon: Icons.light_mode_outlined,
          label: 'Sempre claro',
          onTap: () {
            Navigator.pop(ctx);
            ctrl.setMode(ThemeMode.light);
          },
        ),
        SahActionItem(
          icon: Icons.dark_mode_outlined,
          label: 'Sempre escuro',
          onTap: () {
            Navigator.pop(ctx);
            ctrl.setMode(ThemeMode.dark);
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
  _MailtrapConfigForm({required this.store});

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
    final token = _tokenCtrl.text.trim();
    final inbox = _inboxCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final name = _nameCtrl.text.trim();

    if (token.isEmpty || inbox.isEmpty || email.isEmpty || name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Preencha todos os campos.',
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
        content: Text('Mailtrap configurado!',
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
              'Integração de e-mail',
              style: TextStyle(
                fontFamily: 'GeneralSans',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: SahColors.text,
              ),
            ),
            Text(
              'Credenciais do Mailtrap Sandbox',
              style: GoogleFonts.interTight(fontSize: 13, color: SahColors.textMuted),
            ),
            const SizedBox(height: 20),
            SahInput(
              label: 'API Token',
              controller: _tokenCtrl,
              obscureText: true,
              hint: 'Token de API do Mailtrap',
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: SahSpacing.x4),
            SahInput(
              label: 'Inbox ID',
              controller: _inboxCtrl,
              hint: 'ID da inbox no Mailtrap',
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: SahSpacing.x4),
            SahInput(
              label: 'E-mail do remetente',
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              hint: 'ex: noreply@sah.app',
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: SahSpacing.x4),
            SahInput(
              label: 'Nome do remetente',
              controller: _nameCtrl,
              hint: 'ex: Equipe SAH',
              textInputAction: TextInputAction.done,
              onEditingComplete: _save,
            ),
            const SizedBox(height: 20),
            SahButton.primary(
              label: 'Salvar',
              fullWidth: true,
              loading: _saving,
              onPressed: _save,
            ),
            const SizedBox(height: 8),
            SahButton.ghost(
              label: 'Limpar configuração',
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

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
                  color: SahColors.bgAlt,
                  borderRadius: BorderRadius.circular(SahRadius.sm),
                ),
                child: Icon(icon, size: 18, color: SahColors.textMuted),
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
                        color: SahColors.text,
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
