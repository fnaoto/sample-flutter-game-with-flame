import 'package:sample_flutter_game_with_flame/domain/block/value/block_color.dart';
import 'package:sample_flutter_game_with_flame/domain/block/value/block_id.dart';
import 'package:sample_flutter_game_with_flame/domain/block/value/block_point.dart';
import 'package:sample_flutter_game_with_flame/domain/player/value/player_id.dart';

export 'package:sample_flutter_game_with_flame/domain/player/value/player_id.dart';
export 'package:sample_flutter_game_with_flame/domain/block/value/block_color.dart';
export 'package:sample_flutter_game_with_flame/domain/block/value/block_id.dart';
export 'package:sample_flutter_game_with_flame/domain/block/value/block_point.dart';

class Block {
  final BlockId id;
  final BlockColor color;
  BlockPoint _point;
  PlayerId _playerId;

  Block({
    required this.id,
    required this.color,
    required BlockPoint point,
    required PlayerId playerId,
  })  : _point = point,
        _playerId = playerId;

  BlockPoint get point => _point;
  PlayerId get playerId => _playerId;

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is Block && other.id == id);

  @override
  int get hashCode => runtimeType.hashCode ^ id.hashCode;

  void changePoint(BlockPoint point) {
    _point = point;
  }

  void changePlayerId(PlayerId playerId) {
    _playerId = playerId;
  }
}
