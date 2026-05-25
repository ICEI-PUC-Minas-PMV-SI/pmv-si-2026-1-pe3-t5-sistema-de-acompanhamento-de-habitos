import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/design_system/tokens/sah_spacing.dart';
import '../../../../core/design_system/widgets/sah_button.dart';
import '../../../../data/models/user.dart';
import '../../../../l10n/app_localizations.dart';

Future<String?> showBlockUserModal(BuildContext context, User user) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _BlockUserModal(user: user),
  );
}

class _BlockUserModal extends StatefulWidget {
  final User user;
  const _BlockUserModal({required this.user});

  @override
  State<_BlockUserModal> createState() => _BlockUserModalState();
}

class _BlockUserModalState extends State<_BlockUserModal> {
  final _ctrl = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _confirm() {
    final motivo = _ctrl.text.trim();
    if (motivo.isEmpty) {
      setState(() => _error = AppL10n.of(context)!.adminUsersBlockReasonRequired);
      return;
    }
    Navigator.pop(context, motivo);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context)!;
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(
        SahSpacing.pagePadding,
        SahSpacing.x6,
        SahSpacing.pagePadding,
        SahSpacing.pagePadding + bottomPadding,
      ),
      decoration: BoxDecoration(
        color: SahColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(SahRadius.xl)),
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
            l.adminUsersConfirmBlock,
            style: TextStyle(
              fontFamily: 'GeneralSans',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: SahColors.text,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l.adminUsersBlockModalSubtitle(widget.user.nome),
            style: GoogleFonts.interTight(fontSize: 14, color: SahColors.textMuted, height: 1.5),
          ),
          const SizedBox(height: 20),
          Text(l.adminUsersBlockReasonLabel, style: GoogleFonts.interTight(fontSize: 13, fontWeight: FontWeight.w500, color: SahColors.text)),
          const SizedBox(height: 6),
          TextField(
            controller: _ctrl,
            maxLines: 3,
            style: GoogleFonts.interTight(fontSize: 14, color: SahColors.text),
            decoration: InputDecoration(
              hintText: l.adminUsersBlockReasonHint,
              hintStyle: GoogleFonts.interTight(fontSize: 14, color: SahColors.textFaint),
              filled: true,
              fillColor: SahColors.bgAlt,
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(SahRadius.md),
                borderSide: BorderSide(color: SahColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(SahRadius.md),
                borderSide: BorderSide(color: SahColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(SahRadius.md),
                borderSide: BorderSide(color: SahColors.primary, width: 1.5),
              ),
              errorText: _error,
            ),
            onChanged: (_) => setState(() => _error = null),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: SahButton.ghost(
                  label: l.commonCancel,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SahButton.danger(
                  label: l.adminUsersBlockButton,
                  onPressed: _confirm,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
