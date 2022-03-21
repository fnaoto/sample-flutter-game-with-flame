import 'package:sample_flutter_game_with_flame/domain/block/value/block_color.dart';
import 'package:sample_flutter_game_with_flame/domain/block/value/block_id.dart';
import 'package:sample_flutter_game_with_flame/domain/block/value/block_point.dart';

class Block {
  final BlockId id;
  final BlockColor color;
  BlockPoint _point;

  Block({
    required this.id,
    required this.color,
    required BlockPoint point,
  }) : _point = point;

  BlockPoint get point => _point;

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is Block && other.id == id);

  @override
  int get hashCode => runtimeType.hashCode ^ id.hashCode;

  void changePoint(BlockPoint point) {
    _point = point;
  }
}
