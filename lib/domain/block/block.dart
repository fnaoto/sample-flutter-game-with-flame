import 'package:sample_flutter_game_with_flame/domain/block/value/block_id.dart';
import 'package:sample_flutter_game_with_flame/domain/block/value/block_point.dart';
import 'package:sample_flutter_game_with_flame/domain/player/value/player_id.dart';
import 'package:sample_flutter_game_with_flame/domain/block/value/block_is_tapped.dart';
import 'package:sample_flutter_game_with_flame/domain/block/value/block_need_to_tap.dart';

export 'package:sample_flutter_game_with_flame/domain/player/value/player_id.dart';
export 'package:sample_flutter_game_with_flame/domain/block/value/block_id.dart';
export 'package:sample_flutter_game_with_flame/domain/block/value/block_point.dart';
export 'package:sample_flutter_game_with_flame/domain/block/value/block_is_tapped.dart';
export 'package:sample_flutter_game_with_flame/domain/block/value/block_need_to_tap.dart';

class Block {
  final BlockId id;
  BlockPoint _point;
  PlayerId _playerId;
  BlockIsTapped _isTapped;
  BlockNeedToTap _needToTap;

  Block({
    required this.id,
    required BlockPoint point,
    required BlockIsTapped isTapped,
    required BlockNeedToTap needToTap,
    required PlayerId playerId,
  })  : _point = point,
        _isTapped = isTapped,
        _needToTap = needToTap,
        _playerId = playerId;

  BlockPoint get point => _point;
  PlayerId get playerId => _playerId;
  BlockIsTapped get isTapped => _isTapped;
  BlockNeedToTap get needToTap => _needToTap;

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

  void changeIsTapped(BlockIsTapped isTapped) {
    _isTapped = isTapped;
  }

  void changeNeedToTap(BlockNeedToTap needToTap) {
    _needToTap = needToTap;
  }
}
