import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleeping_app/auth/register_screen.dart';
import 'package:sleeping_app/auth/sign_in_screen.dart';
import 'package:sleeping_app/constants.dart';
import 'package:sleeping_app/screens/account_screen/account_screen.dart';
import 'package:sleeping_app/screens/favorite_screen/favorite_screen.dart';
import 'package:sleeping_app/screens/sounds_screen/my_sound_screen.dart';

import '../screens/home_screen/home_screen.dart';
import '../screens/profile_screen/profile_screen.dart';

class BottomNavigationBarController extends GetxController {
  var selectedIndex = 0.obs; // Observable for selected index

  // Your screen list
  final List<Widget> guestUserScreens = [
    const HomeScreen(),
    const MySoundScreen(),
    const FavoriteSoundScreen(),
    const SignInScreen(
      showBackButton: false,
    ),
  ];

  final List<Widget> loggedInUserScreens = [
    const HomeScreen(),
    const MySoundScreen(),
    const FavoriteSoundScreen(),
    const AccountScreen()
  ];

  void onItemTapped(int index) {
    if (!authController.userLoggedIn.value && index == 3) {
      Get.to(() => const SignInScreen(showBackButton: true));
    } else {
      selectedIndex.value = index;
    }
  }
}
