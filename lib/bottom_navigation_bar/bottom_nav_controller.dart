import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sleeping_app/screens/favorite_screen/favorite_screen.dart';
import 'package:sleeping_app/screens/setting_screen/setting_screen.dart';
import 'package:sleeping_app/screens/sounds_screen/my_sound_screen.dart';

import '../screens/home_screen/home_screen.dart';

class BottomNavigationBarController extends GetxController {
  var selectedIndex = 0.obs; // Observable for selected index

  // Your screen list
  final List<Widget> screens = [
    const HomeScreen(),
    const MySoundScreen(),
    const FavoriteSoundScreen(),
    const SettingScreen(),
  ];

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
