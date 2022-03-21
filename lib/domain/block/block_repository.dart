import 'package:sample_flutter_game_with_flame/domain/block/block.dart';
import 'package:sample_flutter_game_with_flame/domain/block/value/block_color.dart';
import 'package:sample_flutter_game_with_flame/domain/block/value/block_id.dart';
import 'package:sample_flutter_game_with_flame/domain/block/value/block_point.dart';

abstract class BlockRepository {
  Future<T?> transaction<T>(Future<T> Function() f);
  Future<void> remove(Block block);
  Future<void> save(Block block);
  Future<Block?> findById(BlockId id);
  Future<Block?> findByPoint(BlockPoint point);
  Future<Block?> findByColor(BlockColor color);
}
