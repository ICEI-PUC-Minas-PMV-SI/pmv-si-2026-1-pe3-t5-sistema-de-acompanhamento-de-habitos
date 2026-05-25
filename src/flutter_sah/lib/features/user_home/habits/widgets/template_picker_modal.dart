import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/design_system/tokens/sah_spacing.dart';
import '../../../../core/design_system/widgets/sah_button.dart';
import '../../../../l10n/app_localizations.dart';
import '../data/habit_templates.dart';

Future<HabitTemplate?> showTemplatePickerModal(BuildContext context) {
  return showModalBottomSheet<HabitTemplate>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _TemplatePickerModal(),
  );
}

class _TemplatePickerModal extends StatelessWidget {
  const _TemplatePickerModal();

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context)!;
    return Container(
      padding: EdgeInsets.fromLTRB(
        SahSpacing.pagePadding,
        SahSpacing.x6,
        SahSpacing.pagePadding,
        SahSpacing.pagePadding + MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: SahColors.surface,
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(SahRadius.xl)),
      ),
      child: SingleChildScrollView(
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
              l.templatesTitle,
              style: TextStyle(
                fontFamily: 'GeneralSans',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: SahColors.text,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l.templatesSubtitle,
              style: GoogleFonts.interTight(
                fontSize: 13,
                color: SahColors.textMuted,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 20),
            ...habitTemplatesFor(l).map((t) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _TemplateCard(template: t),
                )),
            const SizedBox(height: 8),
            SahButton.ghost(
              label: l.commonCancel,
              fullWidth: true,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _TemplateCard extends StatelessWidget {
  final HabitTemplate template;

  const _TemplateCard({required this.template});

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context)!;
    return InkWell(
      onTap: () => Navigator.pop(context, template),
      borderRadius: BorderRadius.circular(SahRadius.lg),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: SahColors.surface,
          borderRadius: BorderRadius.circular(SahRadius.lg),
          border: Border.all(color: SahColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: template.cor.withAlpha(30),
                borderRadius: BorderRadius.circular(SahRadius.md),
              ),
              child: Icon(template.icone, size: 22, color: template.cor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    template.nome,
                    style: TextStyle(
                      fontFamily: 'GeneralSans',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: SahColors.text,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l.templatesCount(template.habitos.length, template.descricao),
                    style: GoogleFonts.interTight(
                      fontSize: 12,
                      color: SahColors.textMuted,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: SahColors.textFaint),
          ],
        ),
      ),
    );
  }
}
