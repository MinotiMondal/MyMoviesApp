import 'package:get/get.dart';
import 'package:my_movies_app/module/main_module/homeMovie/controller/home_controller.dart';

class HomeBindings extends Bindings{
  @override
  void dependencies(){
    HomeController homeController = Get.put(HomeController());

  }
}