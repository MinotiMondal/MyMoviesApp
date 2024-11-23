import 'package:get/get.dart';
import 'package:my_movies_app/module/main_module/homeMovie/views/favouriteViews.dart';
import 'package:my_movies_app/module/main_module/homeMovie/bindings/home_bindings.dart';
import 'package:my_movies_app/module/main_module/homeMovie/views/home_views.dart';
import 'package:my_movies_app/module/main_module/homeMovie/views/movies_detailsviews.dart';
import 'package:my_movies_app/module/misc_module/splash/bindings/splash_bindings.dart';
import 'package:my_movies_app/module/misc_module/splash/views/splash_views.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.Splash;
  static final routes = [
    GetPage(
        name: _Paths.SPLASH,
        page: () => SplashView(),
        binding: SplashBindings()),
    GetPage(
        name: _Paths.HOMEVIEW,
        page: () => HomeViews(),
        binding: HomeBindings()),
    GetPage(
        name: _Paths.MOVIEDETAILSVIEW,
        page: () => MovieDetailsViews(),
        binding: HomeBindings()),
    // GetPage(
    //     name: _Paths.FAVOURITEMOVIE,
    //     page: () => FavouriteViews(),
    //     binding: HomeBindings()),
  ];
}
