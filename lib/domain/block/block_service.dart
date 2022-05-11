import 'package:sample_flutter_game_with_flame/domain/block/block_repository.dart';

class BlockService {
  final BlockRepository _repos;

  const BlockService({required BlockRepository repository})
      : _repos = repository;

  Future<bool> isDuplicated(BlockId id) async {
    final result = await _repos.findById(id);
    return result != null;
  }
}
