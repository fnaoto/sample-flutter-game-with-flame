import 'package:sample_flutter_game_with_flame/domain/player/player.dart';

abstract class PlayerFactory {
  Player create({required int point});
}
