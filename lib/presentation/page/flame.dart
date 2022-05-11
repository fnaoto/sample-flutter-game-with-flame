import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:sample_flutter_game_with_flame/presentation/notifier/block_notifier.dart';
import 'package:sample_flutter_game_with_flame/presentation/notifier/player_notifier.dart';

export 'package:flame/game.dart';

class FlamePage extends FlameGame with HasTappables {
  FlamePage(this.playerNotifier, this.blockNotifier);

  final List<Square> _squares = [];
  final PlayerNotifier playerNotifier;
  final BlockNotifier blockNotifier;

  late final PlayerDto player;

  Future<void> get createPlayer async {
    final date = DateTime.now();
    final playerId =
        await playerNotifier.createPlayer(name: "player $date", point: 0);
    player = playerNotifier.players.firstWhere((p) => p.id == playerId);
  }

  Future<void> get createSquares async {
    final double width = size.x;
    final double height = size.y - kBottomNavigationBarHeight;
    final double _size = width > height ? height / 5 : width / 5;

    final wRange = width * 1 ~/ 3;
    final hRange = height * 1 ~/ 3;

    for (double x = _size / 2; x < width; x += wRange) {
      for (double y = _size / 2; y < height; y += hRange) {
        final xRand = math.Random().nextInt(wRange ~/ 2);
        final yRand = math.Random().nextInt(hRange ~/ 2);
        final pRand = math.Random().nextInt(100);
        final vec2 = Vector2(x + xRand, y + yRand);
        final square = Square(vec2, pRand.toString(), _size);
        _squares.add(square);
      }
    }

    debugPrint("_squares: ${_squares.map((s) => s.position).toList()}");
    _squares.map((s) async => add(s)).toList();
  }

  @override
  Future<void> onLoad() async => {
        await createSquares,
        await createPlayer,
      };

  @override
  void onTapUp(int pointerId, TapUpInfo info) async {
    super.onTapUp(pointerId, info);
    if (children.isEmpty) {
      await blockNotifier.createBlock(point: 100, playerId: player.id);
      await playerNotifier.updatePlayer(id: player.id);
    }
  }
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
  bool onTapDown(TapDownInfo info) {
    removeFromParent();
    return super.onTapDown(info);
  }
}
