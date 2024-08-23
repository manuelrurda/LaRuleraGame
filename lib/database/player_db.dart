import 'package:la_ruleta/database/database_service.dart';
import 'package:la_ruleta/model/player.dart';
import 'package:sqflite/sqflite.dart';

class PlayerDB {
  final tableName = 'players';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id"    INTEGER NOT NULL,
      "name"  TEXT NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT)
    );""");
  }

  Future<int> create({required String name}) async {
    final database = await DatabaseService().database;
    return await database
        .rawInsert('''INSERT INTO $tableName (name) VALUES (?)''', [name]);
  }

  Future<List<Player>> fetchAll() async {
    final database = await DatabaseService().database;
    final players = await database.rawQuery('''SELECT * FROM $tableName''');
    return players.map((player) => Player.fromSqfliteDatabase(player)).toList();
  }

  Future<void> delete(int id) async {
    final database = await DatabaseService().database;
    await database.rawDelete('''DELETE FROM $tableName WHERE id = ?''', [id]);
  }

  Future<int> count() async {
    final database = await DatabaseService().database;
    final List<Map<String, dynamic>> result =
        await database.rawQuery('''SELECT COUNT(*) AS count FROM $tableName''');
    return result.first['count'] as int;
  }
}
