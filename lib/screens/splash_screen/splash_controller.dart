import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sleeping_app/bottom_navigation_bar/my_bottom_navigation_bar.dart';

import 'package:sleeping_app/screens/welcome_screen/welcome_screen.dart';

class SplashScreenController extends GetxController
    with SingleGetTickerProviderMixin {
  var loadingProgress = 0.0.obs;
  var imageAnimationCompleted = false.obs;
  late AnimationController animationController;
  late AnimationController textAnimationController;
  late AnimationController smileAnimationController;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;
  late Animation<double> smileAnimation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        if (animationController.isCompleted) {
          imageAnimationCompleted.value = true;
          textAnimationController.forward();
          smileAnimationController.forward();
        }
      });

    textAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        loadingProgress.value = textAnimationController.value;
      });

    smileAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.elasticInOut),
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );

    smileAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: smileAnimationController, curve: Curves.easeInOut),
    );

    animationController.forward();
  }

  Future<void> checkUserStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstRun = prefs.getBool('isFirstRun') ?? true;

    if (!isFirstRun) {
      Get.off(() => BottomNavigationBarScreen());
    } else {
      Get.off(() => const WelcomeScreen(
            comingForSignUp: false,
          ));
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    textAnimationController.dispose();
    smileAnimationController.dispose();
    super.onClose();
  }
}
