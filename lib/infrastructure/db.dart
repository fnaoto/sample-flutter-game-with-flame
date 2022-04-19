import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const _dbFile = 'sample_flutter_game_with_flame.db';
const _dbVersion = 1;

final dbProvider = Provider((ref) => DB());

class DB {
  Database? _db;
  Transaction? _txn;

  Future<Database?> open() async {
    final _dbPath = await getDatabasesPath();
    final path = join(_dbPath, _dbFile);

    _db = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE blocks (
            id TEXT NOT NULL,
            color INTEGER NOT NULL,
            point INTEGER NOT NULL,
            playerId TEXT NOT NULL,
            PRIMARY KEY (id)
          )
        ''');

        await db.execute('''
          CREATE TABLE players (
            id TEXT NOT NULL,
            name TEXT NOT NULL,
            point INTEGER NOT NULL,
            PRIMARY KEY (id)
          )
        ''');
      },
    );

    return _db;
  }

  Future<void> dispose() async {
    await _db?.close();
    _db = null;
  }

  Future<T?> transaction<T>(Future<T> Function() f) async {
    if (_db == null) throw Exception("db is null");
    return _db?.transaction<T>((txn) async {
      _txn = txn;
      return await f();
    }).then((v) {
      _txn = null;
      return v;
    });
  }

  Future<List<Map<String, dynamic>>> rawQuery(
    String sql, [
    List<dynamic>? arguments,
  ]) async =>
      await (_txn ?? _db)?.rawQuery(sql, arguments) ?? [];

  Future<void> rawInsert(
    String sql, [
    List<dynamic>? arguments,
  ]) async =>
      await (_txn ?? _db)?.rawInsert(sql, arguments);

  Future<void> rawDelete(
    String sql, [
    List<dynamic>? arguments,
  ]) async =>
      await (_txn ?? _db)?.rawDelete(sql, arguments);
}
