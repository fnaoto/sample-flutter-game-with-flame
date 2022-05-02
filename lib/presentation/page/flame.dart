import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

export 'package:flame/game.dart';

class Flame extends FlameGame with HasTappables {
  Flame({
    required this.screenWidth,
    required this.screenHeight,
  });

  bool running = true;
  double screenWidth;
  double screenHeight;

  @override
  Future<void> onLoad() async {
    final randomWidthRate = math.Random().nextDouble();
    final randomHeightRate = math.Random().nextDouble();
    final vector = Vector2(
      screenWidth * randomWidthRate,
      screenHeight * randomHeightRate,
    );
    add(Circle(vector));
  }

  @override
  void onTapUp(int pointerId, TapUpInfo info) {
    super.onTapUp(pointerId, info);
    if (!info.handled) {
      final gameVectorPosition = info.eventPosition.game;
      add(Circle(gameVectorPosition));
    }
  }
}

class Circle extends PositionComponent with Tappable {
  static const speed = 3;
  static const circleSize = 128.0;

  static Paint white = BasicPalette.white.paint();
  static Paint red = BasicPalette.red.paint();
  static Paint blue = BasicPalette.blue.paint();

  Circle(Vector2 position) : super(position: position);

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(const Offset(100, 100), 30, white);
  }

  @override
  void update(double dt) {
    super.update(dt);
    angle += speed * dt;
    angle %= 2 * math.pi;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size.setValues(circleSize, circleSize);
    anchor = Anchor.center;
  }

  @override
  bool onTapUp(TapUpInfo info) {
    removeFromParent();
    return true;
  }
}
