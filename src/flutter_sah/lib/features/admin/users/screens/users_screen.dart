import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/design_system/tokens/sah_colors.dart';
import '../../../../core/design_system/tokens/sah_radius.dart';
import '../../../../core/design_system/tokens/sah_spacing.dart';
import '../../../../core/design_system/widgets/sah_empty_state.dart';
import '../../../../core/design_system/widgets/sah_search_field.dart';
import '../../../../core/design_system/widgets/sah_spinner.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../controllers/users_controller.dart';
import '../widgets/block_user_modal.dart';
import '../widgets/user_list_item.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => UsersController(ctx.read<UserRepository>()),
      child: const _UsersContent(),
    );
  }
}

class _UsersContent extends StatelessWidget {
  const _UsersContent();

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<UsersController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            SahSpacing.pagePadding,
            SahSpacing.pagePadding,
            SahSpacing.pagePadding,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Usuários',
                style: TextStyle(
                  fontFamily: 'GeneralSans',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: SahColors.text,
                  letterSpacing: -0.44,
                ),
              ),
              const SizedBox(height: 12),
              SahSearchField(
                hint: 'Buscar por nome ou e-mail…',
                onChanged: ctrl.setQuery,
              ),
              const SizedBox(height: 10),
              _FilterBar(current: ctrl.filter, onChanged: ctrl.setFilter),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: _buildBody(context, ctrl),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, UsersController ctrl) {
    if (ctrl.status == UsersStatus.loading) {
      return const Center(child: SahSpinner(size: 28));
    }
    if (ctrl.status == UsersStatus.error) {
      return Center(
        child: Text(
          ctrl.error ?? 'Erro ao carregar usuários',
          style: GoogleFonts.interTight(fontSize: 14, color: SahColors.textMuted),
        ),
      );
    }
    if (ctrl.users.isEmpty) {
      return const SahEmptyState(
        title: 'Nenhum usuário encontrado',
        description: 'Tente ajustar os filtros ou o termo de busca.',
      );
    }

    final currentUserId = context.read<AuthController>().currentUser?.id ?? '';

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: SahSpacing.pagePadding),
      itemCount: ctrl.users.length,
      itemBuilder: (ctx, i) {
        final user = ctrl.users[i];
        return UserListItem(
          user: user,
          currentUserId: currentUserId,
          onBlock: () async {
            final motivo = await showBlockUserModal(context, user);
            if (motivo != null) await ctrl.block(user.id, motivo: motivo);
          },
          onUnblock: () => ctrl.unblock(user.id),
          onPromote: () => ctrl.setAdmin(user.id, isAdmin: true),
          onDemote: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => AlertDialog(
                backgroundColor: SahColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SahRadius.lg),
                ),
                title: Text(
                  'Remover admin?',
                  style: TextStyle(
                    fontFamily: 'GeneralSans',
                    fontSize: 18,
                    color: SahColors.text,
                  ),
                ),
                content: Text(
                  '${user.nome} perderá acesso ao painel administrativo.',
                  style: GoogleFonts.interTight(
                    fontSize: 14,
                    color: SahColors.textMuted,
                    height: 1.5,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text('Cancelar', style: GoogleFonts.interTight(color: SahColors.textMuted)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text('Remover', style: GoogleFonts.interTight(color: SahColors.danger)),
                  ),
                ],
              ),
            );
            if (confirm == true && context.mounted) {
              await ctrl.setAdmin(user.id, isAdmin: false);
            }
          },
        );
      },
    );
  }
}

class _FilterBar extends StatelessWidget {
  final UserStatusFilter current;
  final void Function(UserStatusFilter) onChanged;

  const _FilterBar({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final options = [
      (label: 'Todos', value: UserStatusFilter.all),
      (label: 'Ativos', value: UserStatusFilter.active),
      (label: 'Bloqueados', value: UserStatusFilter.blocked),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: options.map((o) {
          final selected = current == o.value;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => onChanged(o.value),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: selected ? SahColors.primary : SahColors.surface,
                  borderRadius: BorderRadius.circular(SahRadius.full),
                  border: Border.all(
                    color: selected ? SahColors.primary : SahColors.border,
                  ),
                ),
                child: Text(
                  o.label,
                  style: GoogleFonts.interTight(
                    fontSize: 13,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    color: selected ? Colors.white : SahColors.textMuted,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
