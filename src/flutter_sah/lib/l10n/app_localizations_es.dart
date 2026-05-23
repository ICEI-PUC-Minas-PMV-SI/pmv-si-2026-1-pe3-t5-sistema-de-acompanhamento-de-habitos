// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppL10nEs extends AppL10n {
  AppL10nEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'SAH';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonEdit => 'Editar';

  @override
  String get commonBack => 'Volver';

  @override
  String get commonOk => 'OK';

  @override
  String get commonNext => 'Siguiente';

  @override
  String get commonSkip => 'Omitir';

  @override
  String get commonContinue => 'Empezar';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get commonLoading => 'Cargando…';

  @override
  String get commonError => 'Algo salió mal.';

  @override
  String get commonRequiredField => 'Campo obligatorio';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get commonConfirm => 'Confirmar';

  @override
  String get commonUnderstood => 'Entendido';

  @override
  String get commonNotNow => 'Ahora no';

  @override
  String get commonRemove => 'Quitar';

  @override
  String get navToday => 'Hoy';

  @override
  String get navHabits => 'Hábitos';

  @override
  String get navHistory => 'Historial';

  @override
  String get navProfile => 'Perfil';

  @override
  String get navAdminDashboard => 'Panel';

  @override
  String get navAdminUsers => 'Usuarios';

  @override
  String get navAdminCategories => 'Categorías';

  @override
  String get navAdminLogs => 'Registros';

  @override
  String get authLoginTitle => 'Inicia sesión';

  @override
  String get authLoginSubtitle => 'Continúa tu camino de hábitos.';

  @override
  String get authEmailLabel => 'Correo';

  @override
  String get authEmailHint => 'tu@correo.com';

  @override
  String get authPasswordLabel => 'Contraseña';

  @override
  String get authPasswordHint => 'Tu contraseña';

  @override
  String get authLoginButton => 'Entrar';

  @override
  String get authForgotPassword => 'Olvidé mi contraseña';

  @override
  String get authNoAccount => '¿Sin cuenta? ';

  @override
  String get authSignupLink => 'Regístrate';

  @override
  String get authSignupTitle => 'Crea tu cuenta';

  @override
  String get authSignupSubtitle => 'Empieza a construir hábitos hoy.';

  @override
  String get authNameLabel => 'Nombre';

  @override
  String get authNameHint => 'Tu nombre';

  @override
  String get authSignupButton => 'Crear cuenta';

  @override
  String get authHaveAccount => '¿Ya tienes cuenta? ';

  @override
  String get authLoginLink => 'Entrar';

  @override
  String get authRecoverTitle => 'Recuperar contraseña';

  @override
  String get authRecoverSubtitle =>
      'Ingresa tu correo y enviaremos un enlace para restablecer tu contraseña.';

  @override
  String get authSendLink => 'Enviar enlace';

  @override
  String get authBackToLogin => 'Volver al inicio de sesión';

  @override
  String get authRecoverSentTitle => 'Enlace enviado.';

  @override
  String get authRecoverSentBody =>
      'Revisa tu bandeja de entrada y haz clic en el enlace recibido para restablecer tu contraseña.';

  @override
  String get authHaveCode => 'Tengo mi código';

  @override
  String get authResetTitle => 'Restablecer contraseña';

  @override
  String get authResetSubtitle =>
      'Pega el código enviado por correo y elige una nueva contraseña.';

  @override
  String get authResetCodeLabel => 'Código de restablecimiento';

  @override
  String get authNewPassword => 'Nueva contraseña';

  @override
  String get authConfirmPassword => 'Confirmar contraseña';

  @override
  String get authResetButton => 'Restablecer';

  @override
  String get authResetSuccess => '¡Contraseña restablecida!';

  @override
  String get authResetError => 'Error al restablecer la contraseña.';

  @override
  String get authRecoverError => 'Error al enviar el correo.';

  @override
  String todayGreetingMorning(String nome) {
    return '¡Buenos días, $nome!';
  }

  @override
  String todayGreetingAfternoon(String nome) {
    return '¡Buenas tardes, $nome!';
  }

  @override
  String todayGreetingEvening(String nome) {
    return '¡Buenas noches, $nome!';
  }

  @override
  String get todayHeading => 'Hábitos de hoy';

  @override
  String get todayFreeDay => '¡Día libre!';

  @override
  String get todayFreeDescription =>
      'Sin hábitos programados para hoy. Disfruta el descanso o crea uno nuevo.';

  @override
  String get todayLoadError => 'Error al cargar hábitos.';

  @override
  String get todayActionSkipDay => 'Saltar hoy';

  @override
  String get todayActionUndoSkip => 'Deshacer salto';

  @override
  String get todayActionAddNote => 'Agregar nota';

  @override
  String get todayActionEditNote => 'Editar nota';

  @override
  String get todayNoteDialogTitle => 'Nota del día';

  @override
  String get todayNoteHint => 'Opcional. Ej.: dormí mal, entreno corto…';

  @override
  String get todayNoteLabel => '¿Cómo fue?';

  @override
  String get habitsTitle => 'Hábitos';

  @override
  String get habitsNewHabit => 'Nuevo hábito';

  @override
  String get habitsCreateFromScratch => 'Crear desde cero';

  @override
  String get habitsUseTemplate => 'Usar plantilla de rutina';

  @override
  String get habitsShowArchived => 'Mostrar archivados';

  @override
  String get habitsHideArchived => 'Ocultar archivados';

  @override
  String get habitsEmptyTitle => 'Empieza tu camino';

  @override
  String get habitsEmptyDescription =>
      'Aún no tienes hábitos. Crea el primero para seguir tu progreso.';

  @override
  String get habitsCreateFirstButton => 'Crear primer hábito';

  @override
  String get habitsArchivedEmpty => 'Sin hábitos archivados';

  @override
  String get habitsArchivedEmptyDescription =>
      'Cuando archives un hábito aparecerá aquí sin perder su historial.';

  @override
  String get habitsLoadError => 'Error al cargar hábitos.';

  @override
  String get habitsActionEdit => 'Editar';

  @override
  String get habitsActionArchive => 'Archivar';

  @override
  String get habitsActionUnarchive => 'Desarchivar';

  @override
  String get habitsActionDelete => 'Eliminar';

  @override
  String get habitsFreqEveryDay => 'Todos los días';

  @override
  String get habitsFreqWeekdays => 'Lun – Vie';

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
  String get habitsDeleteConfirmTitle => '¿Eliminar hábito?';

  @override
  String get habitsDeleteConfirmBody =>
      'El hábito y todo su historial serán eliminados de forma permanente.';

  @override
  String get habitsArchivedLabel => 'Archivado';

  @override
  String get habitFormCreate => 'Nuevo hábito';

  @override
  String get habitFormEdit => 'Editar hábito';

  @override
  String get habitFormName => 'Nombre';

  @override
  String get habitFormNameHint => 'Ej.: Meditar, Leer, Correr…';

  @override
  String get habitFormDescription => 'Descripción (opcional)';

  @override
  String get habitFormDescriptionHint => 'Detalles o motivación';

  @override
  String get habitFormIcon => 'Ícono';

  @override
  String get habitFormCategory => 'Categoría';

  @override
  String get habitFormFrequency => 'Frecuencia';

  @override
  String get habitFormReminders => 'Recordatorios';

  @override
  String get habitFormReminderAdd => 'Agregar';

  @override
  String get habitFormCreateButton => 'Crear';

  @override
  String get habitFormSaveButton => 'Guardar';

  @override
  String get habitFormNameRequired => 'Ingresa el nombre del hábito';

  @override
  String get habitFormDayRequired => 'Selecciona al menos un día de la semana';

  @override
  String get habitFormCategoryInfoTitle => 'Cómo funcionan las categorías';

  @override
  String get habitFormCategoryGlobalTitle => 'Globales';

  @override
  String get habitFormCategoryGlobalDescription =>
      'Creadas por el administrador y disponibles para todos. No se pueden editar.';

  @override
  String get habitFormCategoryMineTitle => 'Mías';

  @override
  String get habitFormCategoryMineDescription =>
      'Creadas por ti, visibles solo para ti. Gestiónalas en Configuraciones → Gestionar categorías.';

  @override
  String get historyTitle => 'Historial';

  @override
  String get historyPeriod7 => '7 días';

  @override
  String get historyPeriod30 => '30 días';

  @override
  String get historyPeriod90 => '90 días';

  @override
  String get historyPeriodAll => 'Todo';

  @override
  String get historyCheckIns => 'Check-ins';

  @override
  String get historyScheduledDays => 'Días programados';

  @override
  String get historyBestStreak => 'Mejor racha';

  @override
  String get historyAdherence => 'Adherencia';

  @override
  String historyStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días',
      one: '1 día',
      zero: '0 días',
    );
    return '$_temp0';
  }

  @override
  String get historyEmptyTitle => 'Sin registros';

  @override
  String get historyEmptyDescription =>
      'Cuando hagas check-in, tu historial aparece aquí.';

  @override
  String get historyNoHabitsTitle => 'Empieza tu camino';

  @override
  String get historyNoHabitsDescription =>
      'Aún no tienes hábitos. Crea el primero para seguir tu progreso.';

  @override
  String get historyChartWeeklyTitle => 'Adherencia semanal';

  @override
  String get historyChartWeeklySubtitle =>
      '% de días programados que cumpliste por semana';

  @override
  String get historyHeatmapTitle => 'Mapa de hábitos';

  @override
  String get historyHeatmapSubtitle =>
      'Cada cuadrado es un día. Verde = check-in.';

  @override
  String get historyWeekdayTitle => 'Check-ins por día de la semana';

  @override
  String get historyWeekdaySubtitle => 'En qué días eres más consistente.';

  @override
  String get historyInsight => 'Insight';

  @override
  String historyReminderHint(String habit, String time, String current) {
    return 'Sueles registrar \"$habit\" cerca de las $time, pero el recordatorio es a las $current. ¿Quieres ajustarlo?';
  }

  @override
  String historyReminderApply(String time) {
    return 'Ajustar a las $time';
  }

  @override
  String historyReminderApplied(String time) {
    return 'Recordatorio ajustado a las $time';
  }

  @override
  String get historyReminderError => 'No se pudo ajustar.';

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
  String get historyDoneStatus => 'hecho';

  @override
  String get historyMissedStatus => 'sin check-in';

  @override
  String get profileEditName => 'Guardar nombre';

  @override
  String get profileDataAccount => 'Datos de la cuenta';

  @override
  String get profileNameLabel => 'Nombre';

  @override
  String get profileNameUpdated => '¡Nombre actualizado!';

  @override
  String get profileNameUpdateError => 'Error al actualizar el nombre.';

  @override
  String get profileChangePassword => 'Cambiar contraseña';

  @override
  String get profileChangePasswordButton => 'Cambiar contraseña';

  @override
  String get profileCurrentPassword => 'Contraseña actual';

  @override
  String get profilePasswordChanged => '¡Contraseña cambiada!';

  @override
  String get profilePasswordChangeError => 'Error al cambiar la contraseña.';

  @override
  String get profileNameEmpty => 'El nombre no puede estar vacío';

  @override
  String get profileNameMinLength =>
      'El nombre debe tener al menos 2 caracteres';

  @override
  String get profileCurrentPasswordRequired => 'Ingresa la contraseña actual';

  @override
  String get profileNewPasswordTooShort =>
      'La nueva contraseña debe tener al menos 6 caracteres';

  @override
  String get profilePasswordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get profileLogout => 'Cerrar sesión';

  @override
  String get profileDeleteAccount => 'Eliminar mi cuenta';

  @override
  String get profileDeleteConfirmTitle => '¿Eliminar mi cuenta?';

  @override
  String get profileDeleteConfirmBody =>
      'Esta acción es permanente. Todos tus hábitos, registros y categorías serán eliminados. No se puede deshacer.';

  @override
  String get profileDeleteConfirmAction => 'Eliminar';

  @override
  String get profileDeleteError => 'No se pudo eliminar la cuenta.';

  @override
  String get settingsTitle => 'Configuraciones';

  @override
  String get settingsManageCategories => 'Gestionar categorías';

  @override
  String get settingsManageCategoriesSubtitle => 'Crea y edita las tuyas';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeAppTitle => 'Tema de la app';

  @override
  String get settingsThemeLight => 'Siempre claro';

  @override
  String get settingsThemeDark => 'Siempre oscuro';

  @override
  String get settingsThemeSystem => 'Sistema';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageAppTitle => 'Idioma de la app';

  @override
  String get settingsLanguagePortuguese => 'Português';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageSpanish => 'Español';

  @override
  String get settingsBackup => 'Copia de seguridad';

  @override
  String get settingsBackupSubtitle => 'Exportar e importar';

  @override
  String get settingsTestNotification => 'Probar notificación';

  @override
  String get settingsTestNotificationSubtitle =>
      'Dispara una notificación ahora';

  @override
  String get settingsEmailIntegration => 'Integración de correo';

  @override
  String get settingsEmailConfigured => 'Mailtrap configurado';

  @override
  String get settingsEmailNotConfigured => 'No configurado';

  @override
  String get settingsMailtrapTitle => 'Integración de correo';

  @override
  String get settingsMailtrapSubtitle => 'Credenciales de Mailtrap Sandbox';

  @override
  String get settingsMailtrapToken => 'API Token';

  @override
  String get settingsMailtrapTokenHint => 'Token de API de Mailtrap';

  @override
  String get settingsMailtrapInbox => 'Inbox ID';

  @override
  String get settingsMailtrapInboxHint => 'ID del inbox en Mailtrap';

  @override
  String get settingsMailtrapFromEmail => 'Correo remitente';

  @override
  String get settingsMailtrapFromEmailHint => 'ej.: noreply@sah.app';

  @override
  String get settingsMailtrapFromName => 'Nombre del remitente';

  @override
  String get settingsMailtrapFromNameHint => 'ej.: Equipo SAH';

  @override
  String get settingsMailtrapFillAll => 'Completa todos los campos.';

  @override
  String get settingsMailtrapSaved => '¡Mailtrap configurado!';

  @override
  String get settingsMailtrapClear => 'Limpiar configuración';

  @override
  String get backupTitle => 'Copia de seguridad';

  @override
  String get backupSubtitle => 'Mantén tus datos seguros';

  @override
  String get backupExportTitle => 'Exportar datos';

  @override
  String get backupExportDescription =>
      'Genera un archivo JSON con tus hábitos, registros y categorías.';

  @override
  String get backupExportNow => 'Exportar ahora';

  @override
  String get backupExportError => 'Error al exportar.';

  @override
  String backupExportShareError(String message) {
    return 'Error al compartir: $message';
  }

  @override
  String get backupImportTitle => 'Importar copia';

  @override
  String get backupImportDescription =>
      'Reemplaza tus datos por los del archivo. Acción destructiva.';

  @override
  String get backupImportSelect => 'Elegir archivo';

  @override
  String get backupImportConfirmTitle => '¿Importar copia?';

  @override
  String get backupImportConfirmBody =>
      'Todos tus hábitos, registros y categorías actuales serán reemplazados por los del archivo. Esta acción no se puede deshacer.';

  @override
  String get backupImportInvalid => 'Archivo inválido.';

  @override
  String get backupImportSuccess => '¡Copia importada!';

  @override
  String backupImportReadError(String message) {
    return 'Error al leer el archivo: $message';
  }

  @override
  String get backupAutoTitle => 'Copia automática';

  @override
  String backupAutoLast(String when) {
    return 'Última: $when';
  }

  @override
  String get backupAutoNever => 'Nunca';

  @override
  String get onboardingWelcomeTitle => 'Bienvenido a SAH';

  @override
  String get onboardingWelcomeDescription =>
      'El lugar para crear, recordar y celebrar tus hábitos. Empieza pequeño, mantén la consistencia.';

  @override
  String get onboardingRemindersTitle => 'Recordatorios para tu rutina';

  @override
  String get onboardingRemindersDescription =>
      'Define cuántos horarios quieras por hábito. Las notificaciones suenan solo en los días que elijas.';

  @override
  String get onboardingProgressTitle => 'Mira tu evolución';

  @override
  String get onboardingProgressDescription =>
      'Rachas, adherencia e historial — todo en la app, guardado solo en tu dispositivo.';

  @override
  String onboardingSuggestionsTitle(String nome) {
    return '¡Bienvenido, $nome!';
  }

  @override
  String get onboardingSuggestionsTitleFallback => '¡Bienvenido!';

  @override
  String get onboardingSuggestionsSubtitle =>
      'Elige los hábitos que van contigo. Puedes ajustarlo todo después.';

  @override
  String onboardingStartButton(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Empezar con $count hábitos',
      one: 'Empezar con 1 hábito',
      zero: 'Elige al menos un hábito',
    );
    return '$_temp0';
  }

  @override
  String onboardingFailedHabits(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hábitos fallaron al crearse.',
      one: '1 hábito falló al crearse.',
    );
    return '$_temp0';
  }

  @override
  String get onboardingHintTitle => 'Empieza con sugerencias';

  @override
  String get onboardingHintBody =>
      'Aún no tienes hábitos. Elige algunos para empezar — toma menos de un minuto.';

  @override
  String get onboardingHintAction => 'Ver sugerencias';

  @override
  String get templatesTitle => 'Plantillas de rutina';

  @override
  String get templatesSubtitle =>
      'Crea varios hábitos a la vez. Puedes editarlo todo después.';

  @override
  String templatesAppliedSuccess(int count) {
    return '¡Plantilla aplicada: $count hábitos creados!';
  }

  @override
  String templatesAppliedPartial(int created, int failed) {
    return 'Creados $created, $failed fallaron.';
  }

  @override
  String templatesCount(int count, String description) {
    return '$count hábitos · $description';
  }

  @override
  String get categoriesEmptyTitle => 'Sin categorías';

  @override
  String get categoriesEmptyDescription =>
      'Crea tu primera categoría para organizar tus hábitos.';

  @override
  String get categoriesNewCategory => 'Nueva categoría';

  @override
  String get categoriesNameLabel => 'Nombre';

  @override
  String get categoriesNameHint => 'Ej.: Salud, Trabajo…';

  @override
  String get categoriesColorLabel => 'Color';

  @override
  String get categoriesGlobalLabel => 'Global';

  @override
  String get categoriesGlobalDescription =>
      'Disponible para todos los usuarios';

  @override
  String get categoriesEditCategory => 'Editar categoría';

  @override
  String get categoriesDeleteConfirmTitle => '¿Eliminar categoría?';

  @override
  String get categoriesDeleteConfirmBody =>
      'La categoría será eliminada. Los hábitos vinculados quedarán sin categoría.';

  @override
  String get categoriesDeleteError => 'No se pudo eliminar.';

  @override
  String get categoriesCreated => '¡Categoría creada!';

  @override
  String get categoriesUpdated => '¡Categoría actualizada!';

  @override
  String get categoriesDeleted => '¡Categoría eliminada!';

  @override
  String get adminDashboardTitle => 'Panel';

  @override
  String get adminDashboardSubtitle => 'Vista general de la plataforma';

  @override
  String get adminDashboardTotalUsers => 'Total de usuarios';

  @override
  String get adminDashboardActiveUsers => 'Usuarios activos';

  @override
  String get adminDashboardBlockedUsers => 'Bloqueados';

  @override
  String get adminDashboardTotalHabits => 'Total de hábitos';

  @override
  String get adminDashboardAvgAdherence => 'Adherencia media';

  @override
  String get adminDashboardAvgStreak => 'Racha promedio (días)';

  @override
  String get adminDashboardQuickAccess => 'Acceso rápido';

  @override
  String get adminUsersTitle => 'Usuarios';

  @override
  String get adminUsersSearchHint => 'Buscar por nombre o correo';

  @override
  String get adminUsersFilterAll => 'Todos';

  @override
  String get adminUsersFilterActive => 'Activos';

  @override
  String get adminUsersFilterBlocked => 'Bloqueados';

  @override
  String get adminUsersBlockButton => 'Bloquear';

  @override
  String get adminUsersUnblockButton => 'Desbloquear';

  @override
  String get adminUsersPromoteAdmin => 'Hacer admin';

  @override
  String get adminUsersRevokeAdmin => 'Quitar admin';

  @override
  String get adminUsersOwnerBadge => 'Owner';

  @override
  String get adminUsersAdminBadge => 'Admin';

  @override
  String get adminUsersBlockedBadge => 'Bloqueado';

  @override
  String get adminUsersActiveBadge => 'Activo';

  @override
  String get adminUsersBlockReasonLabel => 'Motivo del bloqueo';

  @override
  String get adminUsersBlockReasonHint => 'Ej.: spam, abuso, cuenta inactiva…';

  @override
  String get adminUsersConfirmBlock => 'Bloquear usuario';

  @override
  String adminUsersBlockModalSubtitle(String nome) {
    return 'La cuenta de $nome quedará inaccesible hasta ser desbloqueada.';
  }

  @override
  String get adminUsersBlockReasonRequired => 'Indica el motivo del bloqueo';

  @override
  String get adminUsersLoadError => 'Error al cargar los usuarios';

  @override
  String get adminUsersEmptyTitle => 'Ningún usuario encontrado';

  @override
  String get adminUsersEmptyDescription =>
      'Prueba ajustar los filtros o el término de búsqueda.';

  @override
  String get adminUsersDemoteTitle => '¿Quitar admin?';

  @override
  String adminUsersDemoteBody(String nome) {
    return '$nome perderá acceso al panel administrativo.';
  }

  @override
  String get adminCategoriesTitle => 'Categorías globales';

  @override
  String get adminCategoriesShortTitle => 'Categorías';

  @override
  String get adminCategoriesSubtitle => 'Disponibles para todos los usuarios';

  @override
  String get adminCategoriesNewButton => 'Nueva';

  @override
  String get adminCategoriesLoadError => 'Error al cargar las categorías';

  @override
  String get adminCategoriesEmptyTitle => 'Ninguna categoría';

  @override
  String get adminCategoriesEmptyDescription =>
      'Crea la primera categoría global para los usuarios.';

  @override
  String get adminCategoriesCreateButton => 'Crear categoría';

  @override
  String get adminCategoriesInUseTitle => 'Categoría en uso';

  @override
  String adminCategoriesInUseBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Esta categoría está vinculada a $count hábitos. ¿Eliminar de todos modos?',
      one:
          'Esta categoría está vinculada a 1 hábito. ¿Eliminar de todos modos?',
    );
    return '$_temp0';
  }

  @override
  String get adminCategoriesForceDelete => 'Eliminar de todos modos';

  @override
  String get adminCategoriesDeleteTitle => '¿Eliminar categoría?';

  @override
  String get adminCategoriesDeleteBody => 'Esta acción no puede deshacerse.';

  @override
  String get adminCategoriesFormEditTitle => 'Editar categoría';

  @override
  String get adminCategoriesFormNewTitle => 'Nueva categoría';

  @override
  String get adminCategoriesFormNameLabel => 'Nombre';

  @override
  String get adminCategoriesFormNameHint => 'Ej: Ejercicio, Lectura…';

  @override
  String get adminCategoriesFormNameRequired =>
      'Indica el nombre de la categoría';

  @override
  String get adminCategoriesFormColorLabel => 'Color';

  @override
  String get adminCategoriesFormCreate => 'Crear';

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
  String get userCategoriesTitle => 'Mis categorías';

  @override
  String get userCategoriesYourSection => 'Tus categorías';

  @override
  String get userCategoriesGlobalsSection => 'Globales';

  @override
  String get userCategoriesGlobalsHint =>
      'Disponibles para todos — solo lectura.';

  @override
  String get userCategoriesEmptyTitle => 'Ninguna categoría personal';

  @override
  String get userCategoriesEmptyDescription =>
      'Crea categorías propias para organizar tus hábitos.';

  @override
  String get userCategoriesCreateFirst => 'Crear la primera';

  @override
  String get errorScreenTitle => 'Algo salió mal.';

  @override
  String get errorScreenDescription =>
      'No fue posible cargar esta página. Inténtalo nuevamente.';

  @override
  String errorScreenRef(String code) {
    return 'Ref: $code';
  }

  @override
  String get errorScreenGoHome => 'Ir al inicio';

  @override
  String get adminLogsTitle => 'Registros del sistema';

  @override
  String get adminLogsEmpty => 'Sin registros';

  @override
  String get adminLogsEmptyFiltered =>
      'No se registró ningún evento de este tipo. Limpia los filtros para ver todos.';

  @override
  String get adminLogsEmptyAll => 'Aún no se registraron eventos.';

  @override
  String get adminLogsFilterAll => 'Todos';

  @override
  String get adminLogsFilterLogin => 'Login';

  @override
  String get adminLogsFilterSignup => 'Registro';

  @override
  String get adminLogsFilterBlock => 'Bloqueo';

  @override
  String get adminLogsFilterAdmin => 'Admin';

  @override
  String get adminLogsFilterError => 'Errores';

  @override
  String get adminLogsTypeLogin => 'Login';

  @override
  String get adminLogsTypeLogout => 'Logout';

  @override
  String get adminLogsTypeSignup => 'Registro';

  @override
  String get adminLogsTypeBlock => 'Bloqueo';

  @override
  String get adminLogsTypeUnblock => 'Desbloqueo';

  @override
  String get adminLogsTypeError => 'Error';

  @override
  String get adminLogsTypeAdmin => 'Admin';

  @override
  String get adminLogsTypeProfile => 'Perfil';

  @override
  String get adminLogsTypePassword => 'Contraseña';

  @override
  String get adminLogsTypeReset => 'Reseteo';

  @override
  String get adminLogsTypeAccountDeleted => 'Eliminación';

  @override
  String get adminLogsTypeBackup => 'Backup';

  @override
  String get tooltipBack => 'Volver';

  @override
  String get tooltipSettings => 'Configuraciones';

  @override
  String get tooltipOpenMenu => 'Abrir menú';

  @override
  String get tooltipLogout => 'Cerrar sesión';

  @override
  String get testNotificationTitle => 'Prueba de recordatorio';

  @override
  String get testNotificationBody =>
      '¡Si estás viendo esto, las notificaciones funcionan!';

  @override
  String get permissionDenied =>
      'Permiso de notificación denegado. Actívalo en las configuraciones del sistema.';

  @override
  String get logoutDialogTitle => '¿Cerrar sesión?';

  @override
  String get logoutDialogBody => '¿Quieres finalizar la sesión?';

  @override
  String get logoutDialogConfirm => 'Cerrar sesión';
}
