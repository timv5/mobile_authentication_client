import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class Dao {

  static const dbName = 'mobile_authentication_client_db.db';
  static const dbSchema = 'CREATE TABLE stock_notes (id TEXT PRIMARY KEY, title TEXT, body TEXT, create_date datetime, stock_symbol TEXT);';

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await Dao.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<void> delete(String table, String id) async {
    final db = await Dao.database();
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> fetchBySymbol(String table, String stockSymbol) async {
    final db = await Dao.database();
    return db.query(table, where: 'stock_symbol = ?', whereArgs: [stockSymbol]);
  }

  static Future<List<Map<String, dynamic>>> fetchAll(String table) async {
    final db = await Dao.database();
    return db.query(table);
  }

  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, dbName), onCreate: (db, version) {
      return db.execute(dbSchema);
    }, version: 1);
  }

}