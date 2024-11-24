import 'package:get/get.dart';
import 'package:my_movies_app/module/main_module/movie/controller/movie_controller.dart';
import 'package:my_movies_app/module/main_module/movie/views/movies_detailsviews.dart';

class HomeBindings extends Bindings{
  @override
  void dependencies(){
    HomeController homeController = Get.put(HomeController());
    MovieDetailsViews movieDetailsViews = Get.put(MovieDetailsViews());

  }
}