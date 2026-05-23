import 'package:flutter/material.dart';

// Sombras em tom marrom morno rgba(40,30,20,…), nunca preto neutro
abstract final class SahShadows {
  static final sm = [
    const BoxShadow(
      color: Color.fromRGBO(40, 30, 20, 0.04),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
    const BoxShadow(
      color: Color.fromRGBO(40, 30, 20, 0.06),
      blurRadius: 3,
      offset: Offset(0, 1),
    ),
  ];

  static final md = [
    const BoxShadow(
      color: Color.fromRGBO(40, 30, 20, 0.04),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
    const BoxShadow(
      color: Color.fromRGBO(40, 30, 20, 0.08),
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
  ];

  static final lg = [
    const BoxShadow(
      color: Color.fromRGBO(40, 30, 20, 0.06),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
    const BoxShadow(
      color: Color.fromRGBO(40, 30, 20, 0.12),
      blurRadius: 48,
      offset: Offset(0, 16),
    ),
  ];

  static final focus = [
    const BoxShadow(
      color: Color.fromRGBO(74, 124, 89, 0.2),
      blurRadius: 0,
      spreadRadius: 3,
    ),
  ];
}
