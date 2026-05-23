// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppL10nEn extends AppL10n {
  AppL10nEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'SAH';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonBack => 'Back';

  @override
  String get commonOk => 'OK';

  @override
  String get commonNext => 'Next';

  @override
  String get commonSkip => 'Skip';

  @override
  String get commonContinue => 'Let\'s start';

  @override
  String get commonRetry => 'Try again';

  @override
  String get commonLoading => 'Loading…';

  @override
  String get commonError => 'Something went wrong.';

  @override
  String get commonRequiredField => 'Required field';

  @override
  String get commonClose => 'Close';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get commonUnderstood => 'Got it';

  @override
  String get commonNotNow => 'Not now';

  @override
  String get commonRemove => 'Remove';

  @override
  String get navToday => 'Today';

  @override
  String get navHabits => 'Habits';

  @override
  String get navHistory => 'History';

  @override
  String get navProfile => 'Profile';

  @override
  String get navAdminDashboard => 'Dashboard';

  @override
  String get navAdminUsers => 'Users';

  @override
  String get navAdminCategories => 'Categories';

  @override
  String get navAdminLogs => 'Logs';

  @override
  String get authLoginTitle => 'Sign in to your account';

  @override
  String get authLoginSubtitle => 'Continue your habits journey.';

  @override
  String get authEmailLabel => 'E-mail';

  @override
  String get authEmailHint => 'your@email.com';

  @override
  String get authPasswordLabel => 'Password';

  @override
  String get authPasswordHint => 'Your password';

  @override
  String get authLoginButton => 'Sign in';

  @override
  String get authForgotPassword => 'Forgot password';

  @override
  String get authNoAccount => 'No account? ';

  @override
  String get authSignupLink => 'Sign up';

  @override
  String get authSignupTitle => 'Create your account';

  @override
  String get authSignupSubtitle => 'Start building habits today.';

  @override
  String get authNameLabel => 'Name';

  @override
  String get authNameHint => 'Your name';

  @override
  String get authSignupButton => 'Create account';

  @override
  String get authHaveAccount => 'Already have an account? ';

  @override
  String get authLoginLink => 'Sign in';

  @override
  String get authRecoverTitle => 'Recover password';

  @override
  String get authRecoverSubtitle =>
      'Enter your e-mail and we\'ll send a link to reset your password.';

  @override
  String get authSendLink => 'Send link';

  @override
  String get authBackToLogin => 'Back to sign in';

  @override
  String get authRecoverSentTitle => 'Link sent.';

  @override
  String get authRecoverSentBody =>
      'Check your inbox and click the link to reset your password.';

  @override
  String get authHaveCode => 'I have my code';

  @override
  String get authResetTitle => 'Reset password';

  @override
  String get authResetSubtitle =>
      'Paste the code we sent by e-mail and choose a new password.';

  @override
  String get authResetCodeLabel => 'Reset code';

  @override
  String get authNewPassword => 'New password';

  @override
  String get authConfirmPassword => 'Confirm new password';

  @override
  String get authResetButton => 'Reset password';

  @override
  String get authResetSuccess => 'Password reset successfully!';

  @override
  String get authResetError => 'Error resetting password.';

  @override
  String get authRecoverError => 'Error sending e-mail.';

  @override
  String todayGreetingMorning(String nome) {
    return 'Good morning, $nome!';
  }

  @override
  String todayGreetingAfternoon(String nome) {
    return 'Good afternoon, $nome!';
  }

  @override
  String todayGreetingEvening(String nome) {
    return 'Good evening, $nome!';
  }

  @override
  String get todayHeading => 'Today\'s habits';

  @override
  String get todayFreeDay => 'Free day!';

  @override
  String get todayFreeDescription =>
      'No habits scheduled for today. Enjoy the break or create a new habit.';

  @override
  String get todayLoadError => 'Error loading habits.';

  @override
  String get todayActionSkipDay => 'Skip today';

  @override
  String get todayActionUndoSkip => 'Undo skip';

  @override
  String get todayActionAddNote => 'Add note';

  @override
  String get todayActionEditNote => 'Edit note';

  @override
  String get todayNoteDialogTitle => 'Today\'s note';

  @override
  String get todayNoteHint => 'Optional. E.g. slept poorly, short workout…';

  @override
  String get todayNoteLabel => 'How did it go?';

  @override
  String get habitsTitle => 'Habits';

  @override
  String get habitsNewHabit => 'New habit';

  @override
  String get habitsCreateFromScratch => 'Create from scratch';

  @override
  String get habitsUseTemplate => 'Use a routine template';

  @override
  String get habitsShowArchived => 'Show archived';

  @override
  String get habitsHideArchived => 'Hide archived';

  @override
  String get habitsEmptyTitle => 'Start your journey';

  @override
  String get habitsEmptyDescription =>
      'You don\'t have any habits yet. Create your first one to track your progress.';

  @override
  String get habitsCreateFirstButton => 'Create first habit';

  @override
  String get habitsArchivedEmpty => 'No archived habits';

  @override
  String get habitsArchivedEmptyDescription =>
      'When you archive a habit it appears here without losing its history.';

  @override
  String get habitsLoadError => 'Error loading habits.';

  @override
  String get habitsActionEdit => 'Edit';

  @override
  String get habitsActionArchive => 'Archive';

  @override
  String get habitsActionUnarchive => 'Unarchive';

  @override
  String get habitsActionDelete => 'Delete';

  @override
  String get habitsFreqEveryDay => 'Every day';

  @override
  String get habitsFreqWeekdays => 'Mon – Fri';

  @override
  String habitsFreqTimesPerWeek(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '${count}x per week',
      one: '1x per week',
    );
    return '$_temp0';
  }

  @override
  String get habitsDeleteConfirmTitle => 'Delete habit?';

  @override
  String get habitsDeleteConfirmBody =>
      'The habit and all its history will be permanently removed.';

  @override
  String get habitsArchivedLabel => 'Archived';

  @override
  String get habitFormCreate => 'New habit';

  @override
  String get habitFormEdit => 'Edit habit';

  @override
  String get habitFormName => 'Name';

  @override
  String get habitFormNameHint => 'E.g. Meditate, Read, Run…';

  @override
  String get habitFormDescription => 'Description (optional)';

  @override
  String get habitFormDescriptionHint => 'Details or motivation';

  @override
  String get habitFormIcon => 'Icon';

  @override
  String get habitFormCategory => 'Category';

  @override
  String get habitFormFrequency => 'Frequency';

  @override
  String get habitFormReminders => 'Reminders';

  @override
  String get habitFormReminderAdd => 'Add';

  @override
  String get habitFormCreateButton => 'Create';

  @override
  String get habitFormSaveButton => 'Save';

  @override
  String get habitFormNameRequired => 'Please enter the habit name';

  @override
  String get habitFormDayRequired => 'Select at least one day of the week';

  @override
  String get habitFormCategoryInfoTitle => 'How categories work';

  @override
  String get habitFormCategoryGlobalTitle => 'Global';

  @override
  String get habitFormCategoryGlobalDescription =>
      'Created by the admin and available to everyone. They can\'t be edited.';

  @override
  String get habitFormCategoryMineTitle => 'Mine';

  @override
  String get habitFormCategoryMineDescription =>
      'Created by you, visible only to you. Manage them in Settings → Manage categories.';

  @override
  String get historyTitle => 'History';

  @override
  String get historyPeriod7 => '7 days';

  @override
  String get historyPeriod30 => '30 days';

  @override
  String get historyPeriod90 => '90 days';

  @override
  String get historyPeriodAll => 'All';

  @override
  String get historyCheckIns => 'Check-ins';

  @override
  String get historyScheduledDays => 'Scheduled days';

  @override
  String get historyBestStreak => 'Best streak';

  @override
  String get historyAdherence => 'Adherence';

  @override
  String historyStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
      zero: '0 days',
    );
    return '$_temp0';
  }

  @override
  String get historyEmptyTitle => 'No records';

  @override
  String get historyEmptyDescription =>
      'When you check in, your history appears here.';

  @override
  String get historyNoHabitsTitle => 'Start your journey';

  @override
  String get historyNoHabitsDescription =>
      'You don\'t have any habits yet. Create your first one to track your progress.';

  @override
  String get historyChartWeeklyTitle => 'Weekly adherence';

  @override
  String get historyChartWeeklySubtitle =>
      '% of scheduled days you completed each week';

  @override
  String get historyHeatmapTitle => 'Habit map';

  @override
  String get historyHeatmapSubtitle =>
      'Each square is a day. Green = check-in.';

  @override
  String get historyWeekdayTitle => 'Check-ins by weekday';

  @override
  String get historyWeekdaySubtitle => 'On which days you\'re more consistent.';

  @override
  String get historyInsight => 'Insight';

  @override
  String historyReminderHint(String habit, String time, String current) {
    return 'You usually check in \"$habit\" around $time, but the reminder is at $current. Want to adjust?';
  }

  @override
  String historyReminderApply(String time) {
    return 'Adjust to $time';
  }

  @override
  String historyReminderApplied(String time) {
    return 'Reminder adjusted to $time';
  }

  @override
  String get historyReminderError => 'Couldn\'t adjust.';

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
  String get historyDoneStatus => 'done';

  @override
  String get historyMissedStatus => 'no check-in';

  @override
  String get profileEditName => 'Save name';

  @override
  String get profileDataAccount => 'Account data';

  @override
  String get profileNameLabel => 'Name';

  @override
  String get profileNameUpdated => 'Name updated!';

  @override
  String get profileNameUpdateError => 'Error updating name.';

  @override
  String get profileChangePassword => 'Change password';

  @override
  String get profileChangePasswordButton => 'Change password';

  @override
  String get profileCurrentPassword => 'Current password';

  @override
  String get profilePasswordChanged => 'Password changed successfully!';

  @override
  String get profilePasswordChangeError => 'Error changing password.';

  @override
  String get profileNameEmpty => 'Name can\'t be empty';

  @override
  String get profileNameMinLength => 'Name must have at least 2 characters';

  @override
  String get profileCurrentPasswordRequired => 'Enter the current password';

  @override
  String get profileNewPasswordTooShort =>
      'New password must have at least 6 characters';

  @override
  String get profilePasswordsDoNotMatch => 'Passwords don\'t match';

  @override
  String get profileLogout => 'Sign out';

  @override
  String get profileDeleteAccount => 'Delete my account';

  @override
  String get profileDeleteConfirmTitle => 'Delete my account?';

  @override
  String get profileDeleteConfirmBody =>
      'This action is permanent. All your habits, records and categories will be removed. It cannot be undone.';

  @override
  String get profileDeleteConfirmAction => 'Delete';

  @override
  String get profileDeleteError => 'Failed to delete account.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsManageCategories => 'Manage categories';

  @override
  String get settingsManageCategoriesSubtitle => 'Create and edit your own';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeAppTitle => 'App theme';

  @override
  String get settingsThemeLight => 'Always light';

  @override
  String get settingsThemeDark => 'Always dark';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageAppTitle => 'App language';

  @override
  String get settingsLanguagePortuguese => 'Português';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageSpanish => 'Español';

  @override
  String get settingsBackup => 'Backup and data';

  @override
  String get settingsBackupSubtitle => 'Export and import';

  @override
  String get settingsTestNotification => 'Test notification';

  @override
  String get settingsTestNotificationSubtitle => 'Triggers a notification now';

  @override
  String get settingsEmailIntegration => 'E-mail integration';

  @override
  String get settingsEmailConfigured => 'Mailtrap configured';

  @override
  String get settingsEmailNotConfigured => 'Not configured';

  @override
  String get settingsMailtrapTitle => 'E-mail integration';

  @override
  String get settingsMailtrapSubtitle => 'Mailtrap Sandbox credentials';

  @override
  String get settingsMailtrapToken => 'API Token';

  @override
  String get settingsMailtrapTokenHint => 'Mailtrap API token';

  @override
  String get settingsMailtrapInbox => 'Inbox ID';

  @override
  String get settingsMailtrapInboxHint => 'Mailtrap inbox ID';

  @override
  String get settingsMailtrapFromEmail => 'From e-mail';

  @override
  String get settingsMailtrapFromEmailHint => 'e.g. noreply@sah.app';

  @override
  String get settingsMailtrapFromName => 'From name';

  @override
  String get settingsMailtrapFromNameHint => 'e.g. SAH Team';

  @override
  String get settingsMailtrapFillAll => 'Fill all fields.';

  @override
  String get settingsMailtrapSaved => 'Mailtrap configured!';

  @override
  String get settingsMailtrapClear => 'Clear configuration';

  @override
  String get backupTitle => 'Backup and data';

  @override
  String get backupSubtitle => 'Keep your data safe';

  @override
  String get backupExportTitle => 'Export data';

  @override
  String get backupExportDescription =>
      'Generates a JSON file with your habits, records and categories.';

  @override
  String get backupExportNow => 'Export now';

  @override
  String get backupExportError => 'Failed to export.';

  @override
  String backupExportShareError(String message) {
    return 'Error sharing: $message';
  }

  @override
  String get backupImportTitle => 'Import backup';

  @override
  String get backupImportDescription =>
      'Replaces your data with the file\'s contents. Destructive action.';

  @override
  String get backupImportSelect => 'Choose file';

  @override
  String get backupImportConfirmTitle => 'Import backup?';

  @override
  String get backupImportConfirmBody =>
      'All your current habits, records and categories will be replaced by those in the file. This action cannot be undone.';

  @override
  String get backupImportInvalid => 'Invalid file.';

  @override
  String get backupImportSuccess => 'Backup imported successfully!';

  @override
  String backupImportReadError(String message) {
    return 'Error reading file: $message';
  }

  @override
  String get backupAutoTitle => 'Automatic backup';

  @override
  String backupAutoLast(String when) {
    return 'Last: $when';
  }

  @override
  String get backupAutoNever => 'Never';

  @override
  String get onboardingWelcomeTitle => 'Welcome to SAH';

  @override
  String get onboardingWelcomeDescription =>
      'The place to create, remember and celebrate your habits. Start small, stay consistent.';

  @override
  String get onboardingRemindersTitle => 'Reminders that fit your routine';

  @override
  String get onboardingRemindersDescription =>
      'Set as many times as you want for each habit. Notifications fire only on the days you choose.';

  @override
  String get onboardingProgressTitle => 'See your evolution';

  @override
  String get onboardingProgressDescription =>
      'Streaks, adherence and history — all in the app, saved only on your device.';

  @override
  String onboardingSuggestionsTitle(String nome) {
    return 'Welcome, $nome!';
  }

  @override
  String get onboardingSuggestionsTitleFallback => 'Welcome!';

  @override
  String get onboardingSuggestionsSubtitle =>
      'Pick the habits that match you. You can adjust everything later.';

  @override
  String onboardingStartButton(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Start with $count habits',
      one: 'Start with 1 habit',
      zero: 'Select at least one habit',
    );
    return '$_temp0';
  }

  @override
  String onboardingFailedHabits(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count habits failed to create.',
      one: '1 habit failed to create.',
    );
    return '$_temp0';
  }

  @override
  String get onboardingHintTitle => 'Start with suggestions';

  @override
  String get onboardingHintBody =>
      'You don\'t have any habits yet. Pick a few to start — takes less than a minute.';

  @override
  String get onboardingHintAction => 'See suggestions';

  @override
  String get templatesTitle => 'Routine templates';

  @override
  String get templatesSubtitle =>
      'Create several habits at once. You can edit everything later.';

  @override
  String templatesAppliedSuccess(int count) {
    return 'Template applied: $count habits created!';
  }

  @override
  String templatesAppliedPartial(int created, int failed) {
    return 'Created $created, $failed failed.';
  }

  @override
  String templatesCount(int count, String description) {
    return '$count habits · $description';
  }

  @override
  String get categoriesEmptyTitle => 'No categories';

  @override
  String get categoriesEmptyDescription =>
      'Create your first category to organize your habits.';

  @override
  String get categoriesNewCategory => 'New category';

  @override
  String get categoriesNameLabel => 'Name';

  @override
  String get categoriesNameHint => 'E.g. Health, Work…';

  @override
  String get categoriesColorLabel => 'Color';

  @override
  String get categoriesGlobalLabel => 'Global';

  @override
  String get categoriesGlobalDescription => 'Available to all users';

  @override
  String get categoriesEditCategory => 'Edit category';

  @override
  String get categoriesDeleteConfirmTitle => 'Delete category?';

  @override
  String get categoriesDeleteConfirmBody =>
      'The category will be removed. Linked habits will become uncategorized.';

  @override
  String get categoriesDeleteError => 'Couldn\'t delete.';

  @override
  String get categoriesCreated => 'Category created!';

  @override
  String get categoriesUpdated => 'Category updated!';

  @override
  String get categoriesDeleted => 'Category deleted!';

  @override
  String get adminDashboardTitle => 'Dashboard';

  @override
  String get adminDashboardSubtitle => 'Platform overview';

  @override
  String get adminDashboardTotalUsers => 'Total users';

  @override
  String get adminDashboardActiveUsers => 'Active users';

  @override
  String get adminDashboardBlockedUsers => 'Blocked';

  @override
  String get adminDashboardTotalHabits => 'Total habits';

  @override
  String get adminDashboardAvgAdherence => 'Average adherence';

  @override
  String get adminDashboardAvgStreak => 'Average streak (days)';

  @override
  String get adminDashboardQuickAccess => 'Quick access';

  @override
  String get adminUsersTitle => 'Users';

  @override
  String get adminUsersSearchHint => 'Search by name or e-mail';

  @override
  String get adminUsersFilterAll => 'All';

  @override
  String get adminUsersFilterActive => 'Active';

  @override
  String get adminUsersFilterBlocked => 'Blocked';

  @override
  String get adminUsersBlockButton => 'Block';

  @override
  String get adminUsersUnblockButton => 'Unblock';

  @override
  String get adminUsersPromoteAdmin => 'Make admin';

  @override
  String get adminUsersRevokeAdmin => 'Remove admin';

  @override
  String get adminUsersOwnerBadge => 'Owner';

  @override
  String get adminUsersAdminBadge => 'Admin';

  @override
  String get adminUsersBlockedBadge => 'Blocked';

  @override
  String get adminUsersActiveBadge => 'Active';

  @override
  String get adminUsersBlockReasonLabel => 'Block reason';

  @override
  String get adminUsersBlockReasonHint => 'E.g. spam, abuse, inactive account…';

  @override
  String get adminUsersConfirmBlock => 'Block user';

  @override
  String adminUsersBlockModalSubtitle(String nome) {
    return '$nome\'s account will be inaccessible until unblocked.';
  }

  @override
  String get adminUsersBlockReasonRequired => 'Provide the reason for blocking';

  @override
  String get adminUsersLoadError => 'Error loading users';

  @override
  String get adminUsersEmptyTitle => 'No users found';

  @override
  String get adminUsersEmptyDescription =>
      'Try adjusting filters or your search term.';

  @override
  String get adminUsersDemoteTitle => 'Remove admin?';

  @override
  String adminUsersDemoteBody(String nome) {
    return '$nome will lose access to the admin panel.';
  }

  @override
  String get adminCategoriesTitle => 'Global categories';

  @override
  String get adminCategoriesShortTitle => 'Categories';

  @override
  String get adminCategoriesSubtitle => 'Available to all users';

  @override
  String get adminCategoriesNewButton => 'New';

  @override
  String get adminCategoriesLoadError => 'Error loading categories';

  @override
  String get adminCategoriesEmptyTitle => 'No categories yet';

  @override
  String get adminCategoriesEmptyDescription =>
      'Create the first global category for users.';

  @override
  String get adminCategoriesCreateButton => 'Create category';

  @override
  String get adminCategoriesInUseTitle => 'Category in use';

  @override
  String adminCategoriesInUseBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'This category is linked to $count habits. Delete anyway?',
      one: 'This category is linked to 1 habit. Delete anyway?',
    );
    return '$_temp0';
  }

  @override
  String get adminCategoriesForceDelete => 'Delete anyway';

  @override
  String get adminCategoriesDeleteTitle => 'Delete category?';

  @override
  String get adminCategoriesDeleteBody => 'This action cannot be undone.';

  @override
  String get adminCategoriesFormEditTitle => 'Edit category';

  @override
  String get adminCategoriesFormNewTitle => 'New category';

  @override
  String get adminCategoriesFormNameLabel => 'Name';

  @override
  String get adminCategoriesFormNameHint => 'E.g.: Exercise, Reading…';

  @override
  String get adminCategoriesFormNameRequired => 'Provide the category name';

  @override
  String get adminCategoriesFormColorLabel => 'Color';

  @override
  String get adminCategoriesFormCreate => 'Create';

  @override
  String get adminCategoriesGlobalBadge => 'Global';

  @override
  String adminCategoriesHabitCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count habits',
      one: '1 habit',
      zero: '0 habits',
    );
    return '$_temp0';
  }

  @override
  String get userCategoriesTitle => 'My categories';

  @override
  String get userCategoriesYourSection => 'Your categories';

  @override
  String get userCategoriesGlobalsSection => 'Global';

  @override
  String get userCategoriesGlobalsHint => 'Available to everyone — read-only.';

  @override
  String get userCategoriesEmptyTitle => 'No personal categories';

  @override
  String get userCategoriesEmptyDescription =>
      'Create your own categories to organize your habits.';

  @override
  String get userCategoriesCreateFirst => 'Create the first one';

  @override
  String get errorScreenTitle => 'Something went wrong.';

  @override
  String get errorScreenDescription => 'Couldn\'t load this page. Try again.';

  @override
  String errorScreenRef(String code) {
    return 'Ref: $code';
  }

  @override
  String get errorScreenGoHome => 'Go to start';

  @override
  String get adminLogsTitle => 'System logs';

  @override
  String get adminLogsEmpty => 'No logs found';

  @override
  String get adminLogsEmptyFiltered =>
      'No event of this type was recorded. Clear filters to see everything.';

  @override
  String get adminLogsEmptyAll => 'No events recorded yet.';

  @override
  String get adminLogsFilterAll => 'All';

  @override
  String get adminLogsFilterLogin => 'Login';

  @override
  String get adminLogsFilterSignup => 'Signup';

  @override
  String get adminLogsFilterBlock => 'Block';

  @override
  String get adminLogsFilterAdmin => 'Admin';

  @override
  String get adminLogsFilterError => 'Errors';

  @override
  String get adminLogsTypeLogin => 'Login';

  @override
  String get adminLogsTypeLogout => 'Logout';

  @override
  String get adminLogsTypeSignup => 'Signup';

  @override
  String get adminLogsTypeBlock => 'Block';

  @override
  String get adminLogsTypeUnblock => 'Unblock';

  @override
  String get adminLogsTypeError => 'Error';

  @override
  String get adminLogsTypeAdmin => 'Admin';

  @override
  String get adminLogsTypeProfile => 'Profile';

  @override
  String get adminLogsTypePassword => 'Password';

  @override
  String get adminLogsTypeReset => 'Reset';

  @override
  String get adminLogsTypeAccountDeleted => 'Deletion';

  @override
  String get adminLogsTypeBackup => 'Backup';

  @override
  String get tooltipBack => 'Back';

  @override
  String get tooltipSettings => 'Settings';

  @override
  String get tooltipOpenMenu => 'Open menu';

  @override
  String get tooltipLogout => 'Sign out';

  @override
  String get testNotificationTitle => 'Reminder test';

  @override
  String get testNotificationBody =>
      'If you\'re seeing this, notifications are working!';

  @override
  String get permissionDenied =>
      'Notification permission denied. Enable it in system settings.';

  @override
  String get logoutDialogTitle => 'Sign out?';

  @override
  String get logoutDialogBody => 'Do you want to end the session?';

  @override
  String get logoutDialogConfirm => 'Sign out';

  @override
  String get onboardingSuggDrinkWater => 'Drink 2L of water';

  @override
  String get onboardingSuggVitamin => 'Take vitamin';

  @override
  String get onboardingSuggSleep8h => 'Sleep 8 hours';

  @override
  String get onboardingSuggGratitude => 'Write 3 gratitudes';

  @override
  String get onboardingSuggOffline15 => '15min offline';

  @override
  String get onboardingSuggWalkOutdoor => 'Walk outdoors';

  @override
  String get onboardingSuggPlanDay => 'Plan the day';

  @override
  String get onboardingSuggReviewAgenda => 'Review agenda';

  @override
  String get onboardingSuggInboxZero => 'Inbox zero';

  @override
  String get onboardingSuggTrain30 => 'Work out 30min';

  @override
  String get onboardingSuggStretchBeforeSleep => 'Stretch before bed';

  @override
  String get onboardingSuggStairs => 'Take the stairs';

  @override
  String get onboardingSuggRead20Pages => 'Read 20 pages';

  @override
  String get onboardingSuggReadBeforeSleep => 'Read before bed';

  @override
  String get onboardingSuggLearnNewWord => 'Learn a new word';

  @override
  String get onboardingSuggMeditate10 => 'Meditate 10min';

  @override
  String get onboardingSuggConsciousBreathing => 'Mindful breathing 5min';

  @override
  String get onboardingSuggMindfulnessLunch => 'Post-lunch mindfulness';

  @override
  String get templateMorningName => 'Morning routine';

  @override
  String get templateMorningDesc => 'Start the day with 4 short habits.';

  @override
  String get templateStudentName => 'Student';

  @override
  String get templateStudentDesc => 'Balanced study and rest routine.';

  @override
  String get templateHealthyName => 'Healthy life';

  @override
  String get templateHealthyDesc => 'Focus on body and mind.';

  @override
  String get templateRemoteName => 'Remote work';

  @override
  String get templateRemoteDesc =>
      'Keep focus and energy while working from home.';

  @override
  String get templateHabitMorningWater => 'Drink a glass of water';

  @override
  String get templateHabitMorningMeditate => 'Meditate 10min';

  @override
  String get templateHabitMorningStretch => 'Stretch';

  @override
  String get templateHabitMorningPlan => 'Plan the day';

  @override
  String get templateHabitStudentRead => 'Read 20 pages';

  @override
  String get templateHabitStudentReview => 'Review agenda';

  @override
  String get templateHabitStudentLearn => 'Learn a new word';

  @override
  String get templateHabitStudentPomodoro => 'Pomodoro 25min';

  @override
  String get templateHabitHealthyWater => 'Drink 2L of water';

  @override
  String get templateHabitHealthyWalk => 'Walk 30min';

  @override
  String get templateHabitHealthyGratitude => 'Write 3 gratitudes';

  @override
  String get templateHabitHealthySleep => 'Sleep 8 hours';

  @override
  String get templateHabitRemoteInbox => 'Inbox zero in the morning';

  @override
  String get templateHabitRemoteBreak => '5min break every hour';

  @override
  String get templateHabitRemoteNeck => 'Stretch your neck';

  @override
  String get templateHabitRemoteCoffee => 'Slow-paced coffee';
}
