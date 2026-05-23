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
import '../../../core/utils/validators.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_scaffold.dart';

class RecoverScreen extends StatefulWidget {
  const RecoverScreen({super.key});

  @override
  State<RecoverScreen> createState() => _RecoverScreenState();
}

class _RecoverScreenState extends State<RecoverScreen> {
  final _emailCtrl = TextEditingController();
  String? _emailError;
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final email = _emailCtrl.text.trim();
    setState(() {
      _emailError =
          !SahValidators.isValidEmail(email) ? 'Informe um e-mail válido' : null;
    });
    if (_emailError != null) return;
    setState(() => _loading = true);
    final ctrl = context.read<AuthController>();
    final ok = await ctrl.requestPasswordReset(email);
    if (!mounted) return;
    setState(() => _loading = false);
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ctrl.error ?? 'Erro ao enviar e-mail.',
              style: GoogleFonts.interTight(fontSize: 14)),
          backgroundColor: SahColors.danger,
        ),
      );
      return;
    }
    context.pushReplacement(Routes.recoverSent);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Row(
              children: [
                SahIcon(SahIconName.arrowLeft,
                    size: 16, color: SahColors.textMuted),
                const SizedBox(width: 6),
                Text('Voltar ao login',
                    style: GoogleFonts.interTight(
                        fontSize: 13, color: SahColors.textMuted)),
              ],
            ),
          ),
          const SizedBox(height: SahSpacing.x6),
          Text(
            'Recuperar senha.',
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
            'Enviaremos um link de redefinição para o e-mail cadastrado.',
            style: GoogleFonts.interTight(
                fontSize: 15, color: SahColors.textMuted, height: 1.5),
          ),
          const SizedBox(height: SahSpacing.x8),
          SahCard(
            padding: 24,
            child: Column(
              children: [
                SahInput(
                  label: 'E-mail',
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const SahIcon(SahIconName.mail, size: 16),
                  errorText: _emailError,
                  autofillHints: const [AutofillHints.email],
                  textInputAction: TextInputAction.done,
                  onEditingComplete: _submit,
                ),
                const SizedBox(height: SahSpacing.sectionGap),
                SahButton.primary(
                  label: 'Enviar link',
                  fullWidth: true,
                  size: SahButtonSize.lg,
                  loading: _loading,
                  onPressed: _submit,
                ),
                const SizedBox(height: 8),
                Center(
                  child: TextButton(
                    onPressed: () => context.go(Routes.resetPassword),
                    child: Text(
                      'Já tenho um código',
                      style: GoogleFonts.interTight(
                        fontSize: 13,
                        color: SahColors.textMuted,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
