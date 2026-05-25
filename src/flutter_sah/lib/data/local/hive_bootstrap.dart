import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/category.dart';
import '../models/user.dart';
import 'hive_keys.dart';
import 'password_hasher.dart';

class HiveBootstrap {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Future.wait([
      Hive.openBox<String>(HiveBoxes.users),
      Hive.openBox<String>(HiveBoxes.credentials),
      Hive.openBox<String>(HiveBoxes.session),
      Hive.openBox<String>(HiveBoxes.categories),
      Hive.openBox<String>(HiveBoxes.habits),
      Hive.openBox<String>(HiveBoxes.executionLogs),
      Hive.openBox<String>(HiveBoxes.auditLogs),
      Hive.openBox<String>(HiveBoxes.appMeta),
      Hive.openBox<String>(HiveBoxes.passwordResetTokens),
    ]);
    await _seedDefaultOwnerIfEmpty();
    await _seedDefaultCategoriesIfEmpty();
  }

  static Future<void> _seedDefaultOwnerIfEmpty() async {
    final usersBox = Hive.box<String>(HiveBoxes.users);
    if (usersBox.isNotEmpty) return;
    const email = 'eduardo@sah.app';
    const password = 'senha123';
    const id = 'u_owner';
    final owner = User(
      id: id,
      nome: 'Eduardo',
      email: email,
      isAdmin: true,
      isOwner: true,
      createdAt: DateTime(2026, 1, 1),
    );
    await usersBox.put(id, jsonEncode(owner.toJson()));
    await Hive.box<String>(HiveBoxes.credentials).put(
      email,
      jsonEncode({'user_id': id, 'hash': PasswordHasher.hash(password)}),
    );
  }

  static Future<void> _seedDefaultCategoriesIfEmpty() async {
    final box = Hive.box<String>(HiveBoxes.categories);
    if (box.isNotEmpty) return;
    const defaults = [
      {'id': 'c1', 'nome': 'Saúde', 'cor': '#4A7C59', 'is_global': true, 'user_id': null},
      {'id': 'c2', 'nome': 'Bem-estar', 'cor': '#6B5B95', 'is_global': true, 'user_id': null},
      {'id': 'c3', 'nome': 'Produtividade', 'cor': '#5B7FA8', 'is_global': true, 'user_id': null},
      {'id': 'c4', 'nome': 'Exercício', 'cor': '#C89B3C', 'is_global': true, 'user_id': null},
      {'id': 'c5', 'nome': 'Leitura', 'cor': '#B8544A', 'is_global': true, 'user_id': null},
      {'id': 'c6', 'nome': 'Meditação', 'cor': '#4A7C59', 'is_global': true, 'user_id': null},
    ];
    for (final c in defaults) {
      final cat = Category.fromJson(c as Map<String, dynamic>);
      await box.put(cat.id, jsonEncode(cat.toJson()));
    }
  }
}
