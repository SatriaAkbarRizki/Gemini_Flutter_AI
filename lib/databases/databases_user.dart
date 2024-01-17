import 'package:aispeak/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabasesUser {
  Database? _database;
  final String _databaseName = 'user_databases.db';

  Future<Database> checkDatabase() async {
    if (_database != null) return _database!;
    _database = await initializeDB();
    return _database!;
  }

  Future<Database> initializeDB() async {
    return openDatabase(
      version: 1,
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) async => await db.execute(
          'CREATE TABLE User(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT NULL, image TEXT NULL)'),
    );
  }

  Future insert(UserModel user) async {
    final Database db = _database!;
    final id = await db.insert('User', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future all() async {
    await checkDatabase();
    final data = await _database!.query('User');
    List<UserModel> result = data.map((e) => UserModel.fromMap(e)).toList();
    return result;
  }

  Future update(UserModel userModel) async {
    await _database!.update(
      'User',
      userModel.toMap(),
      where: 'id = ?',
      whereArgs: [userModel.id],
    );
  }

  Future delete(int index) async {
    await _database!.delete('User', where: 'id = ?', whereArgs: [index]);
  }
}
