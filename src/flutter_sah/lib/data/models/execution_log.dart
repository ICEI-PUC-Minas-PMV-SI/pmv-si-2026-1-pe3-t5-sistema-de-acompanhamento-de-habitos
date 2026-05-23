class ExecutionLog {
  final String id;
  final String habitId;
  final DateTime dataHora;
  final bool frozen; // "pulei o dia de propósito"
  final String? nota;

  const ExecutionLog({
    required this.id,
    required this.habitId,
    required this.dataHora,
    this.frozen = false,
    this.nota,
  });

  factory ExecutionLog.fromJson(Map<String, dynamic> j) => ExecutionLog(
        id: j['id'] as String,
        habitId: j['habit_id'] as String,
        dataHora: DateTime.parse(j['data_hora'] as String),
        frozen: j['frozen'] as bool? ?? false,
        nota: j['nota'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'habit_id': habitId,
        'data_hora': dataHora.toIso8601String(),
        'frozen': frozen,
        'nota': nota,
      };

  ExecutionLog copyWith({
    String? id,
    String? habitId,
    DateTime? dataHora,
    bool? frozen,
    String? nota,
  }) =>
      ExecutionLog(
        id: id ?? this.id,
        habitId: habitId ?? this.habitId,
        dataHora: dataHora ?? this.dataHora,
        frozen: frozen ?? this.frozen,
        nota: nota ?? this.nota,
      );
}
