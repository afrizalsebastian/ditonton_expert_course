import 'dart:async';

import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tvseries_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblMoviesWatchlist = 'movieswatchlist';
  static const String _tblTvSeriesWatchlist = 'tvserieswatchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblMoviesWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        type TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE  $_tblTvSeriesWatchlist (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT,
        type TEXT
      );
    ''');
  }

  Future<int> insertWatchlistMovies(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_tblMoviesWatchlist, movie.toJson());
  }

  Future<int> removeWatchlistMovies(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblMoviesWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieByIdMovies(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblMoviesWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblMoviesWatchlist);

    return results;
  }

  // TvSeries
  Future<int> insertWatchlistTvSeries(TvSeriesTable tvSeries) async {
    final db = await database;
    return await db!.insert(_tblTvSeriesWatchlist, tvSeries.toJson());
  }

  Future<int> removeWatchlistTvSeries(TvSeriesTable tvSeries) async {
    final db = await database;
    return await db!.delete(
      _tblTvSeriesWatchlist,
      where: 'id = ?',
      whereArgs: [tvSeries.id],
    );
  }

  Future<Map<String, dynamic>?> getTvSeriesByIdTvSeries(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblTvSeriesWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvSerires() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblTvSeriesWatchlist);

    return results;
  }
}
