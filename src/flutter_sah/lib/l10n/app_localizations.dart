import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppL10n
/// returned by `AppL10n.of(context)`.
///
/// Applications need to include `AppL10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppL10n.localizationsDelegates,
///   supportedLocales: AppL10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppL10n.supportedLocales
/// property.
abstract class AppL10n {
  AppL10n(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppL10n? of(BuildContext context) {
    return Localizations.of<AppL10n>(context, AppL10n);
  }

  static const LocalizationsDelegate<AppL10n> delegate = _AppL10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('pt'),
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @appName.
  ///
  /// In pt, this message translates to:
  /// **'SAH'**
  String get appName;

  /// No description provided for @commonCancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In pt, this message translates to:
  /// **'Salvar'**
  String get commonSave;

  /// No description provided for @commonDelete.
  ///
  /// In pt, this message translates to:
  /// **'Excluir'**
  String get commonDelete;

  /// No description provided for @commonEdit.
  ///
  /// In pt, this message translates to:
  /// **'Editar'**
  String get commonEdit;

  /// No description provided for @commonBack.
  ///
  /// In pt, this message translates to:
  /// **'Voltar'**
  String get commonBack;

  /// No description provided for @commonOk.
  ///
  /// In pt, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonNext.
  ///
  /// In pt, this message translates to:
  /// **'Próximo'**
  String get commonNext;

  /// No description provided for @commonSkip.
  ///
  /// In pt, this message translates to:
  /// **'Pular'**
  String get commonSkip;

  /// No description provided for @commonContinue.
  ///
  /// In pt, this message translates to:
  /// **'Vamos começar'**
  String get commonContinue;

  /// No description provided for @commonRetry.
  ///
  /// In pt, this message translates to:
  /// **'Tentar novamente'**
  String get commonRetry;

  /// No description provided for @commonLoading.
  ///
  /// In pt, this message translates to:
  /// **'Carregando…'**
  String get commonLoading;

  /// No description provided for @commonError.
  ///
  /// In pt, this message translates to:
  /// **'Algo deu errado.'**
  String get commonError;

  /// No description provided for @commonRequiredField.
  ///
  /// In pt, this message translates to:
  /// **'Campo obrigatório'**
  String get commonRequiredField;

  /// No description provided for @commonClose.
  ///
  /// In pt, this message translates to:
  /// **'Fechar'**
  String get commonClose;

  /// No description provided for @commonConfirm.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar'**
  String get commonConfirm;

  /// No description provided for @commonUnderstood.
  ///
  /// In pt, this message translates to:
  /// **'Entendi'**
  String get commonUnderstood;

  /// No description provided for @commonNotNow.
  ///
  /// In pt, this message translates to:
  /// **'Agora não'**
  String get commonNotNow;

  /// No description provided for @commonRemove.
  ///
  /// In pt, this message translates to:
  /// **'Remover'**
  String get commonRemove;

  /// No description provided for @navToday.
  ///
  /// In pt, this message translates to:
  /// **'Hoje'**
  String get navToday;

  /// No description provided for @navHabits.
  ///
  /// In pt, this message translates to:
  /// **'Hábitos'**
  String get navHabits;

  /// No description provided for @navHistory.
  ///
  /// In pt, this message translates to:
  /// **'Histórico'**
  String get navHistory;

  /// No description provided for @navProfile.
  ///
  /// In pt, this message translates to:
  /// **'Perfil'**
  String get navProfile;

  /// No description provided for @navAdminDashboard.
  ///
  /// In pt, this message translates to:
  /// **'Dashboard'**
  String get navAdminDashboard;

  /// No description provided for @navAdminUsers.
  ///
  /// In pt, this message translates to:
  /// **'Usuários'**
  String get navAdminUsers;

  /// No description provided for @navAdminCategories.
  ///
  /// In pt, this message translates to:
  /// **'Categorias'**
  String get navAdminCategories;

  /// No description provided for @navAdminLogs.
  ///
  /// In pt, this message translates to:
  /// **'Logs'**
  String get navAdminLogs;

  /// No description provided for @authLoginTitle.
  ///
  /// In pt, this message translates to:
  /// **'Entre na sua conta'**
  String get authLoginTitle;

  /// No description provided for @authLoginSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Continue sua jornada de hábitos.'**
  String get authLoginSubtitle;

  /// No description provided for @authEmailLabel.
  ///
  /// In pt, this message translates to:
  /// **'E-mail'**
  String get authEmailLabel;

  /// No description provided for @authEmailHint.
  ///
  /// In pt, this message translates to:
  /// **'seu@email.com'**
  String get authEmailHint;

  /// No description provided for @authPasswordLabel.
  ///
  /// In pt, this message translates to:
  /// **'Senha'**
  String get authPasswordLabel;

  /// No description provided for @authPasswordHint.
  ///
  /// In pt, this message translates to:
  /// **'Sua senha'**
  String get authPasswordHint;

  /// No description provided for @authLoginButton.
  ///
  /// In pt, this message translates to:
  /// **'Entrar'**
  String get authLoginButton;

  /// No description provided for @authForgotPassword.
  ///
  /// In pt, this message translates to:
  /// **'Esqueci minha senha'**
  String get authForgotPassword;

  /// No description provided for @authNoAccount.
  ///
  /// In pt, this message translates to:
  /// **'Não tem conta? '**
  String get authNoAccount;

  /// No description provided for @authSignupLink.
  ///
  /// In pt, this message translates to:
  /// **'Cadastre-se'**
  String get authSignupLink;

  /// No description provided for @authSignupTitle.
  ///
  /// In pt, this message translates to:
  /// **'Crie sua conta'**
  String get authSignupTitle;

  /// No description provided for @authSignupSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Comece a construir hábitos hoje.'**
  String get authSignupSubtitle;

  /// No description provided for @authNameLabel.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get authNameLabel;

  /// No description provided for @authNameHint.
  ///
  /// In pt, this message translates to:
  /// **'Seu nome'**
  String get authNameHint;

  /// No description provided for @authSignupButton.
  ///
  /// In pt, this message translates to:
  /// **'Criar conta'**
  String get authSignupButton;

  /// No description provided for @authHaveAccount.
  ///
  /// In pt, this message translates to:
  /// **'Já tem conta? '**
  String get authHaveAccount;

  /// No description provided for @authLoginLink.
  ///
  /// In pt, this message translates to:
  /// **'Entrar'**
  String get authLoginLink;

  /// No description provided for @authRecoverTitle.
  ///
  /// In pt, this message translates to:
  /// **'Recuperar senha'**
  String get authRecoverTitle;

  /// No description provided for @authRecoverSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Digite seu e-mail e enviaremos um link para redefinir sua senha.'**
  String get authRecoverSubtitle;

  /// No description provided for @authSendLink.
  ///
  /// In pt, this message translates to:
  /// **'Enviar link'**
  String get authSendLink;

  /// No description provided for @authBackToLogin.
  ///
  /// In pt, this message translates to:
  /// **'Voltar ao login'**
  String get authBackToLogin;

  /// No description provided for @authRecoverSentTitle.
  ///
  /// In pt, this message translates to:
  /// **'Link enviado.'**
  String get authRecoverSentTitle;

  /// No description provided for @authRecoverSentBody.
  ///
  /// In pt, this message translates to:
  /// **'Acesse sua caixa de entrada e clique no link recebido para redefinir sua senha.'**
  String get authRecoverSentBody;

  /// No description provided for @authHaveCode.
  ///
  /// In pt, this message translates to:
  /// **'Tenho meu código'**
  String get authHaveCode;

  /// No description provided for @authResetTitle.
  ///
  /// In pt, this message translates to:
  /// **'Redefinir senha'**
  String get authResetTitle;

  /// No description provided for @authResetSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Cole o código que enviamos por e-mail e escolha uma nova senha.'**
  String get authResetSubtitle;

  /// No description provided for @authResetCodeLabel.
  ///
  /// In pt, this message translates to:
  /// **'Código de redefinição'**
  String get authResetCodeLabel;

  /// No description provided for @authNewPassword.
  ///
  /// In pt, this message translates to:
  /// **'Nova senha'**
  String get authNewPassword;

  /// No description provided for @authConfirmPassword.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar nova senha'**
  String get authConfirmPassword;

  /// No description provided for @authResetButton.
  ///
  /// In pt, this message translates to:
  /// **'Redefinir senha'**
  String get authResetButton;

  /// No description provided for @authResetSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Senha redefinida com sucesso!'**
  String get authResetSuccess;

  /// No description provided for @authResetError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao redefinir senha.'**
  String get authResetError;

  /// No description provided for @authRecoverError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao enviar e-mail.'**
  String get authRecoverError;

  /// No description provided for @todayGreetingMorning.
  ///
  /// In pt, this message translates to:
  /// **'Bom dia, {nome}!'**
  String todayGreetingMorning(String nome);

  /// No description provided for @todayGreetingAfternoon.
  ///
  /// In pt, this message translates to:
  /// **'Boa tarde, {nome}!'**
  String todayGreetingAfternoon(String nome);

  /// No description provided for @todayGreetingEvening.
  ///
  /// In pt, this message translates to:
  /// **'Boa noite, {nome}!'**
  String todayGreetingEvening(String nome);

  /// No description provided for @todayHeading.
  ///
  /// In pt, this message translates to:
  /// **'Hábitos de hoje'**
  String get todayHeading;

  /// No description provided for @todayFreeDay.
  ///
  /// In pt, this message translates to:
  /// **'Dia livre!'**
  String get todayFreeDay;

  /// No description provided for @todayFreeDescription.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum hábito agendado para hoje. Aproveite o descanso ou crie um novo hábito.'**
  String get todayFreeDescription;

  /// No description provided for @todayLoadError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar hábitos.'**
  String get todayLoadError;

  /// No description provided for @todayActionSkipDay.
  ///
  /// In pt, this message translates to:
  /// **'Pular hoje'**
  String get todayActionSkipDay;

  /// No description provided for @todayActionUndoSkip.
  ///
  /// In pt, this message translates to:
  /// **'Desfazer pulo'**
  String get todayActionUndoSkip;

  /// No description provided for @todayActionAddNote.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar nota'**
  String get todayActionAddNote;

  /// No description provided for @todayActionEditNote.
  ///
  /// In pt, this message translates to:
  /// **'Editar nota'**
  String get todayActionEditNote;

  /// No description provided for @todayNoteDialogTitle.
  ///
  /// In pt, this message translates to:
  /// **'Nota do dia'**
  String get todayNoteDialogTitle;

  /// No description provided for @todayNoteHint.
  ///
  /// In pt, this message translates to:
  /// **'Opcional. Ex: dormi mal, treino curto…'**
  String get todayNoteHint;

  /// No description provided for @todayNoteLabel.
  ///
  /// In pt, this message translates to:
  /// **'Como foi?'**
  String get todayNoteLabel;

  /// No description provided for @habitsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Hábitos'**
  String get habitsTitle;

  /// No description provided for @habitsNewHabit.
  ///
  /// In pt, this message translates to:
  /// **'Novo hábito'**
  String get habitsNewHabit;

  /// No description provided for @habitsCreateFromScratch.
  ///
  /// In pt, this message translates to:
  /// **'Criar do zero'**
  String get habitsCreateFromScratch;

  /// No description provided for @habitsUseTemplate.
  ///
  /// In pt, this message translates to:
  /// **'Usar template de rotina'**
  String get habitsUseTemplate;

  /// No description provided for @habitsShowArchived.
  ///
  /// In pt, this message translates to:
  /// **'Mostrar arquivados'**
  String get habitsShowArchived;

  /// No description provided for @habitsHideArchived.
  ///
  /// In pt, this message translates to:
  /// **'Ocultar arquivados'**
  String get habitsHideArchived;

  /// No description provided for @habitsEmptyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Comece sua jornada'**
  String get habitsEmptyTitle;

  /// No description provided for @habitsEmptyDescription.
  ///
  /// In pt, this message translates to:
  /// **'Você ainda não tem hábitos. Crie o primeiro pra acompanhar seu progresso.'**
  String get habitsEmptyDescription;

  /// No description provided for @habitsCreateFirstButton.
  ///
  /// In pt, this message translates to:
  /// **'Criar primeiro hábito'**
  String get habitsCreateFirstButton;

  /// No description provided for @habitsArchivedEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum hábito arquivado'**
  String get habitsArchivedEmpty;

  /// No description provided for @habitsArchivedEmptyDescription.
  ///
  /// In pt, this message translates to:
  /// **'Quando você arquivar um hábito, ele aparece aqui sem perder o histórico.'**
  String get habitsArchivedEmptyDescription;

  /// No description provided for @habitsLoadError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar hábitos.'**
  String get habitsLoadError;

  /// No description provided for @habitsActionEdit.
  ///
  /// In pt, this message translates to:
  /// **'Editar'**
  String get habitsActionEdit;

  /// No description provided for @habitsActionArchive.
  ///
  /// In pt, this message translates to:
  /// **'Arquivar'**
  String get habitsActionArchive;

  /// No description provided for @habitsActionUnarchive.
  ///
  /// In pt, this message translates to:
  /// **'Desarquivar'**
  String get habitsActionUnarchive;

  /// No description provided for @habitsActionDelete.
  ///
  /// In pt, this message translates to:
  /// **'Excluir'**
  String get habitsActionDelete;

  /// No description provided for @habitsFreqEveryDay.
  ///
  /// In pt, this message translates to:
  /// **'Todos os dias'**
  String get habitsFreqEveryDay;

  /// No description provided for @habitsFreqWeekdays.
  ///
  /// In pt, this message translates to:
  /// **'Seg – Sex'**
  String get habitsFreqWeekdays;

  /// No description provided for @habitsFreqTimesPerWeek.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{1x por semana} other{{count}x por semana}}'**
  String habitsFreqTimesPerWeek(int count);

  /// No description provided for @habitsDeleteConfirmTitle.
  ///
  /// In pt, this message translates to:
  /// **'Excluir hábito?'**
  String get habitsDeleteConfirmTitle;

  /// No description provided for @habitsDeleteConfirmBody.
  ///
  /// In pt, this message translates to:
  /// **'O hábito e todo seu histórico serão permanentemente removidos.'**
  String get habitsDeleteConfirmBody;

  /// No description provided for @habitsArchivedLabel.
  ///
  /// In pt, this message translates to:
  /// **'Arquivado'**
  String get habitsArchivedLabel;

  /// No description provided for @habitFormCreate.
  ///
  /// In pt, this message translates to:
  /// **'Novo hábito'**
  String get habitFormCreate;

  /// No description provided for @habitFormEdit.
  ///
  /// In pt, this message translates to:
  /// **'Editar hábito'**
  String get habitFormEdit;

  /// No description provided for @habitFormName.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get habitFormName;

  /// No description provided for @habitFormNameHint.
  ///
  /// In pt, this message translates to:
  /// **'Ex: Meditar, Ler, Correr…'**
  String get habitFormNameHint;

  /// No description provided for @habitFormDescription.
  ///
  /// In pt, this message translates to:
  /// **'Descrição (opcional)'**
  String get habitFormDescription;

  /// No description provided for @habitFormDescriptionHint.
  ///
  /// In pt, this message translates to:
  /// **'Detalhes ou motivação'**
  String get habitFormDescriptionHint;

  /// No description provided for @habitFormIcon.
  ///
  /// In pt, this message translates to:
  /// **'Ícone'**
  String get habitFormIcon;

  /// No description provided for @habitFormCategory.
  ///
  /// In pt, this message translates to:
  /// **'Categoria'**
  String get habitFormCategory;

  /// No description provided for @habitFormFrequency.
  ///
  /// In pt, this message translates to:
  /// **'Frequência'**
  String get habitFormFrequency;

  /// No description provided for @habitFormReminders.
  ///
  /// In pt, this message translates to:
  /// **'Lembretes'**
  String get habitFormReminders;

  /// No description provided for @habitFormReminderAdd.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar'**
  String get habitFormReminderAdd;

  /// No description provided for @habitFormCreateButton.
  ///
  /// In pt, this message translates to:
  /// **'Criar'**
  String get habitFormCreateButton;

  /// No description provided for @habitFormSaveButton.
  ///
  /// In pt, this message translates to:
  /// **'Salvar'**
  String get habitFormSaveButton;

  /// No description provided for @habitFormNameRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe o nome do hábito'**
  String get habitFormNameRequired;

  /// No description provided for @habitFormDayRequired.
  ///
  /// In pt, this message translates to:
  /// **'Selecione ao menos um dia da semana'**
  String get habitFormDayRequired;

  /// No description provided for @habitFormCategoryInfoTitle.
  ///
  /// In pt, this message translates to:
  /// **'Como funcionam as categorias'**
  String get habitFormCategoryInfoTitle;

  /// No description provided for @habitFormCategoryGlobalTitle.
  ///
  /// In pt, this message translates to:
  /// **'Globais'**
  String get habitFormCategoryGlobalTitle;

  /// No description provided for @habitFormCategoryGlobalDescription.
  ///
  /// In pt, this message translates to:
  /// **'Criadas pelo administrador e disponíveis para todos. Não podem ser editadas.'**
  String get habitFormCategoryGlobalDescription;

  /// No description provided for @habitFormCategoryMineTitle.
  ///
  /// In pt, this message translates to:
  /// **'Minhas'**
  String get habitFormCategoryMineTitle;

  /// No description provided for @habitFormCategoryMineDescription.
  ///
  /// In pt, this message translates to:
  /// **'Criadas por você, visíveis só para você. Gerencie em Configurações → Gerenciar categorias.'**
  String get habitFormCategoryMineDescription;

  /// No description provided for @historyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Histórico'**
  String get historyTitle;

  /// No description provided for @historyPeriod7.
  ///
  /// In pt, this message translates to:
  /// **'7 dias'**
  String get historyPeriod7;

  /// No description provided for @historyPeriod30.
  ///
  /// In pt, this message translates to:
  /// **'30 dias'**
  String get historyPeriod30;

  /// No description provided for @historyPeriod90.
  ///
  /// In pt, this message translates to:
  /// **'90 dias'**
  String get historyPeriod90;

  /// No description provided for @historyPeriodAll.
  ///
  /// In pt, this message translates to:
  /// **'Tudo'**
  String get historyPeriodAll;

  /// No description provided for @historyCheckIns.
  ///
  /// In pt, this message translates to:
  /// **'Check-ins'**
  String get historyCheckIns;

  /// No description provided for @historyScheduledDays.
  ///
  /// In pt, this message translates to:
  /// **'Dias agendados'**
  String get historyScheduledDays;

  /// No description provided for @historyBestStreak.
  ///
  /// In pt, this message translates to:
  /// **'Melhor streak'**
  String get historyBestStreak;

  /// No description provided for @historyAdherence.
  ///
  /// In pt, this message translates to:
  /// **'Aderência'**
  String get historyAdherence;

  /// No description provided for @historyStreakDays.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =0{0 dias} =1{1 dia} other{{count} dias}}'**
  String historyStreakDays(int count);

  /// No description provided for @historyEmptyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sem registros'**
  String get historyEmptyTitle;

  /// No description provided for @historyEmptyDescription.
  ///
  /// In pt, this message translates to:
  /// **'Quando você marcar check-ins, o histórico aparece aqui.'**
  String get historyEmptyDescription;

  /// No description provided for @historyNoHabitsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Comece sua jornada'**
  String get historyNoHabitsTitle;

  /// No description provided for @historyNoHabitsDescription.
  ///
  /// In pt, this message translates to:
  /// **'Você ainda não tem hábitos. Crie o primeiro pra acompanhar seu progresso.'**
  String get historyNoHabitsDescription;

  /// No description provided for @historyChartWeeklyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Aderência semanal'**
  String get historyChartWeeklyTitle;

  /// No description provided for @historyChartWeeklySubtitle.
  ///
  /// In pt, this message translates to:
  /// **'% de dias agendados que você cumpriu por semana'**
  String get historyChartWeeklySubtitle;

  /// No description provided for @historyHeatmapTitle.
  ///
  /// In pt, this message translates to:
  /// **'Mapa de hábitos'**
  String get historyHeatmapTitle;

  /// No description provided for @historyHeatmapSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Cada quadrado é um dia. Verde = check-in.'**
  String get historyHeatmapSubtitle;

  /// No description provided for @historyWeekdayTitle.
  ///
  /// In pt, this message translates to:
  /// **'Check-ins por dia da semana'**
  String get historyWeekdayTitle;

  /// No description provided for @historyWeekdaySubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Em quais dias você é mais consistente.'**
  String get historyWeekdaySubtitle;

  /// No description provided for @historyInsight.
  ///
  /// In pt, this message translates to:
  /// **'Insight'**
  String get historyInsight;

  /// No description provided for @historyReminderHint.
  ///
  /// In pt, this message translates to:
  /// **'Você costuma marcar \"{habit}\" perto das {time}, mas o lembrete está às {current}. Quer ajustar?'**
  String historyReminderHint(String habit, String time, String current);

  /// No description provided for @historyReminderApply.
  ///
  /// In pt, this message translates to:
  /// **'Ajustar para {time}'**
  String historyReminderApply(String time);

  /// No description provided for @historyReminderApplied.
  ///
  /// In pt, this message translates to:
  /// **'Lembrete ajustado para {time}'**
  String historyReminderApplied(String time);

  /// No description provided for @historyReminderError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível ajustar.'**
  String get historyReminderError;

  /// No description provided for @historyCheckInsTooltip.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =0{0 check-ins} =1{1 check-in} other{{count} check-ins}}'**
  String historyCheckInsTooltip(int count);

  /// No description provided for @historyDoneStatus.
  ///
  /// In pt, this message translates to:
  /// **'feito'**
  String get historyDoneStatus;

  /// No description provided for @historyMissedStatus.
  ///
  /// In pt, this message translates to:
  /// **'sem check-in'**
  String get historyMissedStatus;

  /// No description provided for @profileEditName.
  ///
  /// In pt, this message translates to:
  /// **'Salvar nome'**
  String get profileEditName;

  /// No description provided for @profileDataAccount.
  ///
  /// In pt, this message translates to:
  /// **'Dados da conta'**
  String get profileDataAccount;

  /// No description provided for @profileNameLabel.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get profileNameLabel;

  /// No description provided for @profileNameUpdated.
  ///
  /// In pt, this message translates to:
  /// **'Nome atualizado!'**
  String get profileNameUpdated;

  /// No description provided for @profileNameUpdateError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao atualizar nome.'**
  String get profileNameUpdateError;

  /// No description provided for @profileChangePassword.
  ///
  /// In pt, this message translates to:
  /// **'Alterar senha'**
  String get profileChangePassword;

  /// No description provided for @profileChangePasswordButton.
  ///
  /// In pt, this message translates to:
  /// **'Alterar senha'**
  String get profileChangePasswordButton;

  /// No description provided for @profileCurrentPassword.
  ///
  /// In pt, this message translates to:
  /// **'Senha atual'**
  String get profileCurrentPassword;

  /// No description provided for @profilePasswordChanged.
  ///
  /// In pt, this message translates to:
  /// **'Senha alterada com sucesso!'**
  String get profilePasswordChanged;

  /// No description provided for @profilePasswordChangeError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao alterar senha.'**
  String get profilePasswordChangeError;

  /// No description provided for @profileNameEmpty.
  ///
  /// In pt, this message translates to:
  /// **'O nome não pode ser vazio'**
  String get profileNameEmpty;

  /// No description provided for @profileNameMinLength.
  ///
  /// In pt, this message translates to:
  /// **'Nome deve ter pelo menos 2 caracteres'**
  String get profileNameMinLength;

  /// No description provided for @profileCurrentPasswordRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe a senha atual'**
  String get profileCurrentPasswordRequired;

  /// No description provided for @profileNewPasswordTooShort.
  ///
  /// In pt, this message translates to:
  /// **'A nova senha deve ter no mínimo 6 caracteres'**
  String get profileNewPasswordTooShort;

  /// No description provided for @profilePasswordsDoNotMatch.
  ///
  /// In pt, this message translates to:
  /// **'As senhas não coincidem'**
  String get profilePasswordsDoNotMatch;

  /// No description provided for @profileLogout.
  ///
  /// In pt, this message translates to:
  /// **'Sair da conta'**
  String get profileLogout;

  /// No description provided for @profileDeleteAccount.
  ///
  /// In pt, this message translates to:
  /// **'Excluir minha conta'**
  String get profileDeleteAccount;

  /// No description provided for @profileDeleteConfirmTitle.
  ///
  /// In pt, this message translates to:
  /// **'Excluir minha conta?'**
  String get profileDeleteConfirmTitle;

  /// No description provided for @profileDeleteConfirmBody.
  ///
  /// In pt, this message translates to:
  /// **'Esta ação é permanente. Todos os seus hábitos, registros e categorias serão removidos. Não pode ser desfeita.'**
  String get profileDeleteConfirmBody;

  /// No description provided for @profileDeleteConfirmAction.
  ///
  /// In pt, this message translates to:
  /// **'Excluir'**
  String get profileDeleteConfirmAction;

  /// No description provided for @profileDeleteError.
  ///
  /// In pt, this message translates to:
  /// **'Falha ao excluir conta.'**
  String get profileDeleteError;

  /// No description provided for @settingsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get settingsTitle;

  /// No description provided for @settingsManageCategories.
  ///
  /// In pt, this message translates to:
  /// **'Gerenciar categorias'**
  String get settingsManageCategories;

  /// No description provided for @settingsManageCategoriesSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Crie e edite suas próprias'**
  String get settingsManageCategoriesSubtitle;

  /// No description provided for @settingsTheme.
  ///
  /// In pt, this message translates to:
  /// **'Tema'**
  String get settingsTheme;

  /// No description provided for @settingsThemeAppTitle.
  ///
  /// In pt, this message translates to:
  /// **'Tema do aplicativo'**
  String get settingsThemeAppTitle;

  /// No description provided for @settingsThemeLight.
  ///
  /// In pt, this message translates to:
  /// **'Sempre claro'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In pt, this message translates to:
  /// **'Sempre escuro'**
  String get settingsThemeDark;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In pt, this message translates to:
  /// **'Sistema'**
  String get settingsThemeSystem;

  /// No description provided for @settingsLanguage.
  ///
  /// In pt, this message translates to:
  /// **'Idioma'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageAppTitle.
  ///
  /// In pt, this message translates to:
  /// **'Idioma do aplicativo'**
  String get settingsLanguageAppTitle;

  /// No description provided for @settingsLanguagePortuguese.
  ///
  /// In pt, this message translates to:
  /// **'Português'**
  String get settingsLanguagePortuguese;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In pt, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// No description provided for @settingsLanguageSpanish.
  ///
  /// In pt, this message translates to:
  /// **'Español'**
  String get settingsLanguageSpanish;

  /// No description provided for @settingsBackup.
  ///
  /// In pt, this message translates to:
  /// **'Backup e dados'**
  String get settingsBackup;

  /// No description provided for @settingsBackupSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Exportar e importar'**
  String get settingsBackupSubtitle;

  /// No description provided for @settingsTestNotification.
  ///
  /// In pt, this message translates to:
  /// **'Testar notificação'**
  String get settingsTestNotification;

  /// No description provided for @settingsTestNotificationSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Dispara uma notificação agora'**
  String get settingsTestNotificationSubtitle;

  /// No description provided for @settingsEmailIntegration.
  ///
  /// In pt, this message translates to:
  /// **'Integração de e-mail'**
  String get settingsEmailIntegration;

  /// No description provided for @settingsEmailConfigured.
  ///
  /// In pt, this message translates to:
  /// **'Mailtrap configurado'**
  String get settingsEmailConfigured;

  /// No description provided for @settingsEmailNotConfigured.
  ///
  /// In pt, this message translates to:
  /// **'Não configurado'**
  String get settingsEmailNotConfigured;

  /// No description provided for @settingsMailtrapTitle.
  ///
  /// In pt, this message translates to:
  /// **'Integração de e-mail'**
  String get settingsMailtrapTitle;

  /// No description provided for @settingsMailtrapSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Credenciais do Mailtrap Sandbox'**
  String get settingsMailtrapSubtitle;

  /// No description provided for @settingsMailtrapToken.
  ///
  /// In pt, this message translates to:
  /// **'API Token'**
  String get settingsMailtrapToken;

  /// No description provided for @settingsMailtrapTokenHint.
  ///
  /// In pt, this message translates to:
  /// **'Token de API do Mailtrap'**
  String get settingsMailtrapTokenHint;

  /// No description provided for @settingsMailtrapInbox.
  ///
  /// In pt, this message translates to:
  /// **'Inbox ID'**
  String get settingsMailtrapInbox;

  /// No description provided for @settingsMailtrapInboxHint.
  ///
  /// In pt, this message translates to:
  /// **'ID da inbox no Mailtrap'**
  String get settingsMailtrapInboxHint;

  /// No description provided for @settingsMailtrapFromEmail.
  ///
  /// In pt, this message translates to:
  /// **'E-mail do remetente'**
  String get settingsMailtrapFromEmail;

  /// No description provided for @settingsMailtrapFromEmailHint.
  ///
  /// In pt, this message translates to:
  /// **'ex: noreply@sah.app'**
  String get settingsMailtrapFromEmailHint;

  /// No description provided for @settingsMailtrapFromName.
  ///
  /// In pt, this message translates to:
  /// **'Nome do remetente'**
  String get settingsMailtrapFromName;

  /// No description provided for @settingsMailtrapFromNameHint.
  ///
  /// In pt, this message translates to:
  /// **'ex: Equipe SAH'**
  String get settingsMailtrapFromNameHint;

  /// No description provided for @settingsMailtrapFillAll.
  ///
  /// In pt, this message translates to:
  /// **'Preencha todos os campos.'**
  String get settingsMailtrapFillAll;

  /// No description provided for @settingsMailtrapSaved.
  ///
  /// In pt, this message translates to:
  /// **'Mailtrap configurado!'**
  String get settingsMailtrapSaved;

  /// No description provided for @settingsMailtrapClear.
  ///
  /// In pt, this message translates to:
  /// **'Limpar configuração'**
  String get settingsMailtrapClear;

  /// No description provided for @backupTitle.
  ///
  /// In pt, this message translates to:
  /// **'Backup e dados'**
  String get backupTitle;

  /// No description provided for @backupSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Mantenha seus dados seguros'**
  String get backupSubtitle;

  /// No description provided for @backupExportTitle.
  ///
  /// In pt, this message translates to:
  /// **'Exportar dados'**
  String get backupExportTitle;

  /// No description provided for @backupExportDescription.
  ///
  /// In pt, this message translates to:
  /// **'Gera um arquivo JSON com seus hábitos, registros e categorias.'**
  String get backupExportDescription;

  /// No description provided for @backupExportNow.
  ///
  /// In pt, this message translates to:
  /// **'Exportar agora'**
  String get backupExportNow;

  /// No description provided for @backupExportError.
  ///
  /// In pt, this message translates to:
  /// **'Falha ao exportar.'**
  String get backupExportError;

  /// No description provided for @backupExportShareError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao compartilhar: {message}'**
  String backupExportShareError(String message);

  /// No description provided for @backupImportTitle.
  ///
  /// In pt, this message translates to:
  /// **'Importar backup'**
  String get backupImportTitle;

  /// No description provided for @backupImportDescription.
  ///
  /// In pt, this message translates to:
  /// **'Substitui seus dados pelos do arquivo. Ação destrutiva.'**
  String get backupImportDescription;

  /// No description provided for @backupImportSelect.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar arquivo'**
  String get backupImportSelect;

  /// No description provided for @backupImportConfirmTitle.
  ///
  /// In pt, this message translates to:
  /// **'Importar backup?'**
  String get backupImportConfirmTitle;

  /// No description provided for @backupImportConfirmBody.
  ///
  /// In pt, this message translates to:
  /// **'Todos os seus hábitos, registros e categorias atuais serão substituídos pelos do arquivo. Esta ação não pode ser desfeita.'**
  String get backupImportConfirmBody;

  /// No description provided for @backupImportInvalid.
  ///
  /// In pt, this message translates to:
  /// **'Arquivo inválido.'**
  String get backupImportInvalid;

  /// No description provided for @backupImportSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Backup importado com sucesso!'**
  String get backupImportSuccess;

  /// No description provided for @backupImportReadError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao ler arquivo: {message}'**
  String backupImportReadError(String message);

  /// No description provided for @backupAutoTitle.
  ///
  /// In pt, this message translates to:
  /// **'Backup automático'**
  String get backupAutoTitle;

  /// No description provided for @backupAutoLast.
  ///
  /// In pt, this message translates to:
  /// **'Último: {when}'**
  String backupAutoLast(String when);

  /// No description provided for @backupAutoNever.
  ///
  /// In pt, this message translates to:
  /// **'Nunca'**
  String get backupAutoNever;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In pt, this message translates to:
  /// **'Bem-vindo ao SAH'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeDescription.
  ///
  /// In pt, this message translates to:
  /// **'O lugar para criar, lembrar e celebrar seus hábitos. Comece pequeno, mantenha consistência.'**
  String get onboardingWelcomeDescription;

  /// No description provided for @onboardingRemindersTitle.
  ///
  /// In pt, this message translates to:
  /// **'Lembretes que cabem na sua rotina'**
  String get onboardingRemindersTitle;

  /// No description provided for @onboardingRemindersDescription.
  ///
  /// In pt, this message translates to:
  /// **'Defina quantos horários quiser para cada hábito. As notificações tocam só nos dias que você escolher.'**
  String get onboardingRemindersDescription;

  /// No description provided for @onboardingProgressTitle.
  ///
  /// In pt, this message translates to:
  /// **'Veja sua evolução'**
  String get onboardingProgressTitle;

  /// No description provided for @onboardingProgressDescription.
  ///
  /// In pt, this message translates to:
  /// **'Streaks, aderência e histórico — tudo no app, salvo só no seu dispositivo.'**
  String get onboardingProgressDescription;

  /// No description provided for @onboardingSuggestionsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Bem-vindo, {nome}!'**
  String onboardingSuggestionsTitle(String nome);

  /// No description provided for @onboardingSuggestionsTitleFallback.
  ///
  /// In pt, this message translates to:
  /// **'Bem-vindo!'**
  String get onboardingSuggestionsTitleFallback;

  /// No description provided for @onboardingSuggestionsSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Escolha os hábitos que combinam com você. Você pode ajustar tudo depois.'**
  String get onboardingSuggestionsSubtitle;

  /// No description provided for @onboardingStartButton.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =0{Selecione ao menos um hábito} =1{Começar com 1 hábito} other{Começar com {count} hábitos}}'**
  String onboardingStartButton(int count);

  /// No description provided for @onboardingFailedHabits.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{1 hábito falhou ao criar.} other{{count} hábitos falharam ao criar.}}'**
  String onboardingFailedHabits(int count);

  /// No description provided for @onboardingHintTitle.
  ///
  /// In pt, this message translates to:
  /// **'Comece com sugestões'**
  String get onboardingHintTitle;

  /// No description provided for @onboardingHintBody.
  ///
  /// In pt, this message translates to:
  /// **'Você ainda não tem hábitos. Escolha alguns para começar — leva menos de um minuto.'**
  String get onboardingHintBody;

  /// No description provided for @onboardingHintAction.
  ///
  /// In pt, this message translates to:
  /// **'Ver sugestões'**
  String get onboardingHintAction;

  /// No description provided for @templatesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Templates de rotina'**
  String get templatesTitle;

  /// No description provided for @templatesSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Crie vários hábitos de uma vez. Você pode editar tudo depois.'**
  String get templatesSubtitle;

  /// No description provided for @templatesAppliedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Template aplicado: {count} hábitos criados!'**
  String templatesAppliedSuccess(int count);

  /// No description provided for @templatesAppliedPartial.
  ///
  /// In pt, this message translates to:
  /// **'Criados {created}, {failed} falharam.'**
  String templatesAppliedPartial(int created, int failed);

  /// No description provided for @templatesCount.
  ///
  /// In pt, this message translates to:
  /// **'{count} hábitos · {description}'**
  String templatesCount(int count, String description);

  /// No description provided for @categoriesEmptyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma categoria'**
  String get categoriesEmptyTitle;

  /// No description provided for @categoriesEmptyDescription.
  ///
  /// In pt, this message translates to:
  /// **'Crie sua primeira categoria para organizar seus hábitos.'**
  String get categoriesEmptyDescription;

  /// No description provided for @categoriesNewCategory.
  ///
  /// In pt, this message translates to:
  /// **'Nova categoria'**
  String get categoriesNewCategory;

  /// No description provided for @categoriesNameLabel.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get categoriesNameLabel;

  /// No description provided for @categoriesNameHint.
  ///
  /// In pt, this message translates to:
  /// **'Ex: Saúde, Trabalho…'**
  String get categoriesNameHint;

  /// No description provided for @categoriesColorLabel.
  ///
  /// In pt, this message translates to:
  /// **'Cor'**
  String get categoriesColorLabel;

  /// No description provided for @categoriesGlobalLabel.
  ///
  /// In pt, this message translates to:
  /// **'Global'**
  String get categoriesGlobalLabel;

  /// No description provided for @categoriesGlobalDescription.
  ///
  /// In pt, this message translates to:
  /// **'Disponível para todos os usuários'**
  String get categoriesGlobalDescription;

  /// No description provided for @categoriesEditCategory.
  ///
  /// In pt, this message translates to:
  /// **'Editar categoria'**
  String get categoriesEditCategory;

  /// No description provided for @categoriesDeleteConfirmTitle.
  ///
  /// In pt, this message translates to:
  /// **'Excluir categoria?'**
  String get categoriesDeleteConfirmTitle;

  /// No description provided for @categoriesDeleteConfirmBody.
  ///
  /// In pt, this message translates to:
  /// **'A categoria será removida. Hábitos vinculados ficarão sem categoria.'**
  String get categoriesDeleteConfirmBody;

  /// No description provided for @categoriesDeleteError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível excluir.'**
  String get categoriesDeleteError;

  /// No description provided for @categoriesCreated.
  ///
  /// In pt, this message translates to:
  /// **'Categoria criada!'**
  String get categoriesCreated;

  /// No description provided for @categoriesUpdated.
  ///
  /// In pt, this message translates to:
  /// **'Categoria atualizada!'**
  String get categoriesUpdated;

  /// No description provided for @categoriesDeleted.
  ///
  /// In pt, this message translates to:
  /// **'Categoria excluída!'**
  String get categoriesDeleted;

  /// No description provided for @adminDashboardTitle.
  ///
  /// In pt, this message translates to:
  /// **'Dashboard'**
  String get adminDashboardTitle;

  /// No description provided for @adminDashboardSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Visão geral da plataforma'**
  String get adminDashboardSubtitle;

  /// No description provided for @adminDashboardTotalUsers.
  ///
  /// In pt, this message translates to:
  /// **'Total de usuários'**
  String get adminDashboardTotalUsers;

  /// No description provided for @adminDashboardActiveUsers.
  ///
  /// In pt, this message translates to:
  /// **'Usuários ativos'**
  String get adminDashboardActiveUsers;

  /// No description provided for @adminDashboardBlockedUsers.
  ///
  /// In pt, this message translates to:
  /// **'Bloqueados'**
  String get adminDashboardBlockedUsers;

  /// No description provided for @adminDashboardTotalHabits.
  ///
  /// In pt, this message translates to:
  /// **'Total de hábitos'**
  String get adminDashboardTotalHabits;

  /// No description provided for @adminDashboardAvgAdherence.
  ///
  /// In pt, this message translates to:
  /// **'Aderência média'**
  String get adminDashboardAvgAdherence;

  /// No description provided for @adminDashboardAvgStreak.
  ///
  /// In pt, this message translates to:
  /// **'Streak médio (dias)'**
  String get adminDashboardAvgStreak;

  /// No description provided for @adminDashboardQuickAccess.
  ///
  /// In pt, this message translates to:
  /// **'Acesso rápido'**
  String get adminDashboardQuickAccess;

  /// No description provided for @adminUsersTitle.
  ///
  /// In pt, this message translates to:
  /// **'Usuários'**
  String get adminUsersTitle;

  /// No description provided for @adminUsersSearchHint.
  ///
  /// In pt, this message translates to:
  /// **'Buscar por nome ou e-mail'**
  String get adminUsersSearchHint;

  /// No description provided for @adminUsersFilterAll.
  ///
  /// In pt, this message translates to:
  /// **'Todos'**
  String get adminUsersFilterAll;

  /// No description provided for @adminUsersFilterActive.
  ///
  /// In pt, this message translates to:
  /// **'Ativos'**
  String get adminUsersFilterActive;

  /// No description provided for @adminUsersFilterBlocked.
  ///
  /// In pt, this message translates to:
  /// **'Bloqueados'**
  String get adminUsersFilterBlocked;

  /// No description provided for @adminUsersBlockButton.
  ///
  /// In pt, this message translates to:
  /// **'Bloquear'**
  String get adminUsersBlockButton;

  /// No description provided for @adminUsersUnblockButton.
  ///
  /// In pt, this message translates to:
  /// **'Desbloquear'**
  String get adminUsersUnblockButton;

  /// No description provided for @adminUsersPromoteAdmin.
  ///
  /// In pt, this message translates to:
  /// **'Tornar admin'**
  String get adminUsersPromoteAdmin;

  /// No description provided for @adminUsersRevokeAdmin.
  ///
  /// In pt, this message translates to:
  /// **'Remover admin'**
  String get adminUsersRevokeAdmin;

  /// No description provided for @adminUsersOwnerBadge.
  ///
  /// In pt, this message translates to:
  /// **'Owner'**
  String get adminUsersOwnerBadge;

  /// No description provided for @adminUsersAdminBadge.
  ///
  /// In pt, this message translates to:
  /// **'Admin'**
  String get adminUsersAdminBadge;

  /// No description provided for @adminUsersBlockedBadge.
  ///
  /// In pt, this message translates to:
  /// **'Bloqueado'**
  String get adminUsersBlockedBadge;

  /// No description provided for @adminUsersActiveBadge.
  ///
  /// In pt, this message translates to:
  /// **'Ativo'**
  String get adminUsersActiveBadge;

  /// No description provided for @adminUsersBlockReasonLabel.
  ///
  /// In pt, this message translates to:
  /// **'Motivo do bloqueio'**
  String get adminUsersBlockReasonLabel;

  /// No description provided for @adminUsersBlockReasonHint.
  ///
  /// In pt, this message translates to:
  /// **'Ex: spam, abuso, conta inativa…'**
  String get adminUsersBlockReasonHint;

  /// No description provided for @adminUsersConfirmBlock.
  ///
  /// In pt, this message translates to:
  /// **'Bloquear usuário'**
  String get adminUsersConfirmBlock;

  /// No description provided for @adminUsersBlockModalSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'A conta de {nome} ficará inacessível até ser desbloqueada.'**
  String adminUsersBlockModalSubtitle(String nome);

  /// No description provided for @adminUsersBlockReasonRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe o motivo do bloqueio'**
  String get adminUsersBlockReasonRequired;

  /// No description provided for @adminUsersLoadError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar usuários'**
  String get adminUsersLoadError;

  /// No description provided for @adminUsersEmptyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum usuário encontrado'**
  String get adminUsersEmptyTitle;

  /// No description provided for @adminUsersEmptyDescription.
  ///
  /// In pt, this message translates to:
  /// **'Tente ajustar os filtros ou o termo de busca.'**
  String get adminUsersEmptyDescription;

  /// No description provided for @adminUsersDemoteTitle.
  ///
  /// In pt, this message translates to:
  /// **'Remover admin?'**
  String get adminUsersDemoteTitle;

  /// No description provided for @adminUsersDemoteBody.
  ///
  /// In pt, this message translates to:
  /// **'{nome} perderá acesso ao painel administrativo.'**
  String adminUsersDemoteBody(String nome);

  /// No description provided for @adminCategoriesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Categorias globais'**
  String get adminCategoriesTitle;

  /// No description provided for @adminCategoriesShortTitle.
  ///
  /// In pt, this message translates to:
  /// **'Categorias'**
  String get adminCategoriesShortTitle;

  /// No description provided for @adminCategoriesSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Disponíveis para todos os usuários'**
  String get adminCategoriesSubtitle;

  /// No description provided for @adminCategoriesNewButton.
  ///
  /// In pt, this message translates to:
  /// **'Nova'**
  String get adminCategoriesNewButton;

  /// No description provided for @adminCategoriesLoadError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar categorias'**
  String get adminCategoriesLoadError;

  /// No description provided for @adminCategoriesEmptyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma categoria'**
  String get adminCategoriesEmptyTitle;

  /// No description provided for @adminCategoriesEmptyDescription.
  ///
  /// In pt, this message translates to:
  /// **'Crie a primeira categoria global para os usuários.'**
  String get adminCategoriesEmptyDescription;

  /// No description provided for @adminCategoriesCreateButton.
  ///
  /// In pt, this message translates to:
  /// **'Criar categoria'**
  String get adminCategoriesCreateButton;

  /// No description provided for @adminCategoriesInUseTitle.
  ///
  /// In pt, this message translates to:
  /// **'Categoria em uso'**
  String get adminCategoriesInUseTitle;

  /// No description provided for @adminCategoriesInUseBody.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{Esta categoria está vinculada a 1 hábito. Deseja excluir mesmo assim?} other{Esta categoria está vinculada a {count} hábitos. Deseja excluir mesmo assim?}}'**
  String adminCategoriesInUseBody(int count);

  /// No description provided for @adminCategoriesForceDelete.
  ///
  /// In pt, this message translates to:
  /// **'Excluir assim mesmo'**
  String get adminCategoriesForceDelete;

  /// No description provided for @adminCategoriesDeleteTitle.
  ///
  /// In pt, this message translates to:
  /// **'Excluir categoria?'**
  String get adminCategoriesDeleteTitle;

  /// No description provided for @adminCategoriesDeleteBody.
  ///
  /// In pt, this message translates to:
  /// **'Esta ação não pode ser desfeita.'**
  String get adminCategoriesDeleteBody;

  /// No description provided for @adminCategoriesFormEditTitle.
  ///
  /// In pt, this message translates to:
  /// **'Editar categoria'**
  String get adminCategoriesFormEditTitle;

  /// No description provided for @adminCategoriesFormNewTitle.
  ///
  /// In pt, this message translates to:
  /// **'Nova categoria'**
  String get adminCategoriesFormNewTitle;

  /// No description provided for @adminCategoriesFormNameLabel.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get adminCategoriesFormNameLabel;

  /// No description provided for @adminCategoriesFormNameHint.
  ///
  /// In pt, this message translates to:
  /// **'Ex: Exercício, Leitura…'**
  String get adminCategoriesFormNameHint;

  /// No description provided for @adminCategoriesFormNameRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe o nome da categoria'**
  String get adminCategoriesFormNameRequired;

  /// No description provided for @adminCategoriesFormColorLabel.
  ///
  /// In pt, this message translates to:
  /// **'Cor'**
  String get adminCategoriesFormColorLabel;

  /// No description provided for @adminCategoriesFormCreate.
  ///
  /// In pt, this message translates to:
  /// **'Criar'**
  String get adminCategoriesFormCreate;

  /// No description provided for @adminCategoriesGlobalBadge.
  ///
  /// In pt, this message translates to:
  /// **'Global'**
  String get adminCategoriesGlobalBadge;

  /// No description provided for @adminCategoriesHabitCount.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =0{0 hábitos} =1{1 hábito} other{{count} hábitos}}'**
  String adminCategoriesHabitCount(int count);

  /// No description provided for @userCategoriesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Minhas categorias'**
  String get userCategoriesTitle;

  /// No description provided for @userCategoriesYourSection.
  ///
  /// In pt, this message translates to:
  /// **'Suas categorias'**
  String get userCategoriesYourSection;

  /// No description provided for @userCategoriesGlobalsSection.
  ///
  /// In pt, this message translates to:
  /// **'Globais'**
  String get userCategoriesGlobalsSection;

  /// No description provided for @userCategoriesGlobalsHint.
  ///
  /// In pt, this message translates to:
  /// **'Disponíveis para todos — somente leitura.'**
  String get userCategoriesGlobalsHint;

  /// No description provided for @userCategoriesEmptyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma categoria pessoal'**
  String get userCategoriesEmptyTitle;

  /// No description provided for @userCategoriesEmptyDescription.
  ///
  /// In pt, this message translates to:
  /// **'Crie categorias próprias para organizar seus hábitos.'**
  String get userCategoriesEmptyDescription;

  /// No description provided for @userCategoriesCreateFirst.
  ///
  /// In pt, this message translates to:
  /// **'Criar primeira'**
  String get userCategoriesCreateFirst;

  /// No description provided for @errorScreenTitle.
  ///
  /// In pt, this message translates to:
  /// **'Algo deu errado.'**
  String get errorScreenTitle;

  /// No description provided for @errorScreenDescription.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível carregar esta página. Tente novamente.'**
  String get errorScreenDescription;

  /// No description provided for @errorScreenRef.
  ///
  /// In pt, this message translates to:
  /// **'Ref: {code}'**
  String errorScreenRef(String code);

  /// No description provided for @errorScreenGoHome.
  ///
  /// In pt, this message translates to:
  /// **'Ir para o início'**
  String get errorScreenGoHome;

  /// No description provided for @adminLogsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Logs do sistema'**
  String get adminLogsTitle;

  /// No description provided for @adminLogsEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum log encontrado'**
  String get adminLogsEmpty;

  /// No description provided for @adminLogsEmptyFiltered.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum evento deste tipo foi registrado. Limpe os filtros para ver todos.'**
  String get adminLogsEmptyFiltered;

  /// No description provided for @adminLogsEmptyAll.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum evento registrado ainda.'**
  String get adminLogsEmptyAll;

  /// No description provided for @adminLogsFilterAll.
  ///
  /// In pt, this message translates to:
  /// **'Todos'**
  String get adminLogsFilterAll;

  /// No description provided for @adminLogsFilterLogin.
  ///
  /// In pt, this message translates to:
  /// **'Login'**
  String get adminLogsFilterLogin;

  /// No description provided for @adminLogsFilterSignup.
  ///
  /// In pt, this message translates to:
  /// **'Cadastro'**
  String get adminLogsFilterSignup;

  /// No description provided for @adminLogsFilterBlock.
  ///
  /// In pt, this message translates to:
  /// **'Bloqueio'**
  String get adminLogsFilterBlock;

  /// No description provided for @adminLogsFilterAdmin.
  ///
  /// In pt, this message translates to:
  /// **'Admin'**
  String get adminLogsFilterAdmin;

  /// No description provided for @adminLogsFilterError.
  ///
  /// In pt, this message translates to:
  /// **'Erros'**
  String get adminLogsFilterError;

  /// No description provided for @adminLogsTypeLogin.
  ///
  /// In pt, this message translates to:
  /// **'Login'**
  String get adminLogsTypeLogin;

  /// No description provided for @adminLogsTypeLogout.
  ///
  /// In pt, this message translates to:
  /// **'Logout'**
  String get adminLogsTypeLogout;

  /// No description provided for @adminLogsTypeSignup.
  ///
  /// In pt, this message translates to:
  /// **'Cadastro'**
  String get adminLogsTypeSignup;

  /// No description provided for @adminLogsTypeBlock.
  ///
  /// In pt, this message translates to:
  /// **'Bloqueio'**
  String get adminLogsTypeBlock;

  /// No description provided for @adminLogsTypeUnblock.
  ///
  /// In pt, this message translates to:
  /// **'Desbloqueio'**
  String get adminLogsTypeUnblock;

  /// No description provided for @adminLogsTypeError.
  ///
  /// In pt, this message translates to:
  /// **'Erro'**
  String get adminLogsTypeError;

  /// No description provided for @adminLogsTypeAdmin.
  ///
  /// In pt, this message translates to:
  /// **'Admin'**
  String get adminLogsTypeAdmin;

  /// No description provided for @adminLogsTypeProfile.
  ///
  /// In pt, this message translates to:
  /// **'Perfil'**
  String get adminLogsTypeProfile;

  /// No description provided for @adminLogsTypePassword.
  ///
  /// In pt, this message translates to:
  /// **'Senha'**
  String get adminLogsTypePassword;

  /// No description provided for @adminLogsTypeReset.
  ///
  /// In pt, this message translates to:
  /// **'Reset'**
  String get adminLogsTypeReset;

  /// No description provided for @adminLogsTypeAccountDeleted.
  ///
  /// In pt, this message translates to:
  /// **'Exclusão'**
  String get adminLogsTypeAccountDeleted;

  /// No description provided for @adminLogsTypeBackup.
  ///
  /// In pt, this message translates to:
  /// **'Backup'**
  String get adminLogsTypeBackup;

  /// No description provided for @tooltipBack.
  ///
  /// In pt, this message translates to:
  /// **'Voltar'**
  String get tooltipBack;

  /// No description provided for @tooltipSettings.
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get tooltipSettings;

  /// No description provided for @tooltipOpenMenu.
  ///
  /// In pt, this message translates to:
  /// **'Abrir menu'**
  String get tooltipOpenMenu;

  /// No description provided for @tooltipLogout.
  ///
  /// In pt, this message translates to:
  /// **'Sair'**
  String get tooltipLogout;

  /// No description provided for @testNotificationTitle.
  ///
  /// In pt, this message translates to:
  /// **'Teste de lembrete'**
  String get testNotificationTitle;

  /// No description provided for @testNotificationBody.
  ///
  /// In pt, this message translates to:
  /// **'Se você está vendo isso, as notificações estão funcionando!'**
  String get testNotificationBody;

  /// No description provided for @permissionDenied.
  ///
  /// In pt, this message translates to:
  /// **'Permissão de notificação negada. Ative nas configurações do sistema.'**
  String get permissionDenied;

  /// No description provided for @logoutDialogTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sair?'**
  String get logoutDialogTitle;

  /// No description provided for @logoutDialogBody.
  ///
  /// In pt, this message translates to:
  /// **'Deseja encerrar a sessão?'**
  String get logoutDialogBody;

  /// No description provided for @logoutDialogConfirm.
  ///
  /// In pt, this message translates to:
  /// **'Sair'**
  String get logoutDialogConfirm;

  /// No description provided for @onboardingSuggDrinkWater.
  ///
  /// In pt, this message translates to:
  /// **'Beber 2L de água'**
  String get onboardingSuggDrinkWater;

  /// No description provided for @onboardingSuggVitamin.
  ///
  /// In pt, this message translates to:
  /// **'Tomar vitamina'**
  String get onboardingSuggVitamin;

  /// No description provided for @onboardingSuggSleep8h.
  ///
  /// In pt, this message translates to:
  /// **'Dormir 8 horas'**
  String get onboardingSuggSleep8h;

  /// No description provided for @onboardingSuggGratitude.
  ///
  /// In pt, this message translates to:
  /// **'Anotar 3 gratidões'**
  String get onboardingSuggGratitude;

  /// No description provided for @onboardingSuggOffline15.
  ///
  /// In pt, this message translates to:
  /// **'15min offline'**
  String get onboardingSuggOffline15;

  /// No description provided for @onboardingSuggWalkOutdoor.
  ///
  /// In pt, this message translates to:
  /// **'Caminhar ao ar livre'**
  String get onboardingSuggWalkOutdoor;

  /// No description provided for @onboardingSuggPlanDay.
  ///
  /// In pt, this message translates to:
  /// **'Planejar o dia'**
  String get onboardingSuggPlanDay;

  /// No description provided for @onboardingSuggReviewAgenda.
  ///
  /// In pt, this message translates to:
  /// **'Revisar agenda'**
  String get onboardingSuggReviewAgenda;

  /// No description provided for @onboardingSuggInboxZero.
  ///
  /// In pt, this message translates to:
  /// **'Inbox zero'**
  String get onboardingSuggInboxZero;

  /// No description provided for @onboardingSuggTrain30.
  ///
  /// In pt, this message translates to:
  /// **'Treinar 30min'**
  String get onboardingSuggTrain30;

  /// No description provided for @onboardingSuggStretchBeforeSleep.
  ///
  /// In pt, this message translates to:
  /// **'Alongar antes de dormir'**
  String get onboardingSuggStretchBeforeSleep;

  /// No description provided for @onboardingSuggStairs.
  ///
  /// In pt, this message translates to:
  /// **'Subir escadas'**
  String get onboardingSuggStairs;

  /// No description provided for @onboardingSuggRead20Pages.
  ///
  /// In pt, this message translates to:
  /// **'Ler 20 páginas'**
  String get onboardingSuggRead20Pages;

  /// No description provided for @onboardingSuggReadBeforeSleep.
  ///
  /// In pt, this message translates to:
  /// **'Ler antes de dormir'**
  String get onboardingSuggReadBeforeSleep;

  /// No description provided for @onboardingSuggLearnNewWord.
  ///
  /// In pt, this message translates to:
  /// **'Aprender palavra nova'**
  String get onboardingSuggLearnNewWord;

  /// No description provided for @onboardingSuggMeditate10.
  ///
  /// In pt, this message translates to:
  /// **'Meditar 10min'**
  String get onboardingSuggMeditate10;

  /// No description provided for @onboardingSuggConsciousBreathing.
  ///
  /// In pt, this message translates to:
  /// **'Respiração consciente 5min'**
  String get onboardingSuggConsciousBreathing;

  /// No description provided for @onboardingSuggMindfulnessLunch.
  ///
  /// In pt, this message translates to:
  /// **'Mindfulness pós-almoço'**
  String get onboardingSuggMindfulnessLunch;

  /// No description provided for @templateMorningName.
  ///
  /// In pt, this message translates to:
  /// **'Rotina matinal'**
  String get templateMorningName;

  /// No description provided for @templateMorningDesc.
  ///
  /// In pt, this message translates to:
  /// **'Comece o dia com 4 hábitos curtos.'**
  String get templateMorningDesc;

  /// No description provided for @templateStudentName.
  ///
  /// In pt, this message translates to:
  /// **'Estudante'**
  String get templateStudentName;

  /// No description provided for @templateStudentDesc.
  ///
  /// In pt, this message translates to:
  /// **'Rotina balanceada de estudo e descanso.'**
  String get templateStudentDesc;

  /// No description provided for @templateHealthyName.
  ///
  /// In pt, this message translates to:
  /// **'Vida saudável'**
  String get templateHealthyName;

  /// No description provided for @templateHealthyDesc.
  ///
  /// In pt, this message translates to:
  /// **'Foco em corpo e mente.'**
  String get templateHealthyDesc;

  /// No description provided for @templateRemoteName.
  ///
  /// In pt, this message translates to:
  /// **'Trabalho remoto'**
  String get templateRemoteName;

  /// No description provided for @templateRemoteDesc.
  ///
  /// In pt, this message translates to:
  /// **'Mantém foco e energia trabalhando de casa.'**
  String get templateRemoteDesc;

  /// No description provided for @templateHabitMorningWater.
  ///
  /// In pt, this message translates to:
  /// **'Beber um copo de água'**
  String get templateHabitMorningWater;

  /// No description provided for @templateHabitMorningMeditate.
  ///
  /// In pt, this message translates to:
  /// **'Meditar 10min'**
  String get templateHabitMorningMeditate;

  /// No description provided for @templateHabitMorningStretch.
  ///
  /// In pt, this message translates to:
  /// **'Alongar'**
  String get templateHabitMorningStretch;

  /// No description provided for @templateHabitMorningPlan.
  ///
  /// In pt, this message translates to:
  /// **'Planejar o dia'**
  String get templateHabitMorningPlan;

  /// No description provided for @templateHabitStudentRead.
  ///
  /// In pt, this message translates to:
  /// **'Ler 20 páginas'**
  String get templateHabitStudentRead;

  /// No description provided for @templateHabitStudentReview.
  ///
  /// In pt, this message translates to:
  /// **'Revisar agenda'**
  String get templateHabitStudentReview;

  /// No description provided for @templateHabitStudentLearn.
  ///
  /// In pt, this message translates to:
  /// **'Aprender palavra nova'**
  String get templateHabitStudentLearn;

  /// No description provided for @templateHabitStudentPomodoro.
  ///
  /// In pt, this message translates to:
  /// **'Pomodoro 25min'**
  String get templateHabitStudentPomodoro;

  /// No description provided for @templateHabitHealthyWater.
  ///
  /// In pt, this message translates to:
  /// **'Beber 2L de água'**
  String get templateHabitHealthyWater;

  /// No description provided for @templateHabitHealthyWalk.
  ///
  /// In pt, this message translates to:
  /// **'Caminhar 30min'**
  String get templateHabitHealthyWalk;

  /// No description provided for @templateHabitHealthyGratitude.
  ///
  /// In pt, this message translates to:
  /// **'Anotar 3 gratidões'**
  String get templateHabitHealthyGratitude;

  /// No description provided for @templateHabitHealthySleep.
  ///
  /// In pt, this message translates to:
  /// **'Dormir 8 horas'**
  String get templateHabitHealthySleep;

  /// No description provided for @templateHabitRemoteInbox.
  ///
  /// In pt, this message translates to:
  /// **'Inbox zero pela manhã'**
  String get templateHabitRemoteInbox;

  /// No description provided for @templateHabitRemoteBreak.
  ///
  /// In pt, this message translates to:
  /// **'Pausa de 5min a cada hora'**
  String get templateHabitRemoteBreak;

  /// No description provided for @templateHabitRemoteNeck.
  ///
  /// In pt, this message translates to:
  /// **'Alongar pescoço'**
  String get templateHabitRemoteNeck;

  /// No description provided for @templateHabitRemoteCoffee.
  ///
  /// In pt, this message translates to:
  /// **'Café com calma'**
  String get templateHabitRemoteCoffee;
}

class _AppL10nDelegate extends LocalizationsDelegate<AppL10n> {
  const _AppL10nDelegate();

  @override
  Future<AppL10n> load(Locale locale) {
    return SynchronousFuture<AppL10n>(lookupAppL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppL10nDelegate old) => false;
}

AppL10n lookupAppL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppL10nEn();
    case 'es':
      return AppL10nEs();
    case 'pt':
      return AppL10nPt();
  }

  throw FlutterError(
      'AppL10n.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
