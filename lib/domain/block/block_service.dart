import 'package:sample_flutter_game_with_flame/domain/block/block_repository.dart';
import 'package:sample_flutter_game_with_flame/domain/block/value/block_color.dart';

class BlockService {
  final BlockRepository _repos;

  const BlockService({required BlockRepository repository})
      : _repos = repository;

  Future<bool> isDuplicated(BlockColor color) async {
    final result = await _repos.findByColor(color);
    return result != null;
  }
}
