import 'package:riverpod/riverpod.dart';
import 'package:sample_flutter_game_with_flame/application/block_app_service.dart';
import 'package:sample_flutter_game_with_flame/application/dto/block_dto.dart';

class BlockNotifier extends StateNotifier<int> {
  final BlockAppService _blockAppService;
  final String _playerId;

  BlockNotifier({
    required BlockAppService blockAppService,
    required String playerId,
  })  : _blockAppService = blockAppService,
        _playerId = playerId,
        super(0);

  List<BlockDto> blockList = [];
  List<BlockDto> get blocks => List.unmodifiable(blockList);

  Future<void> createBlock({
    required int color,
    required int point,
    required String playerId,
  }) async {
    await _blockAppService.createBlock(
      point: point,
      color: color,
      playerId: playerId,
    );
    _updateBlocks();
  }

  Future<void> deleteBlock({required String id}) async {
    await _blockAppService.deleteBlock(id);
    _updateBlocks();
  }

  void _updateBlocks() {
    _blockAppService.getBlockList(_playerId).then((list) => blockList = list);
  }
}
