import 'package:sample_flutter_game_with_flame/domain/player/player_repository.dart';

class PlayerService {
  final PlayerRepository _repos;

  const PlayerService({required PlayerRepository repository})
      : _repos = repository;

  Future<bool> isDuplicated(PlayerName name) async {
    final result = await _repos.findByName(name);
    return result != null;
  }
}
