import 'package:flutter/material.dart';
import 'package:sleeping_app/common_widgets/app_assets.dart';
import 'package:sleeping_app/packages.dart';

class ThemeScreen extends StatelessWidget {
  final bool showBackButton;
  const ThemeScreen({super.key, required this.showBackButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : const SizedBox.shrink(),
        centerTitle: true,
        title:
            const Text('Theme Screen ', style: TextStyle(color: Colors.white)),
      ),
      body: Obx(() {
        return Container(
          height: MediaQuery.sizeOf(context).height,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(themeController.currentTheme.value == 'dark'
                  ? AppAssets.bg
                  : themeController.currentTheme.value == 'red'
                      ? AppAssets.redBg
                      : themeController.currentTheme.value == 'blue'
                          ? AppAssets.blueBg
                          : themeController.currentTheme.value == 'darkblue'
                              ? AppAssets.darkBlueBG
                              : themeController.currentTheme.value == 'green'
                                  ? AppAssets.greenBG
                                  : themeController.currentTheme.value ==
                                          'lightblue'
                                      ? AppAssets.lightBlueBG
                                      : themeController.currentTheme.value ==
                                              'lightpurple'
                                          ? AppAssets.lightPurpleBG
                                          : themeController
                                                      .currentTheme.value ==
                                                  'lightyellow'
                                              ? AppAssets.lightYellowBG
                                              : themeController
                                                          .currentTheme.value ==
                                                      'purple'
                                                  ? AppAssets.purpleBG
                                                  : AppAssets.yellowBG),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 100.0),
            child: Column(
              children: [
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SwitchListTile(
                      tileColor: Colors.grey.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      activeColor: Colors.white,
                      title: const Text(
                        "Dark Theme",
                        style: TextStyle(color: Colors.white),
                      ),
                      value: themeController.currentTheme.value == 'dark'
                          ? true
                          : false,
                      onChanged: (value) {
                        if (value) {
                          themeController.currentTheme.value = 'dark';
                          prefs.setString('currentTheme', 'dark');
                        } else {
                          themeController.currentTheme.value = 'dark';
                        }
                      },
                    ),
                  );
                }),
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SwitchListTile(
                      tileColor: Colors.red.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      activeColor: Colors.red,
                      title: const Text(
                        "Red Theme",
                        style: TextStyle(color: Colors.white),
                      ),
                      value: themeController.currentTheme.value == 'red'
                          ? true
                          : false,
                      onChanged: (value) {
                        if (value) {
                          themeController.currentTheme.value = 'red';
                          prefs.setString('currentTheme', 'red');
                        } else {
                          themeController.currentTheme.value = 'dark';
                          prefs.setString('currentTheme', 'dark');
                        }
                      },
                    ),
                  );
                }),
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SwitchListTile(
                      tileColor: Colors.blue.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      activeColor: Colors.blue,
                      title: const Text(
                        "Blue Theme",
                        style: TextStyle(color: Colors.white),
                      ),
                      value: themeController.currentTheme.value == 'blue'
                          ? true
                          : false,
                      onChanged: (value) {
                        if (value) {
                          themeController.currentTheme.value = 'blue';
                          prefs.setString('currentTheme', 'blue');
                        } else {
                          themeController.currentTheme.value = 'dark';
                          prefs.setString('currentTheme', 'red');
                        }
                      },
                    ),
                  );
                }),

                // dark blue
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SwitchListTile(
                      tileColor: Colors.blue.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      activeColor: Colors.blue,
                      title: const Text(
                        "Dark Blue Theme",
                        style: TextStyle(color: Colors.white),
                      ),
                      value: themeController.currentTheme.value == 'darkblue'
                          ? true
                          : false,
                      onChanged: (value) {
                        if (value) {
                          themeController.currentTheme.value = 'darkblue';
                          prefs.setString('currentTheme', 'darkblue');
                        } else {
                          themeController.currentTheme.value = 'dark';
                          prefs.setString('currentTheme', 'dark');
                        }
                      },
                    ),
                  );
                }),
                //green
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SwitchListTile(
                      tileColor: Colors.green.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      activeColor: Colors.green,
                      title: const Text(
                        "Green Theme",
                        style: TextStyle(color: Colors.white),
                      ),
                      value: themeController.currentTheme.value == 'green'
                          ? true
                          : false,
                      onChanged: (value) {
                        if (value) {
                          themeController.currentTheme.value = 'green';
                          prefs.setString('currentTheme', 'green');
                        } else {
                          themeController.currentTheme.value = 'dark';
                          prefs.setString('currentTheme', 'dark');
                        }
                      },
                    ),
                  );
                }),
                // light blue
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SwitchListTile(
                      tileColor: Colors.blue.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      activeColor: Colors.blue,
                      title: const Text(
                        "Light Blue Theme",
                        style: TextStyle(color: Colors.white),
                      ),
                      value: themeController.currentTheme.value == 'lightblue'
                          ? true
                          : false,
                      onChanged: (value) {
                        if (value) {
                          themeController.currentTheme.value = 'lightblue';
                          prefs.setString('currentTheme', 'lightblue');
                        } else {
                          themeController.currentTheme.value = 'dark';
                          prefs.setString('currentTheme', 'dark');
                        }
                      },
                    ),
                  );
                }),
                //light purple
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SwitchListTile(
                      tileColor: Colors.purple.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      activeColor: Colors.purple,
                      title: const Text(
                        "Purple Theme",
                        style: TextStyle(color: Colors.white),
                      ),
                      value: themeController.currentTheme.value == 'lightpurple'
                          ? true
                          : false,
                      onChanged: (value) {
                        if (value) {
                          themeController.currentTheme.value = 'lightpurple';
                          prefs.setString('currentTheme', 'lightpurple');
                        } else {
                          themeController.currentTheme.value = 'dark';
                          prefs.setString('currentTheme', 'dark');
                        }
                      },
                    ),
                  );
                }),
                //light yellow

                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SwitchListTile(
                      tileColor: Colors.yellowAccent.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      activeColor: Colors.yellowAccent,
                      title: const Text(
                        "Yellow Theme",
                        style: TextStyle(color: Colors.white),
                      ),
                      value: themeController.currentTheme.value == 'lightyellow'
                          ? true
                          : false,
                      onChanged: (value) {
                        if (value) {
                          themeController.currentTheme.value = 'lightyellow';
                          prefs.setString('currentTheme', 'lightyellow');
                        } else {
                          themeController.currentTheme.value = 'dark';
                          prefs.setString('currentTheme', 'dark');
                        }
                      },
                    ),
                  );
                }),
                //purple
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SwitchListTile(
                      tileColor: Colors.deepPurple.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      activeColor: Colors.deepPurple,
                      title: const Text(
                        "Purple Theme",
                        style: TextStyle(color: Colors.white),
                      ),
                      value: themeController.currentTheme.value == 'purple'
                          ? true
                          : false,
                      onChanged: (value) {
                        if (value) {
                          themeController.currentTheme.value = 'purple';
                          prefs.setString('currentTheme', 'purple');
                        } else {
                          themeController.currentTheme.value = 'dark';
                          prefs.setString('currentTheme', 'dark');
                        }
                      },
                    ),
                  );
                }),
                //yellow
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SwitchListTile(
                      tileColor: Colors.yellow.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      activeColor: Colors.yellow,
                      title: const Text(
                        "Yellow Theme",
                        style: TextStyle(color: Colors.white),
                      ),
                      value: themeController.currentTheme.value == 'yellow'
                          ? true
                          : false,
                      onChanged: (value) {
                        if (value) {
                          themeController.currentTheme.value = 'yellow';
                          prefs.setString('currentTheme', 'yellow');
                        } else {
                          themeController.currentTheme.value = 'dark';
                          prefs.setString('currentTheme', 'dark');
                        }
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      }),
    );
  }
}
