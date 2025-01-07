import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleeping_app/common_widgets/app_assets.dart';
import 'package:sleeping_app/bottom_navigation_bar/bottom_nav_controller.dart';
import 'package:sleeping_app/common_widgets/custom_button.dart';
import 'package:sleeping_app/common_widgets/dialogue_boxes.dart';
import 'package:sleeping_app/constants.dart';

class BottomNavigationBarScreen extends StatelessWidget {
  BottomNavigationBarScreen({super.key});

  final BottomNavigationBarController navBarController =
      Get.put(BottomNavigationBarController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showExitDialogue();
        return false;
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Obx(() {
              return Image(
                image: AssetImage(themeController.currentTheme.value == 'dark'
                    ? AppAssets.bg
                    : themeController.currentTheme.value == 'red'
                        ? AppAssets.redBg
                        : AppAssets.blueBg),
                fit: BoxFit.cover,
              );
            }),
            //     Conditionally show the CustomAppBarWidget based on selectedIndex

            // The IndexedStack for switching screens
            Obx(() => IndexedStack(
                  index: navBarController.selectedIndex.value,
                  children: authController.userLoggedIn.value
                      ? navBarController.loggedInUserScreens
                      : navBarController.guestUserScreens,
                )),
          ],
        ),
        floatingActionButton: Obx(
          () => ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            child: Container(
              width: 300,
              color: Colors.white.withOpacity(0.7),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(40)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(Icons.home, 0),
                      _buildNavItem(Icons.music_note, 1),
                      _buildNavItem(Icons.favorite, 2),
                      _buildNavItem(Icons.person, 3),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  /// Helper method to create a navigation icon with consistent style.
  Widget _buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        navBarController.onItemTapped(index);
      },
      child: Container(
        decoration: BoxDecoration(
          color: navBarController.selectedIndex.value == index
              ? const Color.fromARGB(255, 1, 14, 26)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: navBarController.selectedIndex.value == index
                      ? Colors.white
                      : Colors.transparent,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(100))),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                icon,
                size: 24,
                color: navBarController.selectedIndex.value == index
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
