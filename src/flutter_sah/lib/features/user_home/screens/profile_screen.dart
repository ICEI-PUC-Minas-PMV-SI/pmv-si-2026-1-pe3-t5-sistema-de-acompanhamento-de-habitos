import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/design_system/tokens/sah_colors.dart';
import '../../../core/design_system/tokens/sah_palette_scope.dart';
import '../../../core/design_system/tokens/sah_radius.dart';
import '../../../core/design_system/tokens/sah_spacing.dart';
import '../../../core/design_system/widgets/sah_button.dart';
import '../../../core/design_system/widgets/sah_card.dart';
import '../../../core/design_system/widgets/sah_input.dart';
import '../../../core/routing/routes.dart';
import '../../../core/utils/dialogs.dart';
import '../../auth/controllers/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SahPaletteScope.subscribe(context);
    final auth = context.watch<AuthController>();
    final user = auth.currentUser;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(SahSpacing.pagePadding),
      child: Column(
        children: [
          // Header com avatar
          Container(
            padding: const EdgeInsets.all(SahSpacing.cardPadding),
            decoration: BoxDecoration(
              color: SahColors.surface,
              borderRadius: BorderRadius.circular(SahRadius.lg),
              border: Border.all(color: SahColors.border),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: SahColors.accentFaint,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      user?.nome.isNotEmpty == true
                          ? user!.nome[0].toUpperCase()
                          : '?',
                      style: TextStyle(
                        fontFamily: 'GeneralSans',
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: SahColors.accent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.nome ?? '—',
                        style: TextStyle(
                          fontFamily: 'GeneralSans',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: SahColors.text,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user?.email ?? '—',
                        style: GoogleFonts.interTight(
                          fontSize: 13,
                          color: SahColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const _EditProfileSection(),
          const SizedBox(height: 8),
          SahButton.danger(
            label: 'Sair da conta',
            fullWidth: true,
            onPressed: () async {
              await context.read<AuthController>().logout();
              if (context.mounted) context.go(Routes.login);
            },
          ),
          const SizedBox(height: 8),
          SahButton.dangerGhost(
            label: 'Excluir minha conta',
            fullWidth: true,
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final ok = await showConfirmDialog(
      context,
      title: 'Excluir minha conta?',
      message:
          'Esta ação é permanente. Todos os seus hábitos, registros e categorias serão removidos. Não pode ser desfeita.',
      confirmLabel: 'Excluir',
      cancelLabel: 'Cancelar',
      isDangerous: true,
    );
    if (!ok || !context.mounted) return;

    final ctrl = context.read<AuthController>();
    final done = await ctrl.deleteAccount();
    if (!context.mounted) return;
    if (done) {
      context.go(Routes.login);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          ctrl.error ?? 'Falha ao excluir conta.',
          style: GoogleFonts.interTight(fontSize: 14),
        ),
        backgroundColor: SahColors.danger,
      ));
    }
  }
}

class _EditProfileSection extends StatefulWidget {
  const _EditProfileSection();

  @override
  State<_EditProfileSection> createState() => _EditProfileSectionState();
}

class _EditProfileSectionState extends State<_EditProfileSection> {
  late final TextEditingController _nomeCtrl;
  final _senhaAtualCtrl = TextEditingController();
  final _novaSenhaCtrl = TextEditingController();
  final _confirmarCtrl = TextEditingController();

  String? _nomeError;
  String? _senhaAtualError;
  String? _novaSenhaError;
  String? _confirmarError;
  bool _savingNome = false;
  bool _savingPassword = false;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthController>().currentUser;
    _nomeCtrl = TextEditingController(text: user?.nome ?? '');
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _senhaAtualCtrl.dispose();
    _novaSenhaCtrl.dispose();
    _confirmarCtrl.dispose();
    super.dispose();
  }

  String? get _nomeOriginal =>
      context.read<AuthController>().currentUser?.nome;

  bool get _nomeAlterado =>
      _nomeCtrl.text.trim() != (_nomeOriginal ?? '');

  Future<void> _salvarNome() async {
    final nome = _nomeCtrl.text.trim();
    String? err;
    if (nome.isEmpty) err = 'O nome não pode ser vazio';
    if (nome.length < 2) err = 'Nome deve ter pelo menos 2 caracteres';
    setState(() => _nomeError = err);
    if (err != null) return;

    setState(() => _savingNome = true);
    final ctrl = context.read<AuthController>();
    final ok = await ctrl.updateProfile(nome: nome);
    if (!mounted) return;
    setState(() => _savingNome = false);
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nome atualizado!',
              style: GoogleFonts.interTight(fontSize: 14)),
          backgroundColor: SahColors.primary,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ctrl.error ?? 'Erro ao atualizar nome.',
              style: GoogleFonts.interTight(fontSize: 14)),
          backgroundColor: SahColors.danger,
        ),
      );
    }
  }

  Future<void> _alterarSenha() async {
    final atual = _senhaAtualCtrl.text;
    final nova = _novaSenhaCtrl.text;
    final confirmar = _confirmarCtrl.text;

    final atualErr = atual.isEmpty ? 'Informe a senha atual' : null;
    final novaErr = nova.length < 6 ? 'A nova senha deve ter no mínimo 6 caracteres' : null;
    final confirmarErr = confirmar != nova ? 'As senhas não coincidem' : null;

    setState(() {
      _senhaAtualError = atualErr;
      _novaSenhaError = novaErr;
      _confirmarError = confirmarErr;
    });

    if (atualErr != null || novaErr != null || confirmarErr != null) return;

    setState(() => _savingPassword = true);
    final ctrl = context.read<AuthController>();
    final ok = await ctrl.changePassword(
      currentPassword: atual,
      newPassword: nova,
    );
    if (!mounted) return;
    setState(() => _savingPassword = false);
    if (ok) {
      _senhaAtualCtrl.clear();
      _novaSenhaCtrl.clear();
      _confirmarCtrl.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Senha alterada com sucesso!',
              style: GoogleFonts.interTight(fontSize: 14)),
          backgroundColor: SahColors.primary,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ctrl.error ?? 'Erro ao alterar senha.',
              style: GoogleFonts.interTight(fontSize: 14)),
          backgroundColor: SahColors.danger,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Seção: Dados da conta
        SahCard(
          padding: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dados da conta',
                style: TextStyle(
                  fontFamily: 'GeneralSans',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: SahColors.text,
                ),
              ),
              const SizedBox(height: 16),
              SahInput(
                label: 'Nome',
                controller: _nomeCtrl,
                errorText: _nomeError,
                textInputAction: TextInputAction.done,
                onChanged: (_) => setState(() {}),
                onEditingComplete: _nomeAlterado ? _salvarNome : null,
              ),
              const SizedBox(height: 12),
              SahButton.primary(
                label: 'Salvar nome',
                fullWidth: true,
                loading: _savingNome,
                disabled: !_nomeAlterado,
                onPressed: _salvarNome,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Seção: Alterar senha
        SahCard(
          padding: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alterar senha',
                style: TextStyle(
                  fontFamily: 'GeneralSans',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: SahColors.text,
                ),
              ),
              const SizedBox(height: 16),
              SahInput(
                label: 'Senha atual',
                controller: _senhaAtualCtrl,
                obscureText: true,
                errorText: _senhaAtualError,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: SahSpacing.x4),
              SahInput(
                label: 'Nova senha',
                controller: _novaSenhaCtrl,
                obscureText: true,
                errorText: _novaSenhaError,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: SahSpacing.x4),
              SahInput(
                label: 'Confirmar nova senha',
                controller: _confirmarCtrl,
                obscureText: true,
                errorText: _confirmarError,
                textInputAction: TextInputAction.done,
                onEditingComplete: _alterarSenha,
              ),
              const SizedBox(height: 12),
              SahButton.primary(
                label: 'Alterar senha',
                fullWidth: true,
                loading: _savingPassword,
                onPressed: _alterarSenha,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
