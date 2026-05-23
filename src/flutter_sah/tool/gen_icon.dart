// Gera os PNGs do ícone do app a partir do design do SahLogo.
// Rodar com: dart run tool/gen_icon.dart
//
// Saída:
//   assets/icon/icon.png            (1024x1024, fundo creme — uso geral)
//   assets/icon/icon_foreground.png (1024x1024, transparente — adaptive)
//   assets/icon/icon_splash.png     (1024x1024, transparente — splash)

import 'dart:io';
import 'dart:math' as math;

import 'package:image/image.dart' as img;

const int _size = 1024;

// Paleta SAH (clara)
const _bg = 0xFFFAF7F2; // creme
const _primary = 0xFF4A7C59; // sage
const _streak = 0xFFC89B3C; // dourado
const _bgWhite = 0xFFFFFFFF;

img.ColorRgba8 _rgba(int color, {double alpha = 1.0}) {
  final a = ((color >> 24) & 0xFF) * alpha;
  final r = (color >> 16) & 0xFF;
  final g = (color >> 8) & 0xFF;
  final b = color & 0xFF;
  return img.ColorRgba8(r, g, b, a.round());
}

void _drawCircleFilled(
  img.Image image, {
  required double cx,
  required double cy,
  required double radius,
  required img.ColorRgba8 color,
}) {
  final int x0 = (cx - radius - 1).floor().clamp(0, image.width - 1);
  final int y0 = (cy - radius - 1).floor().clamp(0, image.height - 1);
  final int x1 = (cx + radius + 1).ceil().clamp(0, image.width - 1);
  final int y1 = (cy + radius + 1).ceil().clamp(0, image.height - 1);
  for (var y = y0; y <= y1; y++) {
    for (var x = x0; x <= x1; x++) {
      final dx = x + 0.5 - cx;
      final dy = y + 0.5 - cy;
      final d = math.sqrt(dx * dx + dy * dy);
      // anti-alias 1px
      if (d <= radius - 0.5) {
        _blend(image, x, y, color);
      } else if (d <= radius + 0.5) {
        final coverage = (radius + 0.5 - d).clamp(0.0, 1.0);
        final blended = img.ColorRgba8(
          color.r.toInt(),
          color.g.toInt(),
          color.b.toInt(),
          (color.a * coverage).round(),
        );
        _blend(image, x, y, blended);
      }
    }
  }
}

void _drawRoundedSquircle(
  img.Image image, {
  required double cx,
  required double cy,
  required double w,
  required double h,
  required img.ColorRgba8 color,
}) {
  // Blob com cantos arredondados (squircle aproximado).
  final r = math.min(w, h) / 2;
  _drawCircleFilled(image, cx: cx, cy: cy, radius: r, color: color);
}

void _blend(img.Image image, int x, int y, img.ColorRgba8 src) {
  if (x < 0 || x >= image.width || y < 0 || y >= image.height) return;
  final dst = image.getPixel(x, y);
  final srcA = src.a / 255.0;
  if (srcA <= 0) return;
  if (srcA >= 1.0) {
    image.setPixelRgba(x, y, src.r, src.g, src.b, 255);
    return;
  }
  final dstA = dst.a / 255.0;
  final outA = srcA + dstA * (1 - srcA);
  if (outA <= 0) return;
  final outR = (src.r * srcA + dst.r * dstA * (1 - srcA)) / outA;
  final outG = (src.g * srcA + dst.g * dstA * (1 - srcA)) / outA;
  final outB = (src.b * srcA + dst.b * dstA * (1 - srcA)) / outA;
  image.setPixelRgba(x, y, outR.round(), outG.round(), outB.round(), (outA * 255).round());
}

void _paintLogo(img.Image image, {bool drawBackground = true}) {
  final cx = _size / 2.0;
  final cy = _size / 2.0;

  if (drawBackground) {
    img.fill(image, color: _rgba(_bg));
  }

  // Aura externa (sage 12%)
  _drawCircleFilled(
    image,
    cx: cx,
    cy: cy,
    radius: _size * 0.45,
    color: _rgba(_primary, alpha: 0.16),
  );

  // Blob principal (sage 90%)
  _drawCircleFilled(
    image,
    cx: cx,
    cy: cy,
    radius: _size * 0.31,
    color: _rgba(_primary, alpha: 0.95),
  );

  // Centro creme/branco
  _drawCircleFilled(
    image,
    cx: cx,
    cy: cy,
    radius: _size * 0.10,
    color: _rgba(_bgWhite),
  );

  // Dot dourado (streak)
  _drawCircleFilled(
    image,
    cx: _size * 0.685,
    cy: _size * 0.315,
    radius: _size * 0.085,
    color: _rgba(_streak),
  );
}

void main() {
  final outDir = Directory('assets/icon');
  if (!outDir.existsSync()) outDir.createSync(recursive: true);

  // 1) Ícone com fundo creme (uso geral Android)
  final iconBg = img.Image(width: _size, height: _size, numChannels: 4);
  _paintLogo(iconBg, drawBackground: true);
  File('${outDir.path}/icon.png')
      .writeAsBytesSync(img.encodePng(iconBg));
  print('Escreveu assets/icon/icon.png');

  // 2) Foreground transparente (adaptive icon)
  final iconFg = img.Image(width: _size, height: _size, numChannels: 4);
  _paintLogo(iconFg, drawBackground: false);
  File('${outDir.path}/icon_foreground.png')
      .writeAsBytesSync(img.encodePng(iconFg));
  print('Escreveu assets/icon/icon_foreground.png');

  // 3) Splash (mesmo do foreground, transparente)
  File('${outDir.path}/icon_splash.png')
      .writeAsBytesSync(img.encodePng(iconFg));
  print('Escreveu assets/icon/icon_splash.png');
}
