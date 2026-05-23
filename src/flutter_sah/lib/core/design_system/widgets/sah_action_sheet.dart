import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../tokens/sah_colors.dart';
import '../tokens/sah_radius.dart';

class SahActionItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool destructive;

  SahActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.destructive = false,
  });
}

Future<void> showSahActionSheet(
  BuildContext context, {
  required String title,
  required List<SahActionItem> actions,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _SahActionSheet(title: title, actions: actions),
  );
}

class _SahActionSheet extends StatelessWidget {
  final String title;
  final List<SahActionItem> actions;

  _SahActionSheet({required this.title, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 32),
      decoration: BoxDecoration(
        color: SahColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(SahRadius.xl)),
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
          SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'GeneralSans',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: SahColors.text,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8),
          ...actions.map((item) => _ActionTile(item: item)),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final SahActionItem item;

  _ActionTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final color = item.destructive ? SahColors.danger : SahColors.text;
    final iconBg = item.destructive ? SahColors.dangerSoft : SahColors.bgAlt;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(SahRadius.md),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(SahRadius.sm),
                ),
                child: Icon(item.icon, size: 18, color: color),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.label,
                  style: GoogleFonts.interTight(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
