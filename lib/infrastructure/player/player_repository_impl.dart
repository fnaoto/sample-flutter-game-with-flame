import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_game_with_flame/domain/player/player_repository.dart';
import 'package:sample_flutter_game_with_flame/infrastructure/db.dart';

final playerRepositoryProvider = Provider(
  (ref) => PlayerRepositoryImpl(
    db: ref.watch(dbProvider),
  ),
);

class PlayerRepositoryImpl implements PlayerRepository {
  final DB _db;

  const PlayerRepositoryImpl({required DB db}) : _db = db;

  Player toPlayer(Map<String, dynamic> data) {
    final id = data['id'] as String;
    final name = data['name'] as String;
    final point = data['point'] as int;

    return Player(
      id: PlayerId(id),
      name: PlayerName(name),
      point: PlayerPoint(point),
    );
  }

  @override
  Future<T?> transaction<T>(Future<T> Function() f) async {
    return await _db.transaction<T>(() async => await f());
  }

  @override
  Future<Player?> findById(PlayerId id) async {
    final list = await _db.rawQuery(
      'SELECT * FROM players WHERE id = ?',
      <String>[id.value],
    );

    return list.isEmpty ? null : toPlayer(list[0]);
  }

  @override
  Future<Player?> findByName(PlayerName name) async {
    final list = await _db.rawQuery(
      'SELECT * FROM players WHERE name = ?',
      <String>[name.value],
    );

    return list.isEmpty ? null : toPlayer(list[0]);
  }

  @override
  Future<List<Player>> findAll() async {
    final list = await _db.rawQuery(
      'SELECT * FROM players ORDER BY name',
    );

    return list.isEmpty ? [] : list.map((data) => toPlayer(data)).toList();
  }

  @override
  Future<void> save(Player player) async {
    await _db.rawInsert(
      'INSERT OR REPLACE INTO players (id, name, point) VALUES (?, ?, ?)',
      <dynamic>[player.id.value, player.name.value, player.point.value],
    );
  }

  @override
  Future<void> remove(Player player) async {
    await _db.rawDelete(
      'DELETE FROM players WHERE id = ?',
      <String>[player.id.value],
    );
  }
}
