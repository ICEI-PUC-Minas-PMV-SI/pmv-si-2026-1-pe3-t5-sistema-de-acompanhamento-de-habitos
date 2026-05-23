import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../l10n/app_localizations.dart';

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

List<HabitTemplate> habitTemplatesFor(AppL10n l) => [
      HabitTemplate(
        id: 'morning',
        nome: l.templateMorningName,
        descricao: l.templateMorningDesc,
        icone: PhosphorIconsRegular.sunHorizon,
        cor: const Color(0xFFC89B3C),
        habitos: [
          TemplateHabit(nome: l.templateHabitMorningWater, categoriaId: 'c1', icone: 'drop', lembretes: const ['07:00']),
          TemplateHabit(nome: l.templateHabitMorningMeditate, categoriaId: 'c6', icone: 'brain', lembretes: const ['07:15']),
          TemplateHabit(nome: l.templateHabitMorningStretch, categoriaId: 'c4', icone: 'barbell'),
          TemplateHabit(nome: l.templateHabitMorningPlan, categoriaId: 'c3', icone: 'pen', lembretes: const ['08:00']),
        ],
      ),
      HabitTemplate(
        id: 'student',
        nome: l.templateStudentName,
        descricao: l.templateStudentDesc,
        icone: PhosphorIconsRegular.book,
        cor: const Color(0xFF5B7FA8),
        habitos: [
          TemplateHabit(nome: l.templateHabitStudentRead, categoriaId: 'c5', icone: 'book', lembretes: const ['19:00']),
          TemplateHabit(nome: l.templateHabitStudentReview, categoriaId: 'c3', icone: 'pen'),
          TemplateHabit(nome: l.templateHabitStudentLearn, categoriaId: 'c5', icone: 'brain'),
          TemplateHabit(nome: l.templateHabitStudentPomodoro, categoriaId: 'c3', icone: 'alarm'),
        ],
      ),
      HabitTemplate(
        id: 'healthy',
        nome: l.templateHealthyName,
        descricao: l.templateHealthyDesc,
        icone: PhosphorIconsRegular.heart,
        cor: const Color(0xFF4A7C59),
        habitos: [
          TemplateHabit(nome: l.templateHabitHealthyWater, categoriaId: 'c1', icone: 'drop'),
          TemplateHabit(nome: l.templateHabitHealthyWalk, categoriaId: 'c4', icone: 'bicycle', lembretes: const ['18:00']),
          TemplateHabit(nome: l.templateHabitHealthyGratitude, categoriaId: 'c2', icone: 'sparkle', lembretes: const ['21:30']),
          TemplateHabit(nome: l.templateHabitHealthySleep, categoriaId: 'c1', icone: 'moon'),
        ],
      ),
      HabitTemplate(
        id: 'remote',
        nome: l.templateRemoteName,
        descricao: l.templateRemoteDesc,
        icone: PhosphorIconsRegular.coffee,
        cor: const Color(0xFF6B5B95),
        habitos: [
          TemplateHabit(nome: l.templateHabitRemoteInbox, categoriaId: 'c3', icone: 'chat', lembretes: const ['09:00']),
          TemplateHabit(nome: l.templateHabitRemoteBreak, categoriaId: 'c2', icone: 'alarm'),
          TemplateHabit(nome: l.templateHabitRemoteNeck, categoriaId: 'c4', icone: 'barbell'),
          TemplateHabit(nome: l.templateHabitRemoteCoffee, categoriaId: 'c2', icone: 'coffee'),
        ],
      ),
    ];
