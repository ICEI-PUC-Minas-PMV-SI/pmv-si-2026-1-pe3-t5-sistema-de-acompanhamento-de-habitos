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
import '../../../core/utils/validators.dart';
import '../../../l10n/app_localizations.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/password_strength_meter.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nomeCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  String? _nomeError;
  String? _emailError;
  String? _passError;
  bool _loading = false;

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l = AppL10n.of(context)!;
    final nome = _nomeCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text;
    setState(() {
      _nomeError = nome.isEmpty ? l.commonRequiredField : null;
      _emailError =
          !SahValidators.isValidEmail(email) ? l.commonRequiredField : null;
      _passError = !SahValidators.isValidPassword(pass)
          ? l.profileNewPasswordTooShort
          : null;
    });
    if (_nomeError != null || _emailError != null || _passError != null) return;

    setState(() => _loading = true);
    final ctrl = context.read<AuthController>();
    final ok = await ctrl.signup(nome: nome, email: email, password: pass);
    if (!mounted) return;
    setState(() => _loading = false);
    if (!ok && ctrl.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ctrl.error!,
              style: GoogleFonts.interTight(fontSize: 14)),
          backgroundColor: SahColors.danger,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context)!;
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
                Text(
                  l.authBackToLogin,
                  style: GoogleFonts.interTight(
                      fontSize: 13, color: SahColors.textMuted),
                ),
              ],
            ),
          ),
          const SizedBox(height: SahSpacing.x6),
          Text(
            l.authSignupTitle,
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
            l.authSignupSubtitle,
            style: GoogleFonts.interTight(
                fontSize: 15, color: SahColors.textMuted, height: 1.5),
          ),
          const SizedBox(height: SahSpacing.x8),
          SahCard(
            padding: 24,
            child: Column(
              children: [
                SahInput(
                  label: l.authNameLabel,
                  controller: _nomeCtrl,
                  hint: l.authNameHint,
                  prefixIcon: const SahIcon(SahIconName.user, size: 16),
                  errorText: _nomeError,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: SahSpacing.itemGap),
                SahInput(
                  label: l.authEmailLabel,
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const SahIcon(SahIconName.mail, size: 16),
                  errorText: _emailError,
                  autofillHints: const [AutofillHints.email],
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: SahSpacing.itemGap),
                SahInput(
                  label: l.authPasswordLabel,
                  controller: _passCtrl,
                  obscureText: true,
                  hint: l.profileNewPasswordTooShort,
                  prefixIcon: const SahIcon(SahIconName.lock, size: 16),
                  errorText: _passError,
                  onChanged: (_) => setState(() {}),
                  textInputAction: TextInputAction.done,
                  onEditingComplete: _submit,
                ),
                PasswordStrengthMeter(password: _passCtrl.text),
                const SizedBox(height: SahSpacing.sectionGap),
                SahButton.primary(
                  label: l.authSignupButton,
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
