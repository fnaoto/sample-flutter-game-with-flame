import 'package:sample_flutter_game_with_flame/application/player_app_service.dart';
import 'package:sample_flutter_game_with_flame/application/dto/player_dto.dart';

final playerNotifierStateProvider = StateProvider(
  (ref) => PlayerNotifier(
    playerAppService: ref.watch(playerAppService),
  ),
);

class PlayerNotifier extends StateNotifier<int> {
  final PlayerAppService _playerAppService;

  PlayerNotifier({
    required PlayerAppService playerAppService,
  })  : _playerAppService = playerAppService,
        super(0);

  List<PlayerDto> playerList = [];
  List<PlayerDto> get players => List.unmodifiable(playerList);

  Future<String> createPlayer({
    required String name,
    required int point,
  }) async {
    final _player = await _playerAppService.createPlayer(
      name: name,
      point: point,
    );
    _updatePlayers();
    return _player.id.value;
  }

  Future<void> deletePlayer({required String id}) async {
    await _playerAppService.deletePlayer(id);
    _updatePlayers();
  }

  void _updatePlayers() {
    _playerAppService.getPlayerList().then((list) => playerList = list);
  }
}
