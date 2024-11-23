import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_movies_app/data/utils/databaseheiper.dart';
import 'package:my_movies_app/module/main_module/homeMovie/model/homeMovieResponseModel.dart';
import 'package:my_movies_app/module/main_module/homeMovie/views/movies_detailsviews.dart';

class FavouriteViews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MoviesResponseModel>>(
      future: DatabaseHelper.getFavorites(), // Directly call static method
      builder: (context, snapshot) {
        print('Snapshot Connection State: ${snapshot.connectionState}');
        print('Snapshot Data: ${snapshot.data}');

        if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final favoriteMovies = snapshot.data!;
          print('Favorite Movies Count: ${favoriteMovies.length}');

          return ListView.builder(
            itemCount: favoriteMovies.length,
            itemBuilder: (BuildContext context, int index) {
              final movie = favoriteMovies[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  // Add Material widget here
                  color: Colors
                      .transparent, // Set the background color to transparent
                  child: InkWell(
                    onTap: () {
                      Get.to(MovieDetailsViews(), arguments: movie);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 130,
                            width: double.infinity,
                            child: movie.posterUrl != null
                                ? Image.network(
                                    movie.posterUrl!,
                                    fit: BoxFit.fill,
                                  )
                                : Icon(
                                    Icons.broken_image,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  movie.title ?? "Unknown Title",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                //    Icon(Icons.favorite, color: Colors.red),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: Text(
              'No favorites found.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }
      },
    );
  }
}
