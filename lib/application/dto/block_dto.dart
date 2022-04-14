import 'package:meta/meta.dart';
import 'package:sample_flutter_game_with_flame/domain/block/block.dart';

@immutable
class BlockDto {
  final String id;
  final int point;
  final int color;
  final String playerId;

  BlockDto(Block block)
      : id = block.id.value,
        point = block.point.value,
        color = block.color.value,
        playerId = block.playerId.value;
}
