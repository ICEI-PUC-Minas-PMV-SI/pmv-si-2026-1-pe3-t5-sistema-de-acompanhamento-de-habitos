import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/design_system/tokens/sah_spacing.dart';
import '../../../../core/design_system/widgets/sah_badge.dart';
import '../../../../data/models/user.dart';
import '../../../../l10n/app_localizations.dart';

class UserListItem extends StatelessWidget {
  final User user;
  final String currentUserId;
  final VoidCallback onBlock;
  final VoidCallback onUnblock;
  final VoidCallback onPromote;
  final VoidCallback onDemote;

  const UserListItem({
    super.key,
    required this.user,
    required this.currentUserId,
    required this.onBlock,
    required this.onUnblock,
    required this.onPromote,
    required this.onDemote,
  });

  bool get _isSelf => user.id == currentUserId;

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context)!;
    return Container(
      margin: const EdgeInsets.only(bottom: SahSpacing.x2),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: SahColors.surface,
        borderRadius: BorderRadius.circular(SahRadius.md),
        border: Border.all(color: SahColors.border),
      ),
      child: Row(
        children: [
          _Avatar(nome: user.nome, isBlocked: user.isBlocked, isAdmin: user.isAdmin, isOwner: user.isOwner),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        user.nome,
                        style: TextStyle(
                          fontFamily: 'GeneralSans',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: SahColors.text,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (user.isOwner)
                      SahBadge.accent(l.adminUsersOwnerBadge, size: SahBadgeSize.sm)
                    else if (user.isAdmin)
                      SahBadge.accent(l.adminUsersAdminBadge, size: SahBadgeSize.sm)
                    else if (user.isBlocked)
                      SahBadge.danger(l.adminUsersBlockedBadge, size: SahBadgeSize.sm)
                    else
                      SahBadge.success(l.adminUsersActiveBadge, size: SahBadgeSize.sm),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  user.email,
                  style: GoogleFonts.interTight(
                    fontSize: 12,
                    color: SahColors.textMuted,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          _ActionsMenu(
            user: user,
            isSelf: _isSelf,
            onBlock: onBlock,
            onUnblock: onUnblock,
            onPromote: onPromote,
            onDemote: onDemote,
          ),
        ],
      ),
    );
  }
}

class _ActionsMenu extends StatelessWidget {
  final User user;
  final bool isSelf;
  final VoidCallback onBlock;
  final VoidCallback onUnblock;
  final VoidCallback onPromote;
  final VoidCallback onDemote;

  const _ActionsMenu({
    required this.user,
    required this.isSelf,
    required this.onBlock,
    required this.onUnblock,
    required this.onPromote,
    required this.onDemote,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context)!;
    final items = <PopupMenuEntry<_Action>>[];

    if (!user.isAdmin) {
      if (user.isBlocked) {
        items.add(PopupMenuItem(
          value: _Action.unblock,
          child: _MenuItem(icon: Icons.lock_open_rounded, label: l.adminUsersUnblockButton, color: SahColors.primary),
        ));
      } else {
        items.add(PopupMenuItem(
          value: _Action.block,
          child: _MenuItem(icon: Icons.block_rounded, label: l.adminUsersBlockButton, color: SahColors.danger),
        ));
        items.add(PopupMenuItem(
          value: _Action.promote,
          child: _MenuItem(icon: Icons.shield_rounded, label: l.adminUsersPromoteAdmin, color: SahColors.accent),
        ));
      }
    } else if (!user.isOwner && !isSelf) {
      items.add(PopupMenuItem(
        value: _Action.demote,
        child: _MenuItem(icon: Icons.shield_outlined, label: l.adminUsersRevokeAdmin, color: SahColors.textMuted),
      ));
    }

    if (items.isEmpty) return const SizedBox.shrink();

    return PopupMenuButton<_Action>(
      icon: Icon(Icons.more_vert_rounded, size: 20, color: SahColors.textMuted),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SahRadius.md)),
      onSelected: (action) {
        switch (action) {
          case _Action.block:
            onBlock();
          case _Action.unblock:
            onUnblock();
          case _Action.promote:
            onPromote();
          case _Action.demote:
            onDemote();
        }
      },
      itemBuilder: (_) => items,
    );
  }
}

enum _Action { block, unblock, promote, demote }

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _MenuItem({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 10),
        Text(
          label,
          style: GoogleFonts.interTight(fontSize: 14, color: color),
        ),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  final String nome;
  final bool isBlocked;
  final bool isAdmin;
  final bool isOwner;

  const _Avatar({
    required this.nome,
    required this.isBlocked,
    required this.isAdmin,
    required this.isOwner,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg = isOwner || isAdmin
        ? SahColors.accentFaint
        : isBlocked
            ? SahColors.dangerSoft
            : SahColors.primaryFaint;
    final Color fg = isOwner || isAdmin
        ? SahColors.accent
        : isBlocked
            ? SahColors.danger
            : SahColors.primary;

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Center(
        child: Text(
          nome.isNotEmpty ? nome[0].toUpperCase() : '?',
          style: TextStyle(
            fontFamily: 'GeneralSans',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: fg,
          ),
        ),
      ),
    );
  }
}
