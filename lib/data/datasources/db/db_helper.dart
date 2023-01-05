import 'dart:async';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/table_movie.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/table_tv.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static DBHelper? _dbHelper;
  DBHelper._instanced() {
    _dbHelper = this;
  }
  factory DBHelper() => _dbHelper ?? DBHelper._instanced();
  static Database? _db;

  Future<Database?> get databaseMov async {
    if (_db == null) {
      _db = await _initDbs();
    }
    return _db;
  }

  Future<Database> _initDbs() async {
    final filepath = await getDatabasesPath();
    final dbPath = '$filepath/ditonton.database';

    var database = await openDatabase(dbPath, version: 2, onCreate: _onCreate);
    return database;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE watchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE watchlisttv (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> addWatchlistMovie(TableMovie themovies) async {
    final database = await databaseMov;
    return await database!.insert('watchlist', themovies.toJson());
  }

  Future<int> deleteWatchlistMovie(TableMovie themovies) async {
    final database = await databaseMov;
    return await database!.delete(
      'watchlist',
      where: 'id = ?',
      whereArgs: [themovies.idMovie],
    );
  }

  Future<Map<String, dynamic>?> getMoviesId(int idMovie) async {
    final database = await databaseMov;
    final theresult = await database!.query(
      'watchlist',
      where: 'id = ?',
      whereArgs: [idMovie],
    );
      return checkTheResult(theresult);
  }

  Future<List<Map<String, dynamic>>> getWatchlistTheMovie() async {
    final database = await databaseMov;
    final List<Map<String, dynamic>> theresult = await database!.query('watchlist');
    return theresult;
  }

  Future<int> addWatchlistTVShow(TableTV tvShow) async {
    final database = await databaseMov;
    return await database!.insert('watchlisttv', tvShow.toJson());
  }
  Future<List<Map<String, dynamic>>> getWatchlistTVShow() async {
    final database = await databaseMov;
    final List<Map<String, dynamic>> theresult = await database!.query('watchlisttv');
    return theresult;
  }

  Future<Map<String, dynamic>?> getTVShowId(int idTv) async {
    final database = await databaseMov;
    final theresult = await database!.query(
      'watchlisttv',
      where: 'id = ?',
      whereArgs: [idTv],
    );
    return checkTheResult(theresult);
  }

  Future<int> deleteWatchlistTVShow(TableTV tvShow) async {
    final database = await databaseMov;
    return await database!.delete(
      'watchlisttv',
      where: 'id = ?',
      whereArgs: [tvShow.idTv],
    );
  }


  Map<String,dynamic>? checkTheResult(theresult){
    if (theresult.isNotEmpty) {
      return theresult.first;
    } else {
      return null;
    }
  }
}
