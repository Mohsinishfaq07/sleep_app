import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleeping_app/auth/register_screen.dart';
import 'package:sleeping_app/bottom_navigation_bar/my_bottom_navigation_bar.dart';
import 'package:sleeping_app/common_widgets/custom_button.dart';
import 'package:sleeping_app/common_widgets/dialogue_boxes.dart';
import 'package:sleeping_app/common_widgets/logoImageContainer.dart';
import 'package:sleeping_app/controllers/theme_controller.dart';
import 'package:sleeping_app/packages.dart';

import '../../common_widgets/app_assets.dart';
import '../../utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:sleeping_app/packages.dart';
import 'package:sleeping_app/screens/reminders/set_reminders.dart';
import 'package:sleeping_app/screens/theme_screen/theme_screen.dart';

class WelcomeScreenController extends GetxController {
  RxInt currentIndex = 0.obs;

  List<Widget> comingForFirstRun = [
    const WelcomeFistPage(),
    const AgeSelectorPage(),
    const GenderSelectorPage(),
    const ThemeSelectionPage(),
    const SetReminderScreen(
      showBackButton: false,
    ),
    const QuoteScreen()
  ];

  List<Widget> comingForSignUp = [
    const AgeSelectorPage(),
    const GenderSelectorPage(),
  ];
  @override
  void onInit() {
    currentIndex.value = 0;
    super.onInit();
  }

  @override
  void onClose() {
    currentIndex.value = 0;
    super.onClose();
  }
}

class WelcomeScreen extends StatelessWidget {
  final bool comingForSignUp;
  const WelcomeScreen({super.key, required this.comingForSignUp});

