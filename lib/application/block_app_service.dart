import 'dart:ui';

import 'package:meta/meta.dart';
import 'package:sample_flutter_game_with_flame/application/dto/block_dto.dart';
import 'package:sample_flutter_game_with_flame/common/exception.dart';
import 'package:sample_flutter_game_with_flame/domain/block/block_factory.dart';
import 'package:sample_flutter_game_with_flame/domain/block/block_repository.dart';
import 'package:sample_flutter_game_with_flame/domain/block/block_service.dart';
import 'package:sample_flutter_game_with_flame/domain/block/value/block_color.dart';
import 'package:sample_flutter_game_with_flame/domain/block/value/block_id.dart';
import 'package:sample_flutter_game_with_flame/domain/block/value/block_point.dart';

@immutable
class BlockAppService {
  final BlockFactory _factory;
  final BlockRepository _repository;
  final BlockService _service;

  BlockAppService({
    required BlockFactory factory,
    required BlockRepository repository,
  })  : _factory = factory,
        _repository = repository,
        _service = BlockService(repository: repository);

  Future<void> createBlock({
    required int point,
    required int color,
  }) async {
    final _block = _factory.create(
      point: BlockPoint(point),
      color: BlockColor(color),
    );

    await _repository.transaction<void>(() async {
      if (await _service.isDuplicated(_block.color)) {
        throw DuplicatedException(code: ExceptionCode.block);
      } else {
        await _repository.save(_block);
      }
    });
  }

  Future<void> deleteBlock(String id) async {
    final targetId = BlockId(id);

    await _repository.transaction<void>(() async {
      final target = await _repository.findById(targetId);
      if (target == null) {
        throw NotFoundException(code: ExceptionCode.block);
      }

      await _repository.remove(target);
    });
  }

  Future<BlockDto?> getBlock(String id) async {
    final targetId = BlockId(id);
    final target = await _repository.findById(targetId);

    return target == null ? null : BlockDto(target);
  }
}
