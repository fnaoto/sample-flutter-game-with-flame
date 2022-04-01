import 'package:sample_flutter_game_with_flame/domain/block/block.dart';
import 'package:sample_flutter_game_with_flame/domain/block/block_factory.dart';
import 'package:uuid/uuid.dart';

class BlockFactoryImpl implements BlockFactory {
  const BlockFactoryImpl();

  @override
  Block create({
    required BlockPoint point,
    required BlockColor color,
    required PlayerId playerId,
  }) {
    return Block(
      id: BlockId(const Uuid().v4()),
      point: point,
      color: color,
      playerId: playerId,
    );
  }
}
