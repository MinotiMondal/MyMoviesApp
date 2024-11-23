import 'package:get/get.dart';
import 'package:my_movies_app/module/misc_module/splash/controller/splash_controller.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    SplashController splashController =Get.put(SplashController());
  }
}
