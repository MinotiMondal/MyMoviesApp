import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:my_movies_app/data/utils/databaseheiper.dart';
import 'package:my_movies_app/module/main_module/movie/model/MovieResponseModel.dart';

class MovieSyncService {
  // Method to check internet connectivity and sync data
  Future<List<MoviesResponseModel>> syncMovies(List<MoviesResponseModel> apiMovies) async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      // If offline, load from local database
      print('Offline: Fetching movies from local database');
      try {
        final localMovies = await DatabaseHelper.getMovies();
        // Convert the Map data to MoviesResponseModel list
        return localMovies.map((movie) => MoviesResponseModel.fromJson(movie)).toList();
      } catch (e) {
        print('Error fetching local movies: $e');
        return [];
      }
    } else {
      // If online, fetch from API and save to local database
      print('Online: Fetching movies from API and saving to local database');
      try {
        // Save all movies from API to local database
        for (var movie in apiMovies) {
          await DatabaseHelper.insertMovie(movie.toJson());
        }
        return apiMovies; // Return the fetched API movies
      } catch (e) {
        print('Error saving movies to local database: $e');
        return [];
      }
    }
  }
}
