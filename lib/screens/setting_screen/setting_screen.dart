import 'package:sleeping_app/packages.dart';
import 'package:sleeping_app/screens/reminders/set_reminders.dart';
import 'package:sleeping_app/screens/reminders/view_reminders.dart';

import 'package:sleeping_app/screens/theme_screen/theme_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title:
              const Text("Profile Page", style: TextStyle(color: Colors.white)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 120.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                settingScreenContainer(
                    info: 'Set Reminders',
                    secondaryWidget: const SizedBox.shrink(),
                    context: context,
                    onTap: () {
                      Get.to(() => const SetReminderScreen(
                            showBackButton: true,
                          ));
                    }),
                settingScreenContainer(
                    info: 'View Reminders',
                    secondaryWidget: const SizedBox.shrink(),
                    context: context,
                    onTap: () {
                      Get.to(() => const ViewSleepingGoalsScreen());
                    }),
                // settingScreenContainer(
                //     info: 'Mode History Viewer',
                //     secondaryWidget: const SizedBox.shrink(),
                //     context: context,
                //     onTap: () async {
                //       Get.to(() => MoodDisplayScreen());
                //     }),
                settingScreenContainer(
                    info: 'Themes',
                    secondaryWidget: const SizedBox.shrink(),
                    context: context,
                    onTap: () {
                      Get.to(() => const ThemeScreen(
                            showBackButton: true,
                          ));
                    }),
                settingScreenContainer(
                    info: 'Contact Us',
                    secondaryWidget: const SizedBox.shrink(),
                    context: context,
                    onTap: () {
                      commonFunctions.launchContactUs();
                    }),
                settingScreenContainer(
                    info: 'Rate Us',
                    secondaryWidget: const SizedBox.shrink(),
                    context: context,
                    onTap: () {
                      commonFunctions.launchRateApp();
                    }),
                settingScreenContainer(
                    info: 'Privacy Policy',
                    secondaryWidget: const SizedBox.shrink(),
                    context: context,
                    onTap: () {
                      commonFunctions.launchPrivacyPolicy();
                    }),
              ],
            ),
          ),
        ));
  }

  Widget settingScreenContainer(
      {required String info,
      required Widget secondaryWidget,
      required BuildContext context,
      Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 10.0, right: 10.0),
        width: MediaQuery.sizeOf(context).width - 20,
        decoration: const BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                info,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              secondaryWidget
            ],
          ),
        ),
      ),
    );
  }
}
