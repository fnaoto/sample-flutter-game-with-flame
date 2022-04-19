import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_game_with_flame/application/dto/block_dto.dart';
import 'package:sample_flutter_game_with_flame/common/exception.dart';
import 'package:sample_flutter_game_with_flame/domain/block/block_factory.dart';
import 'package:sample_flutter_game_with_flame/domain/block/block_repository.dart';
import 'package:sample_flutter_game_with_flame/domain/block/block_service.dart';
import 'package:sample_flutter_game_with_flame/infrastructure/block/block_factory_impl.dart';
import 'package:sample_flutter_game_with_flame/infrastructure/block/block_repository_impl.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';

final blockAppService = Provider(
  (ref) => BlockAppService(
    repository: ref.watch(blockRepositoryProvider),
    factory: const BlockFactoryImpl(),
  ),
);

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
    required String playerId,
  }) async {
    final _block = _factory.create(
      point: BlockPoint(point),
      color: BlockColor(color),
      playerId: PlayerId(playerId),
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

  Future<List<BlockDto?>> getPlayerBlocks(String playerId) async {
    final targetPlayerId = PlayerId(playerId);
    final targets = await _repository.findByPlayerId(targetPlayerId);
    if (targets.isEmpty) return [];
    return targets.map((t) => BlockDto(t)).toList();
  }

  Future<List<BlockDto>> getBlockList() async {
    final _blocks = await _repository.findAll();
    return _blocks.map((e) => BlockDto(e)).toList();
  }
}
