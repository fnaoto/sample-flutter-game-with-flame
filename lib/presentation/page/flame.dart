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
  FlamePage(this._playerNotifier, this._blockNotifier);

  final List<Square> _squares = [];
  final PlayerNotifier _playerNotifier;
  final BlockNotifier _blockNotifier;

  late final PlayerDto player;

  Future<void> get createPlayer async {
    final date = DateTime.now();
    player = await _playerNotifier.createPlayer(name: "player $date", point: 0);
  }

  Future<BlockDto> createBlock(int point) async {
    final _id = await _blockNotifier.createBlock(
      point: point,
      isTapped: false,
      needToTap: false,
      playerId: player.id,
    );
    return _blockNotifier.blocks.firstWhere((b) => b.id == _id);
  }

  Future<void> get _updateNeedToTapFlag async {
    if (_squares.isNotEmpty) {
      _squares.sort((a, b) => a.point.compareTo(b.point));
      _blockNotifier.needToTapBlockId = _squares.first.block.id;
    }
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
        final _block = await createBlock(pRand);
        final square = Square(
          vec2,
          pRand,
          _size,
          _blockNotifier,
          _block,
        );
        _squares.add(square);
      }
    }
    await _updateNeedToTapFlag;
    _squares.map((s) async => await add(s)).toList();
  }

  @override
  Future<void> onLoad() async => {
        await createPlayer,
        await createSquares,
      };

  @override
  void onTapUp(int pointerId, TapUpInfo info) async {
    super.onTapUp(pointerId, info);
    await _playerNotifier.updatePlayer(id: player.id);
    if (children.isEmpty) {
      _squares.clear();
      await createSquares;
    }
    if (_blockNotifier.isFailed) {
      _squares.clear();
      pauseEngine();
    } else {
      if (_blockNotifier.tappedBlockId != null) {
        _squares.removeWhere((s) => s.block.id == _blockNotifier.tappedBlockId);
        await _updateNeedToTapFlag;
      }
    }
  }
}

class Square extends TextComponent with Tappable {
  Square(
    Vector2 position,
    this.point,
    this.squareSize,
    this._blockNotifier,
    this.block,
  ) : super(position: position, text: point.toString());

  final int point;
  final double squareSize;
  final BlockNotifier _blockNotifier;
  final BlockDto block;

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
    if (_blockNotifier.needToTapBlockId == block.id) {
      _blockNotifier.tappedBlockId = block.id;
      _blockNotifier.failedBlockId = null;
      removeFromParent();
    } else {
      _blockNotifier.failedBlockId = block.id;
      _blockNotifier.tappedBlockId = null;
      textRenderer = TextPaint(
        style: TextStyle(
          color: BasicPalette.red.color,
          fontWeight: FontWeight.bold,
          fontSize: squareSize - 10,
        ),
      );
    }
    return super.onTapDown(info);
  }
}
