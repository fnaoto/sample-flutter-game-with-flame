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
  Future<void> get fetchBlocks async => await _updateBlocks();

  String? tappedBlockId;
  String? failedBlockId;
  String needToTapBlockId = "";

  bool get isFailed => failedBlockId != null;

  Future<String> createBlock({
    required int point,
    required bool isTapped,
    required bool needToTap,
    required String playerId,
  }) async {
    final _blockId = await _blockAppService.createBlock(
      point: point,
      isTapped: isTapped,
      needToTap: needToTap,
      playerId: playerId,
    );
    await _updateBlocks();
    return _blockId;
  }

  Future<BlockDto> updateBlock({
    required String id,
    required int point,
    required bool isTapped,
    required bool needToTap,
    required String playerId,
  }) async {
    await _blockAppService.updateBlock(
      id: id,
      point: point,
      isTapped: isTapped,
      needToTap: needToTap,
      playerId: playerId,
    );
    await _updateBlocks();
    return blocks.firstWhere((b) => b.id == id);
  }

  Future<void> deleteBlock({required String id}) async {
    await _blockAppService.deleteBlock(id);
    await _updateBlocks();
  }

  Future<void> _updateBlocks() async {
    await _blockAppService.getBlockList().then((list) => blockList = list);
  }
}
