import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TemplateHabit {
  final String nome;
  final String categoriaId;
  final String icone;
  final List<String> lembretes;

  const TemplateHabit({
    required this.nome,
    required this.categoriaId,
    required this.icone,
    this.lembretes = const [],
  });
}

class HabitTemplate {
  final String id;
  final String nome;
  final String descricao;
  final IconData icone;
  final Color cor;
  final List<TemplateHabit> habitos;

  const HabitTemplate({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.icone,
    required this.cor,
    required this.habitos,
  });
}

const habitTemplates = <HabitTemplate>[
  HabitTemplate(
    id: 'morning',
    nome: 'Rotina matinal',
    descricao: 'Comece o dia com 4 hábitos curtos.',
    icone: PhosphorIconsRegular.sunHorizon,
    cor: Color(0xFFC89B3C),
    habitos: [
      TemplateHabit(nome: 'Beber um copo de água', categoriaId: 'c1', icone: 'drop', lembretes: ['07:00']),
      TemplateHabit(nome: 'Meditar 10min', categoriaId: 'c6', icone: 'brain', lembretes: ['07:15']),
      TemplateHabit(nome: 'Alongar', categoriaId: 'c4', icone: 'barbell'),
      TemplateHabit(nome: 'Planejar o dia', categoriaId: 'c3', icone: 'pen', lembretes: ['08:00']),
    ],
  ),
  HabitTemplate(
    id: 'student',
    nome: 'Estudante',
    descricao: 'Rotina balanceada de estudo e descanso.',
    icone: PhosphorIconsRegular.book,
    cor: Color(0xFF5B7FA8),
    habitos: [
      TemplateHabit(nome: 'Ler 20 páginas', categoriaId: 'c5', icone: 'book', lembretes: ['19:00']),
      TemplateHabit(nome: 'Revisar agenda', categoriaId: 'c3', icone: 'pen'),
      TemplateHabit(nome: 'Aprender palavra nova', categoriaId: 'c5', icone: 'brain'),
      TemplateHabit(nome: 'Pomodoro 25min', categoriaId: 'c3', icone: 'alarm'),
    ],
  ),
  HabitTemplate(
    id: 'healthy',
    nome: 'Vida saudável',
    descricao: 'Foco em corpo e mente.',
    icone: PhosphorIconsRegular.heart,
    cor: Color(0xFF4A7C59),
    habitos: [
      TemplateHabit(nome: 'Beber 2L de água', categoriaId: 'c1', icone: 'drop'),
      TemplateHabit(nome: 'Caminhar 30min', categoriaId: 'c4', icone: 'bicycle', lembretes: ['18:00']),
      TemplateHabit(nome: 'Anotar 3 gratidões', categoriaId: 'c2', icone: 'sparkle', lembretes: ['21:30']),
      TemplateHabit(nome: 'Dormir 8 horas', categoriaId: 'c1', icone: 'moon'),
    ],
  ),
  HabitTemplate(
    id: 'remote',
    nome: 'Trabalho remoto',
    descricao: 'Mantém foco e energia trabalhando de casa.',
    icone: PhosphorIconsRegular.coffee,
    cor: Color(0xFF6B5B95),
    habitos: [
      TemplateHabit(nome: 'Inbox zero pela manhã', categoriaId: 'c3', icone: 'chat', lembretes: ['09:00']),
      TemplateHabit(nome: 'Pausa de 5min a cada hora', categoriaId: 'c2', icone: 'alarm'),
      TemplateHabit(nome: 'Alongar pescoço', categoriaId: 'c4', icone: 'barbell'),
      TemplateHabit(nome: 'Café com calma', categoriaId: 'c2', icone: 'coffee'),
    ],
  ),
];
