class ExecutionLog {
  final String id;
  final String habitId;
  final DateTime dataHora;

  const ExecutionLog({
    required this.id,
    required this.habitId,
    required this.dataHora,
  });

  factory ExecutionLog.fromJson(Map<String, dynamic> j) => ExecutionLog(
        id: j['id'] as String,
        habitId: j['habit_id'] as String,
        dataHora: DateTime.parse(j['data_hora'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'habit_id': habitId,
        'data_hora': dataHora.toIso8601String(),
      };
}
