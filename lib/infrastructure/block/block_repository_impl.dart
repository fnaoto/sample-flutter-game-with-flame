import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_game_with_flame/domain/block/block_repository.dart';
import 'package:sample_flutter_game_with_flame/infrastructure/db.dart';

final blockRepositoryProvider = Provider(
  (ref) => BlockRepositoryImpl(
    db: ref.watch(dbProvider),
  ),
);

class BlockRepositoryImpl implements BlockRepository {
  final DB _db;

  const BlockRepositoryImpl({required DB db}) : _db = db;

  Block toBlock(Map<String, dynamic> data) {
    final id = data['id'] as String;
    final point = data['point'] as int;
    final playerId = data['playerId'] as String;

    return Block(
      id: BlockId(id),
      point: BlockPoint(point),
      playerId: PlayerId(playerId),
    );
  }

  @override
  Future<T?> transaction<T>(Future<T> Function() f) async {
    return await _db.transaction<T>(() async => await f());
  }

  @override
  Future<List<Block>> findByPlayerId(PlayerId playerId) async {
    final list = await _db.rawQuery(
      'SELECT * FROM blocks WHERE playerId = ?',
      <String>[playerId.value],
    );

    return list.isEmpty ? [] : list.map((e) => toBlock(e)).toList();
  }

  @override
  Future<Block?> findById(BlockId id) async {
    final list = await _db.rawQuery(
      'SELECT * FROM blocks WHERE id = ?',
      <String>[id.value],
    );

    return list.isEmpty ? null : toBlock(list[0]);
  }

  @override
  Future<Block?> findByPoint(BlockPoint point) async {
    final list = await _db.rawQuery(
      'SELECT * FROM blocks WHERE point = ?',
      <int>[point.value],
    );

    return list.isEmpty ? null : toBlock(list[0]);
  }

  @override
  Future<List<Block>> findAll() async {
    final list = await _db.rawQuery(
      'SELECT * FROM blocks ORDER BY point DESC',
    );

    return list.isEmpty ? [] : list.map((data) => toBlock(data)).toList();
  }

  @override
  Future<void> save(Block block) async {
    await _db.rawInsert(
      'INSERT OR REPLACE INTO blocks (id, point, playerId) VALUES (?, ?, ?)',
      <dynamic>[
        block.id.value,
        block.point.value,
        block.playerId.value,
      ],
    );
  }

  @override
  Future<void> remove(Block block) async {
    await _db.rawDelete(
      'DELETE FROM blocks WHERE id = ?',
      <String>[block.id.value],
    );
  }
}
