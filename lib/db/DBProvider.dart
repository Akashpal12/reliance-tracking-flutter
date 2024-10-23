import 'package:path/path.dart';
import 'package:reliance_sugar_tracking/model/response/login_response.dart';
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
    final path = join(dbPath, "/storage/emulated/0/akash_dev/reliance.db"); // Updated to use the proper path

    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE IF NOT EXISTS user (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        UTID INTEGER,
        UT_USERTYPE TEXT,
        USERID TEXT,
        NAME TEXT,
        MOBILE TEXT,
        FACTID TEXT,  
        F_NAME TEXT,
        F_SHORT TEXT,
        TIMEFROM REAL,
        TIMETO REAL,
        LEAVEFLG TEXT
      )
    ''');
    });
  }

  // Function to get the database instance
  static Database get database {
    return _database;
  }

  Future<void> createUser(UserDetail newUser) async {
    final db = await database;
    try {
      await db.insert('user', newUser.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('Error inserting user: $e');
    }
  }

  Future<List<UserDetail>> getAllUsers() async {
    final db = database;
    final res = await db.query('user');
    List<UserDetail> list = res.isNotEmpty
        ? res.map((c) => UserDetail.fromJson(c)).toList()
        : [];
    return list;
  }

  Future<void> deleteUserTable() async {
    final db = database;
    await db.execute('DELETE FROM user');
    // Optionally, you can also vacuum the database after deleting the table
    await db.execute('VACUUM');
  }
}
