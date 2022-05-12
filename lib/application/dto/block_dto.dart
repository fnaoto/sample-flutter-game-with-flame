import 'package:meta/meta.dart';
import 'package:sample_flutter_game_with_flame/domain/block/block.dart';

@immutable
class BlockDto {
  final String id;
  final int point;
  final bool isTapped;
  final bool needToTap;
  final String playerId;

  BlockDto(Block block)
      : id = block.id.value,
        point = block.point.value,
        isTapped = block.isTapped.value,
        needToTap = block.needToTap.value,
        playerId = block.playerId.value;
}
