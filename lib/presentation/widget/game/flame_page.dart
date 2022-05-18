import 'dart:math' as math;

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:sample_flutter_game_with_flame/presentation/notifier/block_notifier.dart';
import 'package:sample_flutter_game_with_flame/presentation/notifier/player_notifier.dart';
import 'package:sample_flutter_game_with_flame/presentation/widget/game/square.dart';

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

  Future<void> get _updateFlagOfNeedToTap async {
    if (_squares.isNotEmpty) {
      _squares.sort((a, b) => a.point.compareTo(b.point));
      final _maxPointBlockIds = _squares
          .takeWhile((value) => _squares.first.point == value.point)
          .map((e) => e.block.id)
          .toList();
      _blockNotifier.needToTapBlockIds.addAll(_maxPointBlockIds);
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
    await _updateFlagOfNeedToTap;
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
        await _updateFlagOfNeedToTap;
      }
    }
  }
}
