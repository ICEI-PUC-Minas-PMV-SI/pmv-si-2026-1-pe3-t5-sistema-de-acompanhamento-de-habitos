class Habit {
  final String id;
  final String userId;
  final String nome;
  final String descricao;
  final List<int> frequencia; // 0=dom, 1=seg, ..., 6=sáb
  final String? categoriaId;
  final bool ativo;
  final bool arquivado;
  final List<String> lembretes; // ['08:00', '20:00'] — HH:mm
  final String? icone; // nome simbólico do ícone (ex.: 'drop', 'book')

  const Habit({
    required this.id,
    required this.userId,
    required this.nome,
    this.descricao = '',
    this.frequencia = const [1, 2, 3, 4, 5],
    this.categoriaId,
    this.ativo = true,
    this.arquivado = false,
    this.lembretes = const [],
    this.icone,
  });

  factory Habit.fromJson(Map<String, dynamic> j) => Habit(
        id: j['id'] as String,
        userId: j['user_id'] as String,
        nome: j['nome'] as String,
        descricao: j['descricao'] as String? ?? '',
        frequencia: (j['frequencia'] as List<dynamic>?)
                ?.map((e) => e as int)
                .toList() ??
            [1, 2, 3, 4, 5],
        categoriaId: j['categoria_id'] as String?,
        ativo: j['ativo'] as bool? ?? true,
        arquivado: j['arquivado'] as bool? ?? false,
        lembretes: (j['lembretes'] as List<dynamic>?)?.cast<String>() ?? const [],
        icone: j['icone'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'nome': nome,
        'descricao': descricao,
        'frequencia': frequencia,
        'categoria_id': categoriaId,
        'ativo': ativo,
        'arquivado': arquivado,
        'lembretes': lembretes,
        'icone': icone,
      };

  Habit copyWith({
    String? id,
    String? userId,
    String? nome,
    String? descricao,
    List<int>? frequencia,
    String? categoriaId,
    bool? ativo,
    bool? arquivado,
    List<String>? lembretes,
    String? icone,
  }) =>
      Habit(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        nome: nome ?? this.nome,
        descricao: descricao ?? this.descricao,
        frequencia: frequencia ?? this.frequencia,
        categoriaId: categoriaId ?? this.categoriaId,
        ativo: ativo ?? this.ativo,
        arquivado: arquivado ?? this.arquivado,
        lembretes: lembretes ?? this.lembretes,
        icone: icone ?? this.icone,
      );
}
