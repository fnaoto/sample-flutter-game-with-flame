import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';
import 'package:sample_flutter_game_with_flame/presentation/notifier/block_notifier.dart';

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
    if (_blockNotifier.needToTapBlockIds.contains(block.id)) {
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
