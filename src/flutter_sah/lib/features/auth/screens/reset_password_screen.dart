import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/design_system/icons/sah_icon.dart';
import '../../../core/design_system/icons/sah_icon_data.dart';
import '../../../core/design_system/tokens/sah_colors.dart';
import '../../../core/design_system/tokens/sah_spacing.dart';
import '../../../core/design_system/widgets/sah_button.dart';
import '../../../core/design_system/widgets/sah_card.dart';
import '../../../core/design_system/widgets/sah_input.dart';
import '../../../core/routing/routes.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_scaffold.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _tokenCtrl = TextEditingController();
  final _newPassCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  String? _tokenError;
  String? _newPassError;
  String? _confirmError;
  bool _loading = false;

  @override
  void dispose() {
    _tokenCtrl.dispose();
    _newPassCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  bool _validate() {
    final token = _tokenCtrl.text.trim();
    final newPass = _newPassCtrl.text;
    final confirm = _confirmCtrl.text;

    String? tokenErr = token.isEmpty ? 'Informe o código recebido por e-mail' : null;
    String? newPassErr = newPass.length < 6 ? 'A senha deve ter no mínimo 6 caracteres' : null;
    String? confirmErr = confirm != newPass ? 'As senhas não coincidem' : null;

    setState(() {
      _tokenError = tokenErr;
      _newPassError = newPassErr;
      _confirmError = confirmErr;
    });

    return tokenErr == null && newPassErr == null && confirmErr == null;
  }

  Future<void> _submit() async {
    if (!_validate()) return;
    setState(() => _loading = true);
    final ctrl = context.read<AuthController>();
    final ok = await ctrl.confirmPasswordReset(
      token: _tokenCtrl.text.trim(),
      newPassword: _newPassCtrl.text,
    );
    if (!mounted) return;
    setState(() => _loading = false);
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Senha redefinida com sucesso!',
              style: GoogleFonts.interTight(fontSize: 14)),
          backgroundColor: SahColors.primary,
        ),
      );
      context.go(Routes.login);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ctrl.error ?? 'Erro ao redefinir senha.',
              style: GoogleFonts.interTight(fontSize: 14)),
          backgroundColor: SahColors.danger,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => context.go(Routes.login),
            child: Row(
              children: [
                SahIcon(SahIconName.arrowLeft, size: 16, color: SahColors.textMuted),
                const SizedBox(width: 6),
                Text('Voltar ao login',
                    style: GoogleFonts.interTight(
                        fontSize: 13, color: SahColors.textMuted)),
              ],
            ),
          ),
          const SizedBox(height: SahSpacing.x6),
          Text(
            'Redefinir senha.',
            style: TextStyle(
              fontFamily: 'GeneralSans',
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: SahColors.text,
              letterSpacing: -0.52,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Cole o código que enviamos por e-mail e escolha uma nova senha.',
            style: GoogleFonts.interTight(
                fontSize: 15, color: SahColors.textMuted, height: 1.5),
          ),
          const SizedBox(height: SahSpacing.x8),
          SahCard(
            padding: 24,
            child: Column(
              children: [
                SahInput(
                  label: 'Código de redefinição',
                  controller: _tokenCtrl,
                  hint: 'Cole aqui o código recebido por e-mail',
                  errorText: _tokenError,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: SahSpacing.x4),
                SahInput(
                  label: 'Nova senha',
                  controller: _newPassCtrl,
                  obscureText: true,
                  errorText: _newPassError,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: SahSpacing.x4),
                SahInput(
                  label: 'Confirmar nova senha',
                  controller: _confirmCtrl,
                  obscureText: true,
                  errorText: _confirmError,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: _submit,
                ),
                const SizedBox(height: SahSpacing.sectionGap),
                SahButton.primary(
                  label: 'Redefinir senha',
                  fullWidth: true,
                  size: SahButtonSize.lg,
                  loading: _loading,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
