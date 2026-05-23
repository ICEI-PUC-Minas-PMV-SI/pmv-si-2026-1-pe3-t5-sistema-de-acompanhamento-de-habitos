// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppL10nPt extends AppL10n {
  AppL10nPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'SAH';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonSave => 'Salvar';

  @override
  String get commonDelete => 'Excluir';

  @override
  String get commonEdit => 'Editar';

  @override
  String get commonBack => 'Voltar';

  @override
  String get commonOk => 'OK';

  @override
  String get commonNext => 'Próximo';

  @override
  String get commonSkip => 'Pular';

  @override
  String get commonContinue => 'Vamos começar';

  @override
  String get commonRetry => 'Tentar novamente';

  @override
  String get commonLoading => 'Carregando…';

  @override
  String get commonError => 'Algo deu errado.';

  @override
  String get commonRequiredField => 'Campo obrigatório';

  @override
  String get commonClose => 'Fechar';

  @override
  String get commonConfirm => 'Confirmar';

  @override
  String get commonUnderstood => 'Entendi';

  @override
  String get commonNotNow => 'Agora não';

  @override
  String get commonRemove => 'Remover';

  @override
  String get navToday => 'Hoje';

  @override
  String get navHabits => 'Hábitos';

  @override
  String get navHistory => 'Histórico';

  @override
  String get navProfile => 'Perfil';

  @override
  String get navAdminDashboard => 'Dashboard';

  @override
  String get navAdminUsers => 'Usuários';

  @override
  String get navAdminCategories => 'Categorias';

  @override
  String get navAdminLogs => 'Logs';

  @override
  String get authLoginTitle => 'Entre na sua conta';

  @override
  String get authLoginSubtitle => 'Continue sua jornada de hábitos.';

  @override
  String get authEmailLabel => 'E-mail';

  @override
  String get authEmailHint => 'seu@email.com';

  @override
  String get authPasswordLabel => 'Senha';

  @override
  String get authPasswordHint => 'Sua senha';

  @override
  String get authLoginButton => 'Entrar';

  @override
  String get authForgotPassword => 'Esqueci minha senha';

  @override
  String get authNoAccount => 'Não tem conta? ';

  @override
  String get authSignupLink => 'Cadastre-se';

  @override
  String get authSignupTitle => 'Crie sua conta';

  @override
  String get authSignupSubtitle => 'Comece a construir hábitos hoje.';

  @override
  String get authNameLabel => 'Nome';

  @override
  String get authNameHint => 'Seu nome';

  @override
  String get authSignupButton => 'Criar conta';

  @override
  String get authHaveAccount => 'Já tem conta? ';

  @override
  String get authLoginLink => 'Entrar';

  @override
  String get authRecoverTitle => 'Recuperar senha';

  @override
  String get authRecoverSubtitle =>
      'Digite seu e-mail e enviaremos um link para redefinir sua senha.';

  @override
  String get authSendLink => 'Enviar link';

  @override
  String get authBackToLogin => 'Voltar ao login';

  @override
  String get authRecoverSentTitle => 'Link enviado.';

  @override
  String get authRecoverSentBody =>
      'Acesse sua caixa de entrada e clique no link recebido para redefinir sua senha.';

  @override
  String get authHaveCode => 'Tenho meu código';

  @override
  String get authResetTitle => 'Redefinir senha';

  @override
  String get authResetSubtitle =>
      'Cole o código que enviamos por e-mail e escolha uma nova senha.';

  @override
  String get authResetCodeLabel => 'Código de redefinição';

  @override
  String get authNewPassword => 'Nova senha';

  @override
  String get authConfirmPassword => 'Confirmar nova senha';

  @override
  String get authResetButton => 'Redefinir senha';

  @override
  String get authResetSuccess => 'Senha redefinida com sucesso!';

  @override
  String get authResetError => 'Erro ao redefinir senha.';

  @override
  String get authRecoverError => 'Erro ao enviar e-mail.';

  @override
  String todayGreetingMorning(String nome) {
    return 'Bom dia, $nome!';
  }

  @override
  String todayGreetingAfternoon(String nome) {
    return 'Boa tarde, $nome!';
  }

  @override
  String todayGreetingEvening(String nome) {
    return 'Boa noite, $nome!';
  }

  @override
  String get todayHeading => 'Hábitos de hoje';

  @override
  String get todayFreeDay => 'Dia livre!';

  @override
  String get todayFreeDescription =>
      'Nenhum hábito agendado para hoje. Aproveite o descanso ou crie um novo hábito.';

  @override
  String get todayLoadError => 'Erro ao carregar hábitos.';

  @override
  String get todayActionSkipDay => 'Pular hoje';

  @override
  String get todayActionUndoSkip => 'Desfazer pulo';

  @override
  String get todayActionAddNote => 'Adicionar nota';

  @override
  String get todayActionEditNote => 'Editar nota';

  @override
  String get todayNoteDialogTitle => 'Nota do dia';

  @override
  String get todayNoteHint => 'Opcional. Ex: dormi mal, treino curto…';

  @override
  String get todayNoteLabel => 'Como foi?';

  @override
  String get habitsTitle => 'Hábitos';

  @override
  String get habitsNewHabit => 'Novo hábito';

  @override
  String get habitsCreateFromScratch => 'Criar do zero';

  @override
  String get habitsUseTemplate => 'Usar template de rotina';

  @override
  String get habitsShowArchived => 'Mostrar arquivados';

  @override
  String get habitsHideArchived => 'Ocultar arquivados';

  @override
  String get habitsEmptyTitle => 'Comece sua jornada';

  @override
  String get habitsEmptyDescription =>
      'Você ainda não tem hábitos. Crie o primeiro pra acompanhar seu progresso.';

  @override
  String get habitsCreateFirstButton => 'Criar primeiro hábito';

  @override
  String get habitsArchivedEmpty => 'Nenhum hábito arquivado';

  @override
  String get habitsArchivedEmptyDescription =>
      'Quando você arquivar um hábito, ele aparece aqui sem perder o histórico.';

  @override
  String get habitsLoadError => 'Erro ao carregar hábitos.';

  @override
  String get habitsActionEdit => 'Editar';

  @override
  String get habitsActionArchive => 'Arquivar';

  @override
  String get habitsActionUnarchive => 'Desarquivar';

  @override
  String get habitsActionDelete => 'Excluir';

  @override
  String get habitsFreqEveryDay => 'Todos os dias';

  @override
  String get habitsFreqWeekdays => 'Seg – Sex';

  @override
  String habitsFreqTimesPerWeek(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '${count}x por semana',
      one: '1x por semana',
    );
    return '$_temp0';
  }

  @override
  String get habitsDeleteConfirmTitle => 'Excluir hábito?';

  @override
  String get habitsDeleteConfirmBody =>
      'O hábito e todo seu histórico serão permanentemente removidos.';

  @override
  String get habitsArchivedLabel => 'Arquivado';

  @override
  String get habitFormCreate => 'Novo hábito';

  @override
  String get habitFormEdit => 'Editar hábito';

  @override
  String get habitFormName => 'Nome';

  @override
  String get habitFormNameHint => 'Ex: Meditar, Ler, Correr…';

  @override
  String get habitFormDescription => 'Descrição (opcional)';

  @override
  String get habitFormDescriptionHint => 'Detalhes ou motivação';

  @override
  String get habitFormIcon => 'Ícone';

  @override
  String get habitFormCategory => 'Categoria';

  @override
  String get habitFormFrequency => 'Frequência';

  @override
  String get habitFormReminders => 'Lembretes';

  @override
  String get habitFormReminderAdd => 'Adicionar';

  @override
  String get habitFormCreateButton => 'Criar';

  @override
  String get habitFormSaveButton => 'Salvar';

  @override
  String get habitFormNameRequired => 'Informe o nome do hábito';

  @override
  String get habitFormDayRequired => 'Selecione ao menos um dia da semana';

  @override
  String get habitFormCategoryInfoTitle => 'Como funcionam as categorias';

  @override
  String get habitFormCategoryGlobalTitle => 'Globais';

  @override
  String get habitFormCategoryGlobalDescription =>
      'Criadas pelo administrador e disponíveis para todos. Não podem ser editadas.';

  @override
  String get habitFormCategoryMineTitle => 'Minhas';

  @override
  String get habitFormCategoryMineDescription =>
      'Criadas por você, visíveis só para você. Gerencie em Configurações → Gerenciar categorias.';

  @override
  String get historyTitle => 'Histórico';

  @override
  String get historyPeriod7 => '7 dias';

  @override
  String get historyPeriod30 => '30 dias';

  @override
  String get historyPeriod90 => '90 dias';

  @override
  String get historyPeriodAll => 'Tudo';

  @override
  String get historyCheckIns => 'Check-ins';

  @override
  String get historyScheduledDays => 'Dias agendados';

  @override
  String get historyBestStreak => 'Melhor streak';

  @override
  String get historyAdherence => 'Aderência';

  @override
  String historyStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias',
      one: '1 dia',
      zero: '0 dias',
    );
    return '$_temp0';
  }

  @override
  String get historyEmptyTitle => 'Sem registros';

  @override
  String get historyEmptyDescription =>
      'Quando você marcar check-ins, o histórico aparece aqui.';

  @override
  String get historyNoHabitsTitle => 'Comece sua jornada';

  @override
  String get historyNoHabitsDescription =>
      'Você ainda não tem hábitos. Crie o primeiro pra acompanhar seu progresso.';

  @override
  String get historyChartWeeklyTitle => 'Aderência semanal';

  @override
  String get historyChartWeeklySubtitle =>
      '% de dias agendados que você cumpriu por semana';

  @override
  String get historyHeatmapTitle => 'Mapa de hábitos';

  @override
  String get historyHeatmapSubtitle =>
      'Cada quadrado é um dia. Verde = check-in.';

  @override
  String get historyWeekdayTitle => 'Check-ins por dia da semana';

  @override
  String get historyWeekdaySubtitle => 'Em quais dias você é mais consistente.';

  @override
  String get historyInsight => 'Insight';

  @override
  String historyReminderHint(String habit, String time, String current) {
    return 'Você costuma marcar \"$habit\" perto das $time, mas o lembrete está às $current. Quer ajustar?';
  }

  @override
  String historyReminderApply(String time) {
    return 'Ajustar para $time';
  }

  @override
  String historyReminderApplied(String time) {
    return 'Lembrete ajustado para $time';
  }

  @override
  String get historyReminderError => 'Não foi possível ajustar.';

  @override
  String historyCheckInsTooltip(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count check-ins',
      one: '1 check-in',
      zero: '0 check-ins',
    );
    return '$_temp0';
  }

  @override
  String get historyDoneStatus => 'feito';

  @override
  String get historyMissedStatus => 'sem check-in';

  @override
  String get profileEditName => 'Salvar nome';

  @override
  String get profileDataAccount => 'Dados da conta';

  @override
  String get profileNameLabel => 'Nome';

  @override
  String get profileNameUpdated => 'Nome atualizado!';

  @override
  String get profileNameUpdateError => 'Erro ao atualizar nome.';

  @override
  String get profileChangePassword => 'Alterar senha';

  @override
  String get profileChangePasswordButton => 'Alterar senha';

  @override
  String get profileCurrentPassword => 'Senha atual';

  @override
  String get profilePasswordChanged => 'Senha alterada com sucesso!';

  @override
  String get profilePasswordChangeError => 'Erro ao alterar senha.';

  @override
  String get profileNameEmpty => 'O nome não pode ser vazio';

  @override
  String get profileNameMinLength => 'Nome deve ter pelo menos 2 caracteres';

  @override
  String get profileCurrentPasswordRequired => 'Informe a senha atual';

  @override
  String get profileNewPasswordTooShort =>
      'A nova senha deve ter no mínimo 6 caracteres';

  @override
  String get profilePasswordsDoNotMatch => 'As senhas não coincidem';

  @override
  String get profileLogout => 'Sair da conta';

  @override
  String get profileDeleteAccount => 'Excluir minha conta';

  @override
  String get profileDeleteConfirmTitle => 'Excluir minha conta?';

  @override
  String get profileDeleteConfirmBody =>
      'Esta ação é permanente. Todos os seus hábitos, registros e categorias serão removidos. Não pode ser desfeita.';

  @override
  String get profileDeleteConfirmAction => 'Excluir';

  @override
  String get profileDeleteError => 'Falha ao excluir conta.';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsManageCategories => 'Gerenciar categorias';

  @override
  String get settingsManageCategoriesSubtitle => 'Crie e edite suas próprias';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeAppTitle => 'Tema do aplicativo';

  @override
  String get settingsThemeLight => 'Sempre claro';

  @override
  String get settingsThemeDark => 'Sempre escuro';

  @override
  String get settingsThemeSystem => 'Sistema';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageAppTitle => 'Idioma do aplicativo';

  @override
  String get settingsLanguagePortuguese => 'Português';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageSpanish => 'Español';

  @override
  String get settingsBackup => 'Backup e dados';

  @override
  String get settingsBackupSubtitle => 'Exportar e importar';

  @override
  String get settingsTestNotification => 'Testar notificação';

  @override
  String get settingsTestNotificationSubtitle =>
      'Dispara uma notificação agora';

  @override
  String get settingsEmailIntegration => 'Integração de e-mail';

  @override
  String get settingsEmailConfigured => 'Mailtrap configurado';

  @override
  String get settingsEmailNotConfigured => 'Não configurado';

  @override
  String get settingsMailtrapTitle => 'Integração de e-mail';

  @override
  String get settingsMailtrapSubtitle => 'Credenciais do Mailtrap Sandbox';

  @override
  String get settingsMailtrapToken => 'API Token';

  @override
  String get settingsMailtrapTokenHint => 'Token de API do Mailtrap';

  @override
  String get settingsMailtrapInbox => 'Inbox ID';

  @override
  String get settingsMailtrapInboxHint => 'ID da inbox no Mailtrap';

  @override
  String get settingsMailtrapFromEmail => 'E-mail do remetente';

  @override
  String get settingsMailtrapFromEmailHint => 'ex: noreply@sah.app';

  @override
  String get settingsMailtrapFromName => 'Nome do remetente';

  @override
  String get settingsMailtrapFromNameHint => 'ex: Equipe SAH';

  @override
  String get settingsMailtrapFillAll => 'Preencha todos os campos.';

  @override
  String get settingsMailtrapSaved => 'Mailtrap configurado!';

  @override
  String get settingsMailtrapClear => 'Limpar configuração';

  @override
  String get backupTitle => 'Backup e dados';

  @override
  String get backupSubtitle => 'Mantenha seus dados seguros';

  @override
  String get backupExportTitle => 'Exportar dados';

  @override
  String get backupExportDescription =>
      'Gera um arquivo JSON com seus hábitos, registros e categorias.';

  @override
  String get backupExportNow => 'Exportar agora';

  @override
  String get backupExportError => 'Falha ao exportar.';

  @override
  String backupExportShareError(String message) {
    return 'Erro ao compartilhar: $message';
  }

  @override
  String get backupImportTitle => 'Importar backup';

  @override
  String get backupImportDescription =>
      'Substitui seus dados pelos do arquivo. Ação destrutiva.';

  @override
  String get backupImportSelect => 'Selecionar arquivo';

  @override
  String get backupImportConfirmTitle => 'Importar backup?';

  @override
  String get backupImportConfirmBody =>
      'Todos os seus hábitos, registros e categorias atuais serão substituídos pelos do arquivo. Esta ação não pode ser desfeita.';

  @override
  String get backupImportInvalid => 'Arquivo inválido.';

  @override
  String get backupImportSuccess => 'Backup importado com sucesso!';

  @override
  String backupImportReadError(String message) {
    return 'Erro ao ler arquivo: $message';
  }

  @override
  String get backupAutoTitle => 'Backup automático';

  @override
  String backupAutoLast(String when) {
    return 'Último: $when';
  }

  @override
  String get backupAutoNever => 'Nunca';

  @override
  String get onboardingWelcomeTitle => 'Bem-vindo ao SAH';

  @override
  String get onboardingWelcomeDescription =>
      'O lugar para criar, lembrar e celebrar seus hábitos. Comece pequeno, mantenha consistência.';

  @override
  String get onboardingRemindersTitle => 'Lembretes que cabem na sua rotina';

  @override
  String get onboardingRemindersDescription =>
      'Defina quantos horários quiser para cada hábito. As notificações tocam só nos dias que você escolher.';

  @override
  String get onboardingProgressTitle => 'Veja sua evolução';

  @override
  String get onboardingProgressDescription =>
      'Streaks, aderência e histórico — tudo no app, salvo só no seu dispositivo.';

  @override
  String onboardingSuggestionsTitle(String nome) {
    return 'Bem-vindo, $nome!';
  }

  @override
  String get onboardingSuggestionsTitleFallback => 'Bem-vindo!';

  @override
  String get onboardingSuggestionsSubtitle =>
      'Escolha os hábitos que combinam com você. Você pode ajustar tudo depois.';

  @override
  String onboardingStartButton(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Começar com $count hábitos',
      one: 'Começar com 1 hábito',
      zero: 'Selecione ao menos um hábito',
    );
    return '$_temp0';
  }

  @override
  String onboardingFailedHabits(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hábitos falharam ao criar.',
      one: '1 hábito falhou ao criar.',
    );
    return '$_temp0';
  }

  @override
  String get onboardingHintTitle => 'Comece com sugestões';

  @override
  String get onboardingHintBody =>
      'Você ainda não tem hábitos. Escolha alguns para começar — leva menos de um minuto.';

  @override
  String get onboardingHintAction => 'Ver sugestões';

  @override
  String get templatesTitle => 'Templates de rotina';

  @override
  String get templatesSubtitle =>
      'Crie vários hábitos de uma vez. Você pode editar tudo depois.';

  @override
  String templatesAppliedSuccess(int count) {
    return 'Template aplicado: $count hábitos criados!';
  }

  @override
  String templatesAppliedPartial(int created, int failed) {
    return 'Criados $created, $failed falharam.';
  }

  @override
  String templatesCount(int count, String description) {
    return '$count hábitos · $description';
  }

  @override
  String get categoriesEmptyTitle => 'Nenhuma categoria';

  @override
  String get categoriesEmptyDescription =>
      'Crie sua primeira categoria para organizar seus hábitos.';

  @override
  String get categoriesNewCategory => 'Nova categoria';

  @override
  String get categoriesNameLabel => 'Nome';

  @override
  String get categoriesNameHint => 'Ex: Saúde, Trabalho…';

  @override
  String get categoriesColorLabel => 'Cor';

  @override
  String get categoriesGlobalLabel => 'Global';

  @override
  String get categoriesGlobalDescription => 'Disponível para todos os usuários';

  @override
  String get categoriesEditCategory => 'Editar categoria';

  @override
  String get categoriesDeleteConfirmTitle => 'Excluir categoria?';

  @override
  String get categoriesDeleteConfirmBody =>
      'A categoria será removida. Hábitos vinculados ficarão sem categoria.';

  @override
  String get categoriesDeleteError => 'Não foi possível excluir.';

  @override
  String get categoriesCreated => 'Categoria criada!';

  @override
  String get categoriesUpdated => 'Categoria atualizada!';

  @override
  String get categoriesDeleted => 'Categoria excluída!';

  @override
  String get adminDashboardTitle => 'Dashboard';

  @override
  String get adminDashboardSubtitle => 'Visão geral da plataforma';

  @override
  String get adminDashboardTotalUsers => 'Total de usuários';

  @override
  String get adminDashboardActiveUsers => 'Usuários ativos';

  @override
  String get adminDashboardBlockedUsers => 'Bloqueados';

  @override
  String get adminDashboardTotalHabits => 'Total de hábitos';

  @override
  String get adminDashboardAvgAdherence => 'Aderência média';

  @override
  String get adminDashboardAvgStreak => 'Streak médio (dias)';

  @override
  String get adminDashboardQuickAccess => 'Acesso rápido';

  @override
  String get adminUsersTitle => 'Usuários';

  @override
  String get adminUsersSearchHint => 'Buscar por nome ou e-mail';

  @override
  String get adminUsersFilterAll => 'Todos';

  @override
  String get adminUsersFilterActive => 'Ativos';

  @override
  String get adminUsersFilterBlocked => 'Bloqueados';

  @override
  String get adminUsersBlockButton => 'Bloquear';

  @override
  String get adminUsersUnblockButton => 'Desbloquear';

  @override
  String get adminUsersPromoteAdmin => 'Tornar admin';

  @override
  String get adminUsersRevokeAdmin => 'Remover admin';

  @override
  String get adminUsersOwnerBadge => 'Owner';

  @override
  String get adminUsersAdminBadge => 'Admin';

  @override
  String get adminUsersBlockedBadge => 'Bloqueado';

  @override
  String get adminUsersActiveBadge => 'Ativo';

  @override
  String get adminUsersBlockReasonLabel => 'Motivo do bloqueio';

  @override
  String get adminUsersBlockReasonHint => 'Ex: spam, abuso, conta inativa…';

  @override
  String get adminUsersConfirmBlock => 'Bloquear usuário';

  @override
  String adminUsersBlockModalSubtitle(String nome) {
    return 'A conta de $nome ficará inacessível até ser desbloqueada.';
  }

  @override
  String get adminUsersBlockReasonRequired => 'Informe o motivo do bloqueio';

  @override
  String get adminUsersLoadError => 'Erro ao carregar usuários';

  @override
  String get adminUsersEmptyTitle => 'Nenhum usuário encontrado';

  @override
  String get adminUsersEmptyDescription =>
      'Tente ajustar os filtros ou o termo de busca.';

  @override
  String get adminUsersDemoteTitle => 'Remover admin?';

  @override
  String adminUsersDemoteBody(String nome) {
    return '$nome perderá acesso ao painel administrativo.';
  }

  @override
  String get adminCategoriesTitle => 'Categorias globais';

  @override
  String get adminCategoriesShortTitle => 'Categorias';

  @override
  String get adminCategoriesSubtitle => 'Disponíveis para todos os usuários';

  @override
  String get adminCategoriesNewButton => 'Nova';

  @override
  String get adminCategoriesLoadError => 'Erro ao carregar categorias';

  @override
  String get adminCategoriesEmptyTitle => 'Nenhuma categoria';

  @override
  String get adminCategoriesEmptyDescription =>
      'Crie a primeira categoria global para os usuários.';

  @override
  String get adminCategoriesCreateButton => 'Criar categoria';

  @override
  String get adminCategoriesInUseTitle => 'Categoria em uso';

  @override
  String adminCategoriesInUseBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Esta categoria está vinculada a $count hábitos. Deseja excluir mesmo assim?',
      one:
          'Esta categoria está vinculada a 1 hábito. Deseja excluir mesmo assim?',
    );
    return '$_temp0';
  }

  @override
  String get adminCategoriesForceDelete => 'Excluir assim mesmo';

  @override
  String get adminCategoriesDeleteTitle => 'Excluir categoria?';

  @override
  String get adminCategoriesDeleteBody => 'Esta ação não pode ser desfeita.';

  @override
  String get adminCategoriesFormEditTitle => 'Editar categoria';

  @override
  String get adminCategoriesFormNewTitle => 'Nova categoria';

  @override
  String get adminCategoriesFormNameLabel => 'Nome';

  @override
  String get adminCategoriesFormNameHint => 'Ex: Exercício, Leitura…';

  @override
  String get adminCategoriesFormNameRequired => 'Informe o nome da categoria';

  @override
  String get adminCategoriesFormColorLabel => 'Cor';

  @override
  String get adminCategoriesFormCreate => 'Criar';

  @override
  String get adminCategoriesGlobalBadge => 'Global';

  @override
  String adminCategoriesHabitCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hábitos',
      one: '1 hábito',
      zero: '0 hábitos',
    );
    return '$_temp0';
  }

  @override
  String get userCategoriesTitle => 'Minhas categorias';

  @override
  String get userCategoriesYourSection => 'Suas categorias';

  @override
  String get userCategoriesGlobalsSection => 'Globais';

  @override
  String get userCategoriesGlobalsHint =>
      'Disponíveis para todos — somente leitura.';

  @override
  String get userCategoriesEmptyTitle => 'Nenhuma categoria pessoal';

  @override
  String get userCategoriesEmptyDescription =>
      'Crie categorias próprias para organizar seus hábitos.';

  @override
  String get userCategoriesCreateFirst => 'Criar primeira';

  @override
  String get errorScreenTitle => 'Algo deu errado.';

  @override
  String get errorScreenDescription =>
      'Não foi possível carregar esta página. Tente novamente.';

  @override
  String errorScreenRef(String code) {
    return 'Ref: $code';
  }

  @override
  String get errorScreenGoHome => 'Ir para o início';

  @override
  String get adminLogsTitle => 'Logs do sistema';

  @override
  String get adminLogsEmpty => 'Nenhum log encontrado';

  @override
  String get adminLogsEmptyFiltered =>
      'Nenhum evento deste tipo foi registrado. Limpe os filtros para ver todos.';

  @override
  String get adminLogsEmptyAll => 'Nenhum evento registrado ainda.';

  @override
  String get adminLogsFilterAll => 'Todos';

  @override
  String get adminLogsFilterLogin => 'Login';

  @override
  String get adminLogsFilterSignup => 'Cadastro';

  @override
  String get adminLogsFilterBlock => 'Bloqueio';

  @override
  String get adminLogsFilterAdmin => 'Admin';

  @override
  String get adminLogsFilterError => 'Erros';

  @override
  String get adminLogsTypeLogin => 'Login';

  @override
  String get adminLogsTypeLogout => 'Logout';

  @override
  String get adminLogsTypeSignup => 'Cadastro';

  @override
  String get adminLogsTypeBlock => 'Bloqueio';

  @override
  String get adminLogsTypeUnblock => 'Desbloqueio';

  @override
  String get adminLogsTypeError => 'Erro';

  @override
  String get adminLogsTypeAdmin => 'Admin';

  @override
  String get adminLogsTypeProfile => 'Perfil';

  @override
  String get adminLogsTypePassword => 'Senha';

  @override
  String get adminLogsTypeReset => 'Reset';

  @override
  String get adminLogsTypeAccountDeleted => 'Exclusão';

  @override
  String get adminLogsTypeBackup => 'Backup';

  @override
  String get tooltipBack => 'Voltar';

  @override
  String get tooltipSettings => 'Configurações';

  @override
  String get tooltipOpenMenu => 'Abrir menu';

  @override
  String get tooltipLogout => 'Sair';

  @override
  String get testNotificationTitle => 'Teste de lembrete';

  @override
  String get testNotificationBody =>
      'Se você está vendo isso, as notificações estão funcionando!';

  @override
  String get permissionDenied =>
      'Permissão de notificação negada. Ative nas configurações do sistema.';

  @override
  String get logoutDialogTitle => 'Sair?';

  @override
  String get logoutDialogBody => 'Deseja encerrar a sessão?';

  @override
  String get logoutDialogConfirm => 'Sair';

  @override
  String get onboardingSuggDrinkWater => 'Beber 2L de água';

  @override
  String get onboardingSuggVitamin => 'Tomar vitamina';

  @override
  String get onboardingSuggSleep8h => 'Dormir 8 horas';

  @override
  String get onboardingSuggGratitude => 'Anotar 3 gratidões';

  @override
  String get onboardingSuggOffline15 => '15min offline';

  @override
  String get onboardingSuggWalkOutdoor => 'Caminhar ao ar livre';

  @override
  String get onboardingSuggPlanDay => 'Planejar o dia';

  @override
  String get onboardingSuggReviewAgenda => 'Revisar agenda';

  @override
  String get onboardingSuggInboxZero => 'Inbox zero';

  @override
  String get onboardingSuggTrain30 => 'Treinar 30min';

  @override
  String get onboardingSuggStretchBeforeSleep => 'Alongar antes de dormir';

  @override
  String get onboardingSuggStairs => 'Subir escadas';

  @override
  String get onboardingSuggRead20Pages => 'Ler 20 páginas';

  @override
  String get onboardingSuggReadBeforeSleep => 'Ler antes de dormir';

  @override
  String get onboardingSuggLearnNewWord => 'Aprender palavra nova';

  @override
  String get onboardingSuggMeditate10 => 'Meditar 10min';

  @override
  String get onboardingSuggConsciousBreathing => 'Respiração consciente 5min';

  @override
  String get onboardingSuggMindfulnessLunch => 'Mindfulness pós-almoço';

  @override
  String get templateMorningName => 'Rotina matinal';

  @override
  String get templateMorningDesc => 'Comece o dia com 4 hábitos curtos.';

  @override
  String get templateStudentName => 'Estudante';

  @override
  String get templateStudentDesc => 'Rotina balanceada de estudo e descanso.';

  @override
  String get templateHealthyName => 'Vida saudável';

  @override
  String get templateHealthyDesc => 'Foco em corpo e mente.';

  @override
  String get templateRemoteName => 'Trabalho remoto';

  @override
  String get templateRemoteDesc => 'Mantém foco e energia trabalhando de casa.';

  @override
  String get templateHabitMorningWater => 'Beber um copo de água';

  @override
  String get templateHabitMorningMeditate => 'Meditar 10min';

  @override
  String get templateHabitMorningStretch => 'Alongar';

  @override
  String get templateHabitMorningPlan => 'Planejar o dia';

  @override
  String get templateHabitStudentRead => 'Ler 20 páginas';

  @override
  String get templateHabitStudentReview => 'Revisar agenda';

  @override
  String get templateHabitStudentLearn => 'Aprender palavra nova';

  @override
  String get templateHabitStudentPomodoro => 'Pomodoro 25min';

  @override
  String get templateHabitHealthyWater => 'Beber 2L de água';

  @override
  String get templateHabitHealthyWalk => 'Caminhar 30min';

  @override
  String get templateHabitHealthyGratitude => 'Anotar 3 gratidões';

  @override
  String get templateHabitHealthySleep => 'Dormir 8 horas';

  @override
  String get templateHabitRemoteInbox => 'Inbox zero pela manhã';

  @override
  String get templateHabitRemoteBreak => 'Pausa de 5min a cada hora';

  @override
  String get templateHabitRemoteNeck => 'Alongar pescoço';

  @override
  String get templateHabitRemoteCoffee => 'Café com calma';
}
