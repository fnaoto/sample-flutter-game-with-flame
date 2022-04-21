import 'package:sample_flutter_game_with_flame/domain/player/player.dart';

export 'package:sample_flutter_game_with_flame/domain/player/player.dart';

abstract class PlayerRepository {
  Future<T?> transaction<T>(Future<T> Function() f);
  Future<void> remove(Player player);
  Future<void> save(Player player);
  Future<Player?> findById(PlayerId id);
  Future<Player?> findByName(PlayerName name);
  Future<List<Player>> findAll();
  Future<List<Player>> findLimit(int limit);
}
