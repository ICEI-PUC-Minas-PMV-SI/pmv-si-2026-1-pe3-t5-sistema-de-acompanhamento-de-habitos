import '../../../l10n/app_localizations.dart';

class HabitSuggestion {
  final String nome;
  final String categoriaId;

  const HabitSuggestion(this.nome, this.categoriaId);
}

// IDs casam com os seeds em hive_bootstrap.dart (c1=Saúde, c2=Bem-estar, c3=Produtividade,
// c4=Exercício, c5=Leitura, c6=Meditação).
List<HabitSuggestion> onboardingSuggestionsFor(AppL10n l) => [
      HabitSuggestion(l.onboardingSuggDrinkWater, 'c1'),
      HabitSuggestion(l.onboardingSuggVitamin, 'c1'),
      HabitSuggestion(l.onboardingSuggSleep8h, 'c1'),
      HabitSuggestion(l.onboardingSuggGratitude, 'c2'),
      HabitSuggestion(l.onboardingSuggOffline15, 'c2'),
      HabitSuggestion(l.onboardingSuggWalkOutdoor, 'c2'),
      HabitSuggestion(l.onboardingSuggPlanDay, 'c3'),
      HabitSuggestion(l.onboardingSuggReviewAgenda, 'c3'),
      HabitSuggestion(l.onboardingSuggInboxZero, 'c3'),
      HabitSuggestion(l.onboardingSuggTrain30, 'c4'),
      HabitSuggestion(l.onboardingSuggStretchBeforeSleep, 'c4'),
      HabitSuggestion(l.onboardingSuggStairs, 'c4'),
      HabitSuggestion(l.onboardingSuggRead20Pages, 'c5'),
      HabitSuggestion(l.onboardingSuggReadBeforeSleep, 'c5'),
      HabitSuggestion(l.onboardingSuggLearnNewWord, 'c5'),
      HabitSuggestion(l.onboardingSuggMeditate10, 'c6'),
      HabitSuggestion(l.onboardingSuggConsciousBreathing, 'c6'),
      HabitSuggestion(l.onboardingSuggMindfulnessLunch, 'c6'),
    ];
