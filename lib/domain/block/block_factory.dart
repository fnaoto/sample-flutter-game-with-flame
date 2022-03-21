import 'package:sample_flutter_game_with_flame/domain/block/block.dart';
import 'package:sample_flutter_game_with_flame/domain/block/value/block_color.dart';
import 'package:sample_flutter_game_with_flame/domain/block/value/block_point.dart';

abstract class BlockFactory {
  Block create({
    required BlockPoint point,
    required BlockColor color,
  });
}
