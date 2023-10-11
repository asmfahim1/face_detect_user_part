import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper.internal();

  static final DBHelper dbHelper = DBHelper.internal();

  factory DBHelper() => dbHelper;
  static const personInfoTable = 'personInfoTable';
  static const _version = 1;
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'salesforce.db');
    print(dbPath);
    var openDb = await openDatabase(dbPath, version: _version,
        onCreate: (Database db, int version) async {
      await db.execute("""
        CREATE TABLE $personInfoTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          pId VARCHAR(150), 
          examId VARCHAR(150),
          pName VARCHAR(150),
          faveVectorValue VARCHAR(150)
          )""");
    }, onUpgrade: (Database db, int oldversion, int newversion) async {
      if (oldversion < newversion) {
        print("Version Upgrade");
      }
    });
    return openDb;
  }
}
