import 'package:crypto_app_project/data/coin_list/models/favourites.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';

import 'dart:async';

class FavoriteDatabase {
  Database? database;

  Future<void> openDB() async {
    database ??= await openDatabase(
      join(await getDatabasesPath(), 'favorite_database.db'),
      onCreate: (Database db, int version) {
        return db.execute(
          'CREATE TABLE watchlist(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, ids TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertFavorite(FavoriteCoin ids) async {
    await database!.insert(
      'watchlist',
      ids.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavorite(String email, String ids) async {
    await database!.delete(
      'watchlist',
      where: 'email = ? AND ids =?',
      whereArgs: [email, ids],
    );
  }

  Future<List<FavoriteCoin>> getCoinByEmail(String email) async {
    final List<Map<String, dynamic>> maps = await database!
        .query('watchlist', where: 'email = ?', whereArgs: [email]);

    return List.generate(
      maps.length,
      (i) {
        return FavoriteCoin(
          email: maps[i]['email'],
          ids: maps[i]['ids'],
        );
      },
    );
  }

  Future<bool> checkExist(String email, String ids) async {
    final List<Map<String, dynamic>> maps = await database!.query('watchlist',
        where: 'email = ? AND ids =?', whereArgs: [email, ids]);
    bool isExist;
    if (maps.isNotEmpty) {
      isExist = true;
      return isExist;
    } else {
      isExist = false;
      return isExist;
    }
  }

  Future<List<FavoriteCoin>> getCoinByEmailAndCoin(
      String email, String ids) async {
    final List<Map<String, dynamic>> maps = await database!.query('watchlist',
        where: 'email = ? AND ids =?', whereArgs: [email, ids]);
    return List.generate(
      maps.length,
      (i) {
        return FavoriteCoin(
          email: maps[i]['email'],
          ids: maps[i]['ids'],
        );
      },
    );
  }
}
