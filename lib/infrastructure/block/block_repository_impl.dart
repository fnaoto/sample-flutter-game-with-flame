import 'package:riverpod/riverpod.dart';
import 'package:sample_flutter_game_with_flame/domain/block/block_repository.dart';
import 'package:sample_flutter_game_with_flame/infrastructure/db.dart';

class BlockRepositoryImpl implements BlockRepository {
  final DB _db;

  const BlockRepositoryImpl({required DB db}) : _db = db;

  Block toBlock(Map<String, dynamic> data) {
    final id = data['id'] as String;
    final color = data['color'] as int;
    final point = data['point'] as int;
    final playerId = data['playerId'] as String;

    return Block(
      id: BlockId(id),
      color: BlockColor(color),
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
  Future<Block?> findByColor(BlockColor color) async {
    final list = await _db.rawQuery(
      'SELECT * FROM blocks WHERE color = ?',
      <int>[color.value],
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
  Future<void> save(Block block) async {
    await _db.rawInsert(
      'INSERT OR REPLACE INTO blocks (id, color, point) VALUES (?, ?, ?)',
      <dynamic>[block.id.value, block.color.value, block.point.value],
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
