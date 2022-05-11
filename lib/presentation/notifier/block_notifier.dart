import 'package:sample_flutter_game_with_flame/application/block_app_service.dart';
import 'package:sample_flutter_game_with_flame/application/dto/block_dto.dart';

export 'package:sample_flutter_game_with_flame/application/dto/block_dto.dart';

final blockNotifier = StateProvider(
  (ref) => BlockNotifier(
    blockAppService: ref.watch(blockAppService),
  ),
);

class BlockNotifier extends StateNotifier {
  final BlockAppService _blockAppService;

  BlockNotifier({
    required BlockAppService blockAppService,
  })  : _blockAppService = blockAppService,
        super({blockAppService});

  List<BlockDto> blockList = [];
  List<BlockDto> get blocks => List.unmodifiable(blockList);

  Future<void> createBlock({
    required int point,
    required String playerId,
  }) async {
    await _blockAppService.createBlock(
      point: point,
      playerId: playerId,
    );
    _updateBlocks();
  }

  Future<void> deleteBlock({required String id}) async {
    await _blockAppService.deleteBlock(id);
    _updateBlocks();
  }

  void _updateBlocks() {
    _blockAppService.getBlockList().then((list) => blockList = list);
  }
}
