import 'package:sample_flutter_game_with_flame/domain/player/player.dart';
import 'package:sample_flutter_game_with_flame/domain/player/player_factory.dart';
import 'package:uuid/uuid.dart';

class PlayerFactoryImpl implements PlayerFactory {
  const PlayerFactoryImpl();

  @override
  Player create({
    required PlayerName name,
    required PlayerPoint point,
  }) {
    return Player(
      id: PlayerId(const Uuid().v4()),
      name: name,
      point: point,
    );
  }
}
