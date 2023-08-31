import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final String path = join(await getDatabasesPath(), 'my_database.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE my_table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT,
            password TEXT,
            course TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertData(Map<String, dynamic> data) async {
    final Database db = await instance.database;
    await db.insert('my_table', data);
  }


  Future<List<Map<String, dynamic>>> getAllData() async {
    final Database db = await instance.database;
    return db.query('my_table');
  }
  Future<Map<String, dynamic>> getCurrentUser() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> result = await db.query(
      'my_table',
      orderBy: 'id DESC',
      limit: 1,
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return {};
  }

  Future<bool> login2(String email, String password) async {
    var dbClient = await instance.database;
    var result = await dbClient.query(
      'my_table',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      // User login successful
      return true;
    } else {
      // Invalid credentials
      return false;
    }
  }
}














