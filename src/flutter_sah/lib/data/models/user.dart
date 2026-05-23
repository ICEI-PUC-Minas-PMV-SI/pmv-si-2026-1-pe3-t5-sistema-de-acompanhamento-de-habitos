class User {
  final String id;
  final String nome;
  final String email;
  final bool isAdmin;
  final bool isOwner;
  final bool isBlocked;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.nome,
    required this.email,
    this.isAdmin = false,
    this.isOwner = false,
    this.isBlocked = false,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> j) => User(
        id: j['id'] as String,
        nome: j['nome'] as String,
        email: j['email'] as String,
        isAdmin: j['is_admin'] as bool? ?? false,
        isOwner: j['is_owner'] as bool? ?? false,
        isBlocked: j['is_blocked'] as bool? ?? false,
        createdAt: DateTime.parse(j['created_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'email': email,
        'is_admin': isAdmin,
        'is_owner': isOwner,
        'is_blocked': isBlocked,
        'created_at': createdAt.toIso8601String(),
      };

  User copyWith({
    String? id,
    String? nome,
    String? email,
    bool? isAdmin,
    bool? isOwner,
    bool? isBlocked,
    DateTime? createdAt,
  }) =>
      User(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        email: email ?? this.email,
        isAdmin: isAdmin ?? this.isAdmin,
        isOwner: isOwner ?? this.isOwner,
        isBlocked: isBlocked ?? this.isBlocked,
        createdAt: createdAt ?? this.createdAt,
      );
}
