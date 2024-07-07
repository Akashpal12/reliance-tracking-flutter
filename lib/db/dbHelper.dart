import 'dart:async';
import 'package:path/path.dart';
import 'package:reliance_sugar_tracking/model/response/UserData.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static final DataBaseHelper instance = DataBaseHelper._init();
  static Database? _database;

  DataBaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb('reliance.db');
    return _database!;
  }

  Future<Database> _initDb(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);
    //final path = '$dbPath/$filepath';
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    final textType = "TEXT NOT NULL";
    final boolType = "BOOLEAN NOT NULL";
    final integerType = "INTEGER NOT NULL";

    await db.execute('''
    CREATE TABLE $UserTName (
    ${UserFields.Id} $idType,
    ${UserFields.UTID} $integerType,
    ${UserFields.UT_USERTYPE} $textType,
    ${UserFields.USERID} $textType,
    ${UserFields.NAME} $textType,
    ${UserFields.MOBILE} $textType,
    ${UserFields.FACTID} $integerType,
    ${UserFields.F_NAME} $textType,
    ${UserFields.F_SHORT} $textType,
    ${UserFields.GPS_FLG} $boolType,
    ${UserFields.TIMEFROM} $integerType,
    ${UserFields.TIMETO} $integerType,
    ${UserFields.LEAVEFLG} $textType,
    )
    ''');
  }

  inserUser(UserTable user) async {
    final db = await instance.database;
    try {
      await db.insert(UserTName, user.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('Error inserting user: $e');
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
