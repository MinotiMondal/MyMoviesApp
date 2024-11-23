import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_movies_app/module/misc_module/splash/controller/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Scale Animation for the Logo
            ScaleTransition(
              scale: controller.scaleAnimation,
              child: Image.asset(
                'assets/icons/movies_logo.png',
                height: Get.height * 0.1,
                width: Get.width * 0.5,
              ),
            ),
            SizedBox(height: 20), // Add spacing between logo and text

            // Slide Animation for the Text
            SlideTransition(
              position: controller.slideAnimation,
              child: Text(
                "Movies App",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
