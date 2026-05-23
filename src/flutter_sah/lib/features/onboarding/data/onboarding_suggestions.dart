class HabitSuggestion {
  final String nome;
  final String categoriaId;

  const HabitSuggestion(this.nome, this.categoriaId);
}

// IDs casam com os seeds em hive_bootstrap.dart (c1=Saúde, c2=Bem-estar, c3=Produtividade,
// c4=Exercício, c5=Leitura, c6=Meditação).
const onboardingSuggestions = <HabitSuggestion>[
  HabitSuggestion('Beber 2L de água', 'c1'),
  HabitSuggestion('Tomar vitamina', 'c1'),
  HabitSuggestion('Dormir 8 horas', 'c1'),
  HabitSuggestion('Anotar 3 gratidões', 'c2'),
  HabitSuggestion('15min offline', 'c2'),
  HabitSuggestion('Caminhar ao ar livre', 'c2'),
  HabitSuggestion('Planejar o dia', 'c3'),
  HabitSuggestion('Revisar agenda', 'c3'),
  HabitSuggestion('Inbox zero', 'c3'),
  HabitSuggestion('Treinar 30min', 'c4'),
  HabitSuggestion('Alongar antes de dormir', 'c4'),
  HabitSuggestion('Subir escadas', 'c4'),
  HabitSuggestion('Ler 20 páginas', 'c5'),
  HabitSuggestion('Ler antes de dormir', 'c5'),
  HabitSuggestion('Aprender palavra nova', 'c5'),
  HabitSuggestion('Meditar 10min', 'c6'),
  HabitSuggestion('Respiração consciente 5min', 'c6'),
  HabitSuggestion('Mindfulness pós-almoço', 'c6'),
];
