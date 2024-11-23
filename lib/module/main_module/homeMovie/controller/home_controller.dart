import 'package:get/get.dart';
import 'package:my_movies_app/data/utils/connectivityplus.dart';
import 'package:my_movies_app/data/utils/databaseheiper.dart';
import 'package:my_movies_app/data/utils/moviesyncservice.dart';
import 'package:my_movies_app/module/main_module/homeMovie/model/homeMovieResponseModel.dart';
import 'package:my_movies_app/module/main_module/homeMovie/service/home_service.dart';

class HomeController extends GetxController {
  late HomeServiceProvider homeServiceProvider = Get.put(HomeServiceProvider());
  RxList<MoviesResponseModel> movieList = <MoviesResponseModel>[].obs;
  final MovieSyncService _movieSyncService = MovieSyncService();

  /// Getter for favorite movies
  RxList<MoviesResponseModel> get favoriteMovies =>
      movieList.where((movie) => movie.isFavorite.value).toList().obs;

  @override
  void onInit() {
    super.onInit();
    callApi();
    fetchMovies();

  }

  /// Call API to fetch movies and update their favorite status
callApi() async {

      // Fetch movies from the API
      await homeServiceProvider.myMoviesGet();

      // Sync favorites with the local database

  }
  // Fetch movies from the API or local database
  Future<void> fetchMovies() async {
    try {
      bool isOnline = await checkInternetConnection();
      if (isOnline) {
        // Fetch movies from the API and sync with local database
        List<MoviesResponseModel> apiMovies = await fetchMoviesFromApi();
        await _movieSyncService.syncMovies(apiMovies);  // Save movies to the local database
        movieList.assignAll(apiMovies);
      } else {
        // Fetch movies from the local database if offline
        List<Map<String, dynamic>> localMovies = await DatabaseHelper.getMovies();
        movieList.assignAll(localMovies.map((movie) => MoviesResponseModel.fromJson(movie)).toList());
      }
    } catch (e) {
      print("Error fetching movies: $e");
    }
  }

  // Fetch movies from the API (replace this with your actual API request)
  Future<List<MoviesResponseModel>> fetchMoviesFromApi() async {
    // Replace with your actual API request
    return [];
  }

  // Toggle favorite status for a movie
  void toggleFavorite(MoviesResponseModel movie) async {
    movie.isFavorite.value = !movie.isFavorite.value;

    if (movie.isFavorite.value) {
      await DatabaseHelper.addToFavorites(movie.toJson());
    } else {
      await DatabaseHelper.removeFromFavorites(movie.toJson());
    }

    movieList.refresh();  // Refresh the UI
  }
}
