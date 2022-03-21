import 'package:sample_flutter_game_with_flame/domain/player/player.dart';
import 'package:sample_flutter_game_with_flame/domain/player/value/player_id.dart';
import 'package:sample_flutter_game_with_flame/domain/player/value/player_name.dart';

abstract class PlayerRepository {
  Future<T> transaction<T>(Future<T> Function() f);
  Future<void> delete(Player player);
  Future<Player?> findById(PlayerId id);
  Future<Player?> findByName(PlayerName name);
}
