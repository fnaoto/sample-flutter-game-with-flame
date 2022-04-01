import 'package:sample_flutter_game_with_flame/domain/player/value/player_id.dart';
import 'package:sample_flutter_game_with_flame/domain/player/value/player_name.dart';
import 'package:sample_flutter_game_with_flame/domain/player/value/player_point.dart';

export 'package:sample_flutter_game_with_flame/domain/player/value/player_id.dart';
export 'package:sample_flutter_game_with_flame/domain/player/value/player_name.dart';
export 'package:sample_flutter_game_with_flame/domain/player/value/player_point.dart';

class Player {
  final PlayerId id;
  PlayerName _name;
  PlayerPoint _point;

  Player({
    required this.id,
    required PlayerPoint point,
    required PlayerName name,
  })  : _point = point,
        _name = name;

  PlayerPoint get point => _point;
  PlayerName get name => _name;

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is Player && other.id == id);

  @override
  int get hashCode => runtimeType.hashCode ^ id.hashCode;

  void changePoint(PlayerPoint point) {
    _point = point;
  }

  void changeName(PlayerName name) {
    _name = name;
  }
}
