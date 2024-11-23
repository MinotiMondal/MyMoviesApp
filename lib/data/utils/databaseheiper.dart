import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:my_movies_app/module/main_module/homeMovie/model/homeMovieResponseModel.dart';

class DatabaseHelper {
  static Database? _database;

  // Initialize the database
  static Future<Database> get _db async {
    if (_database != null) {
      return _database!;
    }

    // Initialize the database if it's not already initialized
    _database = await _initDatabase();
    return _database!;
  }

  // Open the database and create the table if it doesn't exist
  static Future<Database> _initDatabase() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'movies.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        // Create the movies table when the database is first created
        db.execute('''
          CREATE TABLE movies(
            id INTEGER PRIMARY KEY,
            title TEXT,
            posterUrl TEXT,
            imdbId TEXT,
            isFavorite INTEGER
          )
        ''');
      },
    );
  }

  // Insert movie into the database
  static Future<void> insertMovie(Map<String, dynamic> movie) async {
    final db = await _db;

    // Convert the 'isFavorite' value to 1 for true, 0 for false
    movie['isFavorite'] = movie['isFavorite'] == true ? 1 : 0;

    await db.insert(
      'movies',
      movie,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all movies from the database
  static Future<List<Map<String, dynamic>>> getMovies() async {
    final db = await _db;
    return await db.query('movies');
  }

  // Add a movie to favorites
  static Future<void> addToFavorites(Map<String, dynamic> movie) async {
    final db = await _db;
    movie['isFavorite'] = movie['isFavorite'] == true ? 1 : 0; // Ensure it's an integer
    print('Adding to favorites: $movie'); // Debugging output
    await db.insert(
      'movies',
      movie,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  // Remove a movie from favorites
  static Future<void> removeFromFavorites(Map<String, dynamic> movie) async {
    final db = await _db;
    await db.delete(
      'movies',
      where: 'imdbId = ?',
      whereArgs: [movie['imdbId']],
    );
  }

  // Get all favorite movies from the database
  static Future<List<MoviesResponseModel>> getFavorites() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query('movies', where: 'isFavorite = 1');

    print('Fetched Favorite Movies: $maps');

    return List.generate(maps.length, (i) {
      return MoviesResponseModel.fromJson(maps[i]);
    });
  }

}
