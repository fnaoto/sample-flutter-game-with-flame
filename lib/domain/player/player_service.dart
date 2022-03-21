import 'package:sample_flutter_game_with_flame/domain/player/player_repository.dart';
import 'package:sample_flutter_game_with_flame/domain/player/value/player_name.dart';

class PlayerService {
  final PlayerRepository _repos;

  const PlayerService({required PlayerRepository repos}) : _repos = repos;

  Future<bool> isDuplicated(PlayerName name) async {
    final result = await _repos.findByName(name);
    return result != null;
  }
}
