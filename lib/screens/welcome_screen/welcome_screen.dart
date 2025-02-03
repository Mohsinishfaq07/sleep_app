import 'package:carousel_slider/carousel_slider.dart';

import 'package:sleeping_app/bottom_navigation_bar/my_bottom_navigation_bar.dart';
import 'package:sleeping_app/common_widgets/custom_button.dart';
import 'package:sleeping_app/common_widgets/dialogue_boxes.dart';
import 'package:sleeping_app/common_widgets/logoImageContainer.dart';

import 'package:sleeping_app/packages.dart';
import 'package:sleeping_app/screens/theme_screen/theme_screen.dart';

import '../../common_widgets/app_assets.dart';

import 'package:sleeping_app/screens/reminders/set_reminders.dart';

class WelcomeScreenController extends GetxController {
  RxInt currentIndex = 0.obs;

  List<Widget> welcomeScreens = [
    const WelcomeFistPage(),
    const ThemeScreen(
      showBackButton: false,
    ),
    const SetReminderScreen(
      showBackButton: false,
    ),
    const QuoteScreen()
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
                        children: welcomeScreenController.welcomeScreens),
                  ),
                ),

                // Button at the Bottom Center
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: CustomButton(
                    text: welcomeScreenController.currentIndex.value ==
                            welcomeScreenController.welcomeScreens.length - 1
                        ? 'Get Start'
                        : 'Next',
                    onPressed: () {
                      if (welcomeScreenController.currentIndex.value ==
                          welcomeScreenController.welcomeScreens.length - 1) {
                        prefs.setBool('isFirstRun', false);
                        welcomeScreenController.currentIndex.value == 0;
                        Get.delete<WelcomeScreenController>();
                        Get.off(() => BottomNavigationBarScreen());
                      } else {
                        welcomeScreenController.currentIndex.value++;
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
