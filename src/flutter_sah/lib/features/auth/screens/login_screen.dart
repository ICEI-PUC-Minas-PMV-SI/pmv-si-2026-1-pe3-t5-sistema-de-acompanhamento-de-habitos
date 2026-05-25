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
import '../../../l10n/app_localizations.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_scaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  String? _emailError;
  String? _passError;
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l = AppL10n.of(context)!;
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text;
    setState(() {
      _emailError =
          !SahValidators.isValidEmail(email) ? l.commonRequiredField : null;
      _passError =
          pass.isEmpty ? l.commonRequiredField : null;
    });
    if (_emailError != null || _passError != null) return;

    setState(() => _loading = true);
    final ctrl = context.read<AuthController>();
    final ok = await ctrl.login(email, pass);
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
    // go_router redirect cuida da navegação ao autenticar
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context)!;
    return AuthScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.authLoginTitle,
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
            l.authLoginSubtitle,
            style: GoogleFonts.interTight(
              fontSize: 15,
              color: SahColors.textMuted,
              height: 1.5,
            ),
          ),
          const SizedBox(height: SahSpacing.x8),
          SahCard(
            padding: 24,
            child: Column(
              children: [
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
                  prefixIcon: const SahIcon(SahIconName.lock, size: 16),
                  errorText: _passError,
                  autofillHints: const [AutofillHints.password],
                  textInputAction: TextInputAction.done,
                  onEditingComplete: _submit,
                ),
                const SizedBox(height: SahSpacing.sectionGap),
                SahButton.primary(
                  label: l.authLoginButton,
                  fullWidth: true,
                  size: SahButtonSize.lg,
                  loading: _loading,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
          const SizedBox(height: SahSpacing.itemGap),
          Center(
            child: GestureDetector(
              onTap: () => context.push(Routes.recover),
              child: Text(
                l.authForgotPassword,
                style: GoogleFonts.interTight(
                  fontSize: 13,
                  color: SahColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: SahSpacing.x4),
          Center(
            child: GestureDetector(
              onTap: () => context.push(Routes.signup),
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.interTight(
                      fontSize: 13, color: SahColors.textMuted),
                  children: <TextSpan>[
                    TextSpan(text: l.authNoAccount),
                    TextSpan(
                      text: l.authSignupLink,
                      style: TextStyle(
                          color: SahColors.primary,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
