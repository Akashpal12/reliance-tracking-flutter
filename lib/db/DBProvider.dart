import 'dart:io';
import 'package:path/path.dart';
import 'package:reliance_sugar_tracking/model/response/UserData.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static late Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  static Future<void> initialize() async {
    _database = await _initDB();
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "reliance.db");

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
  CREATE TABLE IF NOT EXISTS user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    UTID INTEGER,
    UT_USERTYPE TEXT,
    USERID TEXT,
    NAME TEXT,
    MOBILE TEXT,
    FACTID INTEGER,
    F_NAME TEXT,
    F_SHORT TEXT,
    GPS_FLG TEXT,
    TIMEFROM TEXT,
    TIMETO TEXT,
    LEAVEFLG TEXT
  )
  ''');
    });
  }

  // Function to get the database instance
  static Database get database {
    return _database;
  }

  createUser(UserTable newUser) async {
    final db = await database;
    try {
      await db.insert('user', newUser.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('Error inserting user: $e');
    }
  }

  Future<int> deleteUser(int uCode) async {
    final db = database;
    return await db.delete('user', where: 'uCode = ?', whereArgs: [uCode]);
  }

  Future<List<UserTable>> getAllUsers() async {
    final db = database;
    final res = await db.query('user');
    List<UserTable> list =
        res.isNotEmpty ? res.map((c) => UserTable.fromJson(c)).toList() : [];
    return list;
  }

  Future<void> deleteUserTable() async {
    final db = database;
    await db.execute('DELETE FROM user');
    // Optionally, you can also vacuum the database after deleting the table
    await db.execute('VACUUM');
  }
}
