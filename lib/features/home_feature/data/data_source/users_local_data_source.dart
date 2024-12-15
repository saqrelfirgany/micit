import 'package:sqflite/sqflite.dart';

import '../models/user_model.dart';
import 'database_helper.dart';


class LocalDataSource {
  Future<Database> get _db async => await DatabaseHelper().database;
   static const String usersTableName = 'users';

  Future<void> cacheUsers(List<UserModel> users) async {
    final db = await _db;
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
    final db = await _db;
    final users = await db.query('users');
    return users.map((json) => UserModel.fromJson(json)).toList();
  }

  Future<void> editUser(UserModel user) async {
    final db = await _db;
    await db.update(
      'users',
      user.toJson(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> addUser(UserModel user) async {
    final db = await _db;
    await db.insert(
      'users',
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteUser(int userId) async {
    final db = await _db;
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  Future<void> clearTable(String tableName) async {
    final db = await _db;
    await db.delete(tableName);
  }
}
