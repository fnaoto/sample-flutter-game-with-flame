import 'package:sample_flutter_game_with_flame/application/player_app_service.dart';
import 'package:sample_flutter_game_with_flame/application/dto/player_dto.dart';

final playerNotifierProvider = StateProvider(
  (ref) => PlayerNotifier(
    playerAppService: ref.watch(playerAppService),
    playerId: "1",
  ),
);

class PlayerNotifier extends StateNotifier<int> {
  final PlayerAppService _playerAppService;

  PlayerNotifier({
    required PlayerAppService playerAppService,
    required String playerId,
  })  : _playerAppService = playerAppService,
        super(0);

  List<PlayerDto> playerList = [];
  List<PlayerDto> get players => List.unmodifiable(playerList);

  Future<void> createPlayer({
    required String name,
    required int point,
  }) async {
    await _playerAppService.createPlayer(
      name: name,
      point: point,
    );
    _updatePlayers();
  }

  Future<void> deletePlayer({required String id}) async {
    await _playerAppService.deletePlayer(id);
    _updatePlayers();
  }

  void _updatePlayers() {
    _playerAppService.getPlayerList().then((list) => playerList = list);
  }
}
