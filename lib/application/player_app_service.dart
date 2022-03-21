import 'package:meta/meta.dart';
import 'package:sample_flutter_game_with_flame/application/dto/player_dto.dart';
import 'package:sample_flutter_game_with_flame/common/exception.dart';
import 'package:sample_flutter_game_with_flame/domain/player/player_factory.dart';
import 'package:sample_flutter_game_with_flame/domain/player/player_repository.dart';
import 'package:sample_flutter_game_with_flame/domain/player/player_service.dart';
import 'package:sample_flutter_game_with_flame/domain/player/value/player_id.dart';
import 'package:sample_flutter_game_with_flame/domain/player/value/player_name.dart';
import 'package:sample_flutter_game_with_flame/domain/player/value/player_point.dart';

@immutable
class PlayerAppService {
  final PlayerFactory _factory;
  final PlayerRepository _repository;
  final PlayerService _service;

  PlayerAppService({
    required PlayerFactory factory,
    required PlayerRepository repository,
  })  : _factory = factory,
        _repository = repository,
        _service = PlayerService(repository: repository);

  Future<void> createPlayer({
    required String name,
    required int point,
  }) async {
    final _player = _factory.create(
      name: PlayerName(name),
      point: PlayerPoint(point),
    );

    await _repository.transaction<void>(() async {
      if (await _service.isDuplicated(_player.name)) {
        throw DuplicatedException(code: ExceptionCode.player);
      } else {
        await _repository.save(_player);
      }
    });
  }

  Future<void> deletePlayer(String id) async {
    final targetId = PlayerId(id);

    await _repository.transaction<void>(() async {
      final target = await _repository.findById(targetId);
      if (target == null) {
        throw NotFoundException(code: ExceptionCode.player);
      }

      await _repository.remove(target);
    });
  }

  Future<PlayerDto?> getPlayer(String id) async {
    final targetId = PlayerId(id);
    final target = await _repository.findById(targetId);

    return target == null ? null : PlayerDto(target);
  }
}
