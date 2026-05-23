import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_palette_scope.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/design_system/tokens/sah_spacing.dart';
import '../../../../core/design_system/widgets/sah_button.dart';
import '../../../../core/design_system/widgets/sah_card.dart';
import '../../../../core/utils/dialogs.dart';
import '../../../../core/utils/result.dart';
import '../../../../data/backup/auto_backup_service.dart';
import '../../../../data/backup/backup_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/controllers/auth_controller.dart';

class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});

  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  bool _exporting = false;
  bool _importing = false;

  Future<void> _export() async {
    setState(() => _exporting = true);
    final userId = context.read<AuthController>().currentUser!.id;
    final service = context.read<BackupService>();

    final result = await service.export(userId: userId);
    if (!mounted) return;
    setState(() => _exporting = false);

    final json = result.valueOrNull;
    if (json == null) {
      _snack(AppL10n.of(context)!.backupExportError, isError: true);
      return;
    }

    try {
      final dir = await getTemporaryDirectory();
      final stamp = DateTime.now()
          .toIso8601String()
          .substring(0, 10)
          .replaceAll('-', '');
      final file = File('${dir.path}/sah_backup_$stamp.json');
      await file.writeAsString(json);
      await Share.shareXFiles(
        [XFile(file.path, mimeType: 'application/json')],
        subject: 'Backup SAH — $stamp',
      );
    } catch (e) {
      if (mounted) _snack(AppL10n.of(context)!.backupExportShareError(e.toString()), isError: true);
    }
  }

  Future<void> _import() async {
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    if (picked == null || picked.files.isEmpty) return;
    if (!mounted) return;

    final l = AppL10n.of(context)!;
    final ok = await showConfirmDialog(
      context,
      title: l.backupImportConfirmTitle,
      message: l.backupImportConfirmBody,
      confirmLabel: l.backupImportTitle,
      cancelLabel: l.commonCancel,
      isDangerous: true,
    );
    if (!ok || !mounted) return;

    setState(() => _importing = true);

    final path = picked.files.single.path;
    if (path == null) {
      _snack(l.backupImportInvalid, isError: true);
      setState(() => _importing = false);
      return;
    }

    final userId = context.read<AuthController>().currentUser!.id;
    final service = context.read<BackupService>();
    try {
      final content = await File(path).readAsString();
      final result = await service.import(userId: userId, json: content);
      if (!mounted) return;
      setState(() => _importing = false);

      if (result is Failure<void>) {
        _snack(result.message, isError: true);
        return;
      }
      _snack(l.backupImportSuccess);
      // Aguarda um momento e volta
      await Future<void>.delayed(const Duration(milliseconds: 600));
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        setState(() => _importing = false);
        _snack(l.backupImportReadError(e.toString()), isError: true);
      }
    }
  }

  void _snack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: GoogleFonts.interTight(fontSize: 14)),
      backgroundColor: isError ? SahColors.danger : SahColors.primary,
    ));
  }

  String _formatLast(BuildContext context, DateTime? dt) {
    if (dt == null) return AppL10n.of(context)!.backupAutoNever;
    final dd = dt.day.toString().padLeft(2, '0');
    final mm = dt.month.toString().padLeft(2, '0');
    final hh = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return '$dd/$mm/${dt.year} · $hh:$min';
  }

  @override
  Widget build(BuildContext context) {
    SahPaletteScope.subscribe(context);
    final l = AppL10n.of(context)!;
    final userId = context.read<AuthController>().currentUser!.id;
    final lastBackup = context.read<AutoBackupService>().lastBackupAt(userId);

    return Scaffold(
      backgroundColor: SahColors.bg,
      appBar: AppBar(
        backgroundColor: SahColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(PhosphorIconsRegular.caretLeft,
              size: 22, color: SahColors.text),
          tooltip: l.tooltipBack,
          onPressed: () => context.pop(),
        ),
        title: Text(
          l.backupTitle,
          style: TextStyle(
            fontFamily: 'GeneralSans',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: SahColors.text,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(SahSpacing.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l.backupSubtitle,
              style: GoogleFonts.interTight(
                fontSize: 13,
                color: SahColors.textMuted,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            SahCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: SahColors.primaryFaint,
                          borderRadius: BorderRadius.circular(SahRadius.sm),
                        ),
                        child: Icon(PhosphorIconsRegular.uploadSimple,
                            size: 18, color: SahColors.primary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l.backupExportTitle,
                              style: TextStyle(
                                fontFamily: 'GeneralSans',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: SahColors.text,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              l.backupExportDescription,
                              style: GoogleFonts.interTight(
                                fontSize: 12,
                                color: SahColors.textMuted,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SahButton.primary(
                    label: l.backupExportNow,
                    fullWidth: true,
                    loading: _exporting,
                    onPressed: _export,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SahCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: SahColors.accentFaint,
                          borderRadius: BorderRadius.circular(SahRadius.sm),
                        ),
                        child: Icon(PhosphorIconsRegular.downloadSimple,
                            size: 18, color: SahColors.accent),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l.backupImportTitle,
                              style: TextStyle(
                                fontFamily: 'GeneralSans',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: SahColors.text,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              l.backupImportDescription,
                              style: GoogleFonts.interTight(
                                fontSize: 12,
                                color: SahColors.textMuted,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SahButton.dangerGhost(
                    label: l.backupImportSelect,
                    fullWidth: true,
                    loading: _importing,
                    onPressed: _import,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: SahColors.bgAlt,
                borderRadius: BorderRadius.circular(SahRadius.md),
                border: Border.all(color: SahColors.border),
              ),
              child: Row(
                children: [
                  Icon(PhosphorIconsRegular.clockCounterClockwise,
                      size: 16, color: SahColors.textMuted),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l.backupAutoTitle,
                          style: GoogleFonts.interTight(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: SahColors.text,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          l.backupAutoLast(_formatLast(context, lastBackup)),
                          style: GoogleFonts.interTight(
                            fontSize: 11,
                            color: SahColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
