import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

export 'package:flame/game.dart';

class FlamePage extends FlameGame with HasTappables {
  final List<Square> _squares = [];

  Future<void> get createSquares async {
    final double width = size.x;
    final double height = size.y - kBottomNavigationBarHeight;
    final double _size = width > height ? height / 5 : width / 5;

    final wRange = width * 1 ~/ 3;
    final hRange = height * 1 ~/ 3;

    for (double w = _size / 2; w < width; w += wRange) {
      for (double h = _size / 2; h < height; h += hRange) {
        final wRand = math.Random().nextInt(wRange ~/ 2);
        final hRand = math.Random().nextInt(hRange ~/ 2);
        final pRand = math.Random().nextInt(100);
        final vec2 = Vector2(w + wRand, h + hRand);
        final square = Square(vec2, pRand.toString(), _size);
        _squares.add(square);
      }
    }

    debugPrint("_squares: ${_squares.map((s) => s.position).toList()}");
    _squares.map((s) async => add(s)).toList();
  }

  @override
  Future<void> onLoad() async => createSquares;
}

class Square extends TextComponent with Tappable {
  Square(Vector2 position, String text, this.squareSize)
      : super(position: position, text: text);

  final double squareSize;

  static Paint white = BasicPalette.white.paint();
  static Paint red = BasicPalette.red.paint();
  static Paint blue = BasicPalette.blue.paint();

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), white);
    super.render(canvas);
  }

  @override
  Future<void> onLoad() async {
    textRenderer = TextPaint(
      style: TextStyle(
        color: BasicPalette.black.color,
        fontWeight: FontWeight.bold,
        fontSize: squareSize - 10,
      ),
    );
    size.setValues(squareSize, squareSize);
    anchor = Anchor.center;
    super.onLoad();
  }

  @override
  bool onTapUp(TapUpInfo info) {
    debugPrint("info: ${info.eventPosition.game}");
    removeFromParent();
    return true;
  }
}
