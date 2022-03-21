import 'package:sample_flutter_game_with_flame/domain/player/value/player_id.dart';
import 'package:sample_flutter_game_with_flame/domain/player/value/player_point.dart';

class Player {
  final PlayerId id;
  PlayerPoint _point;

  Player({
    required this.id,
    required PlayerPoint point,
  }) : _point = point;

  PlayerPoint get point => _point;

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is Player && other.id == id);

  @override
  int get hashCode => runtimeType.hashCode ^ id.hashCode;

  void changePoint(PlayerPoint point) {
    _point = point;
  }
}
