import 'package:sample_flutter_game_with_flame/domain/player/player.dart';
import 'package:sample_flutter_game_with_flame/domain/player/value/player_name.dart';
import 'package:sample_flutter_game_with_flame/domain/player/value/player_point.dart';

abstract class PlayerFactory {
  Player create({
    required PlayerName name,
    required PlayerPoint point,
  });
}
