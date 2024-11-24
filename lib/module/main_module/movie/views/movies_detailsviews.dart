import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_movies_app/module/main_module/movie/controller/movie_controller.dart';

class MovieDetailsViews extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    var movie = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: Get.height * .20,
                decoration: BoxDecoration(
                  color: Colors.pinkAccent[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      child: Image.network(
                        height: Get.height * .130,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        "${movie.posterUrl}", // Ensure it's a valid URL
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("MoviesApp"),
                            Obx(() {
                              return IconButton(
                                icon: Icon(
                                  movie.isFavorite.value
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: movie.isFavorite.value
                                      ? Colors.red
                                      : Colors.white,
                                ),
                                onPressed: () {
                                  controller.toggleFavorite(movie);
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Title : ${movie.title}"),
                  Text("IMDBID :${movie.imdbId}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
