import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/user_model.dart';

class LocalDataSource {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    return openDatabase(
      join(path, 'users.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, email TEXT, first_name TEXT, last_name TEXT, avatar TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> cacheUsers(List<UserModel> users) async {
    final db = await database;
    await db.delete('users');
    for (var user in users) {
      await db.insert(
        'users',
        user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<UserModel>> getCachedUsers() async {
    final db = await database;
    final users = await db.query('users');
    return users.map((json) => UserModel.fromJson(json)).toList();
  }
}
