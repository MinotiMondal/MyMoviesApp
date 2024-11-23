import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_movies_app/data/utils/api_manager.dart';
import 'package:my_movies_app/module/main_module/homeMovie/model/homeMovieResponseModel.dart';

class HomeServiceProvider extends GetConnect implements GetxService {
  RxList<MoviesResponseModel> movieList = <MoviesResponseModel>[].obs;
  RxList<MoviesResponseModel> filteredMovies = <MoviesResponseModel>[].obs; // Filtered list for search

  Future<void> myMoviesGet() async {
    try {
      print("API call initiated");
      final Response response = await get('${ApiManager.movieUrl}');
      print("API Response: ${response.bodyString}");

      if (response.statusCode == 200) {
        // Parse the response body as a list
        var checkResponse = json.decode(response.bodyString.toString());
        if (checkResponse is List) {
          // Map each JSON object in the list to MoviesResponseModel
          movieList.value = checkResponse
              .map((movie) => MoviesResponseModel.fromJson(movie))
              .toList()
              .cast<MoviesResponseModel>();

          print("Parsed Movies: ${movieList.length}");
        } else {
          print("Unexpected response format: $checkResponse");
        }
      } else {
        print("Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching movies: $e");
    }
  }

  Future<dynamic>searchMovie(String searchtext) async {
    final Response response = await get("${ApiManager.movieUrl}?title=$searchtext");

    if (response.statusCode == 200) {
       var checkResponse= json.decode(response.bodyString.toString());
        if(checkResponse is List){
          movieList.value = checkResponse.map((movie)=>MoviesResponseModel.fromJson(movie)).toList();
        }
    }
  }
  void searchMovies(String query) {
    if (query.isEmpty) {
      filteredMovies.assignAll(movieList); // Show all movies if query is empty
    } else {
      filteredMovies.assignAll(
        movieList.where((movie) =>
            movie.title!.toLowerCase().contains(query.toLowerCase())).toList(),
      );
    }
  }
}
