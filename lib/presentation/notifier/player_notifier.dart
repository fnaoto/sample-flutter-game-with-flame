import 'package:sample_flutter_game_with_flame/application/block_app_service.dart';
import 'package:sample_flutter_game_with_flame/application/player_app_service.dart';
import 'package:sample_flutter_game_with_flame/application/dto/player_dto.dart';

final playerNotifierFutureProvider = FutureProvider(
  (ref) => PlayerNotifier(
    playerAppService: ref.watch(playerAppService),
    blockAppService: ref.watch(blockAppService),
  ),
);

class PlayerNotifier extends StateNotifier {
  final PlayerAppService _playerAppService;
  final BlockAppService _blockAppService;

  PlayerNotifier({
    required PlayerAppService playerAppService,
    required BlockAppService blockAppService,
  })  : _playerAppService = playerAppService,
        _blockAppService = blockAppService,
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
    await _updatePlayers();
    return _player.id.value;
  }

  Future<void> deletePlayer({required String id}) async {
    await _playerAppService.deletePlayer(id);
    await _updatePlayers();
  }

  Future<void> updatePlayer({required String id}) async {
    final _blocks = await _blockAppService.getPlayerBlocks(id);
    if (_blocks.isEmpty) return;
    final _playerPoints =
        _blocks.map((b) => b!.point).toList().fold<int>(0, (p, c) => p + c);
    await _playerAppService.updatePlayerPoint(id: id, point: _playerPoints);
    await _updatePlayers();
  }

  Future<void> _updatePlayers() async {
    await _playerAppService.getPlayerList().then((list) => playerList = list);
  }
}
