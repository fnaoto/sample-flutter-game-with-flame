import 'package:meta/meta.dart';
import 'package:sample_flutter_game_with_flame/domain/block/block.dart';

@immutable
class BlockDto {
  final String id;
  final int point;
  final String playerId;

  BlockDto(Block block)
      : id = block.id.value,
        point = block.point.value,
        playerId = block.playerId.value;
}
