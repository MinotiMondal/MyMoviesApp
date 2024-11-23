import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slideAnimation; // For text slide
  late Animation<double> scaleAnimation; // For logo scale

  @override
  void onInit() {
    super.onInit();

    // Initialize AnimationController
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Define Slide Animation
    slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0), // Start from below
      end: Offset.zero,        // End at the center
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Define Scale Animation
    scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.elasticOut,
      ),
    );

    animationController.forward(); // Start animation
    startFunction();
  }

  void startFunction() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(Routes.HomeViews);
    });
  }

  @override
  void onClose() {
    animationController.dispose(); // Dispose controller
    super.onClose();
  }
}
