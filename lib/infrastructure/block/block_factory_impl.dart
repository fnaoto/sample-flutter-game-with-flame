import 'package:sample_flutter_game_with_flame/domain/block/block.dart';
import 'package:sample_flutter_game_with_flame/domain/block/block_factory.dart';
import 'package:sample_flutter_game_with_flame/domain/block/value/block_color.dart';
import 'package:sample_flutter_game_with_flame/domain/block/value/block_id.dart';
import 'package:sample_flutter_game_with_flame/domain/block/value/block_point.dart';
import 'package:uuid/uuid.dart';

class BlockFactoryImpl implements BlockFactory {
  const BlockFactoryImpl();

  @override
  Block create({
    required BlockPoint point,
    required BlockColor color,
  }) {
    return Block(
      id: BlockId(const Uuid().v4()),
      point: point,
      color: color,
    );
  }
}
