class Category {
  final String id;
  final String nome;
  final String cor; // hex string, ex: '#4A7C59'
  final bool isGlobal;
  final String? userId;

  const Category({
    required this.id,
    required this.nome,
    required this.cor,
    this.isGlobal = false,
    this.userId,
  });

  factory Category.fromJson(Map<String, dynamic> j) => Category(
        id: j['id'] as String,
        nome: j['nome'] as String,
        cor: j['cor'] as String,
        isGlobal: j['is_global'] as bool? ?? false,
        userId: j['user_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'cor': cor,
        'is_global': isGlobal,
        'user_id': userId,
      };

  Category copyWith({
    String? id,
    String? nome,
    String? cor,
    bool? isGlobal,
    String? userId,
  }) =>
      Category(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        cor: cor ?? this.cor,
        isGlobal: isGlobal ?? this.isGlobal,
        userId: userId ?? this.userId,
      );
}