  @override
  Widget build(BuildContext context) {
    WelcomeScreenController welcomeScreenController =
        Get.put(WelcomeScreenController());
    Get.log(
        'WelcomeScreen: comingForSignUp: $comingForSignUp and index : ${welcomeScreenController.currentIndex.value}');
    return WillPopScope(
      onWillPop: () async {
        if (comingForSignUp) {
          welcomeScreenController.currentIndex.value == 0;
          Get.delete<WelcomeScreenController>();
          return true;
        } else {
          showExitDialogue();
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
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

            // Main Content with Navigation and Button
            Column(
              children: [
                // IndexedStack to display the main content
                Expanded(
                  child: Obx(
                    () => IndexedStack(
                      index: welcomeScreenController.currentIndex.value,
                      children: comingForSignUp
                          ? welcomeScreenController.comingForSignUp
                          : welcomeScreenController.comingForFirstRun,
                    ),
                  ),
                ),

                // Button at the Bottom Center
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: CustomButton(
                    text: comingForSignUp
                        ? welcomeScreenController.currentIndex.value ==
                                welcomeScreenController.comingForSignUp.length -
                                    1
                            ? 'Get Start'
                            : 'Next'
                        : welcomeScreenController.currentIndex.value ==
                                welcomeScreenController
                                        .comingForFirstRun.length -
                                    1
                            ? 'Get Start'
                            : 'Next',
                    onPressed: () {
                      if (comingForSignUp) {
                        if (welcomeScreenController.currentIndex.value ==
                            welcomeScreenController.comingForSignUp.length -
                                1) {
                          welcomeScreenController.currentIndex.value == 0;
                          Get.delete<WelcomeScreenController>();
                          Get.to(() => const RegisterScreen());
                        } else {
                          if (welcomeScreenController.currentIndex.value == 0 &&
                              authController.userAge.value.isEmpty) {
                            Get.snackbar(
                                'Alert', 'Please select your age group',
                                backgroundColor: Colors.white12,
                                colorText: Colors.white);
                          } else if (welcomeScreenController
                                      .currentIndex.value ==
                                  1 &&
                              authController.userGender.value.isEmpty) {
                            Get.snackbar('Alert', 'Please select your gender',
                                backgroundColor: Colors.white12,
                                colorText: Colors.white);
                          } else {
                            welcomeScreenController.currentIndex.value++;
                          }
                        }
                      } else {
                        if (welcomeScreenController.currentIndex.value ==
                            welcomeScreenController.comingForFirstRun.length -
                                1) {
                          prefs.setBool('isFirstRun', false);
                          final FirebaseAuth _auth = FirebaseAuth.instance;
                          User? user = _auth.currentUser;

                          if (user != null) {
                            firebaseService.getUserData(docId: user.uid);
                            welcomeScreenController.currentIndex.value == 0;
                            Get.delete<WelcomeScreenController>();
                            Get.off(() => BottomNavigationBarScreen());
                          } else {
                            welcomeScreenController.currentIndex.value == 0;
                            Get.delete<WelcomeScreenController>();
                            Get.to(() => const RegisterScreen());
                          }
                        } else {
                          if (welcomeScreenController.currentIndex.value == 1 &&
                              authController.userAge.value.isEmpty) {
                            Get.snackbar(
                                'Alert', 'Please select your age group',
                                backgroundColor: Colors.white12,
                                colorText: Colors.white);
                          } else if (welcomeScreenController
                                      .currentIndex.value ==
                                  2 &&
                              authController.userGender.value.isEmpty) {
                            Get.snackbar('Alert', 'Please select your gender',
                                backgroundColor: Colors.white12,
                                colorText: Colors.white);
                          } else {
                            welcomeScreenController.currentIndex.value++;
                          }
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Text(
            '"Sleep is the best meditation."\nDalai Lama',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}

class WelcomeFistPage extends StatelessWidget {
  const WelcomeFistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: LogoImageContainer(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            'Welcome to Sleeping App',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}

class ThemeSelectionPage extends StatelessWidget {
  const ThemeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CarouselSlider(
        items: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  AppAssets.darkSS,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.red,
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  AppAssets.redSS,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
              image: const DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(
                  AppAssets.blueSS,
                ),
              ),
            ),
          ),
        ],
        options: CarouselOptions(
          height: 600.0,
          autoPlay: false,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
          onPageChanged: (index, reason) {
            themeController.currentTheme.value = index == 0
                ? 'dark'
                : index == 1
                    ? 'red'
                    : 'blue';
          },
        ),
      ),
    );
  }
}

class AgeSelectorPage extends StatelessWidget {
  const AgeSelectorPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(0.0),
          child: Text(
            'Which Age group do you belong to',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Center(
          child: Obx(() {
            return infoContainer(
                title: 'Below 20s',
                onTap: () {
                  authController.userAge.value = 'below 20';
                },
                buttonStatus:
                    authController.userAge.value == 'below 20' ? true : false);
          }),
        ),
        Obx(() {
          return infoContainer(
              title: '20s',
              onTap: () {
                authController.userAge.value = '20';
              },
              buttonStatus:
                  authController.userAge.value == '20' ? true : false);
        }),
        Obx(() {
          return infoContainer(
              title: '30s',
              onTap: () {
                authController.userAge.value = '30';
              },
              buttonStatus:
                  authController.userAge.value == '30' ? true : false);
        }),
        Obx(() {
          return infoContainer(
              title: '40s',
              onTap: () {
                authController.userAge.value = '40';
              },
              buttonStatus:
                  authController.userAge.value == '40' ? true : false);
        }),
        Obx(() {
          return infoContainer(
              title: '50s and above',
              onTap: () {
                authController.userAge.value = '50 and above';
              },
              buttonStatus: authController.userAge.value == '50 and above'
                  ? true
                  : false);
        }),
      ],
    );
  }
}

// gender selector

class GenderSelectorPage extends StatelessWidget {
  const GenderSelectorPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(0.0),
          child: Text(
            'Ho do you identify your gender?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Center(
          child: Obx(() {
            return infoContainer(
                title: 'Male',
                onTap: () {
                  authController.userGender.value = 'male';
                },
                buttonStatus:
                    authController.userGender.value == 'male' ? true : false);
          }),
        ),
        Obx(() {
          return infoContainer(
              title: 'Female',
              onTap: () {
                authController.userGender.value = 'female';
              },
              buttonStatus:
                  authController.userGender.value == 'female' ? true : false);
        }),
        Obx(() {
          return infoContainer(
              title: 'Other',
              onTap: () {
                authController.userGender.value = 'other';
              },
              buttonStatus:
                  authController.userGender.value == 'other' ? true : false);
        }),
      ],
    );
  }
}

infoContainer(
    {required String title,
    required Function() onTap,
    required bool buttonStatus}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(top: 10.0),
      decoration: const BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      height: 60,
      width: MediaQuery.sizeOf(Get.context!).width - 30,
      child: Row(
        children: [
          buttonStatus
              ? const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.circle,
                    color: Colors.blue,
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.circle_outlined,
                    color: Colors.blue,
                  ),
                ),
          const SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          )
        ],
      ),
    ),
  );
}
