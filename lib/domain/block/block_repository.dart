import 'package:sample_flutter_game_with_flame/domain/block/block.dart';

export 'package:sample_flutter_game_with_flame/domain/block/block.dart';

abstract class BlockRepository {
  Future<T?> transaction<T>(Future<T> Function() f);
  Future<void> remove(Block block);
  Future<void> save(Block block);
  Future<List<Block>> findByPlayerId(PlayerId id);
  Future<Block?> findById(BlockId id);
  Future<Block?> findByPoint(BlockPoint point);
  Future<Block?> findByColor(BlockColor color);
  Future<List<Block>> findAll();
}
