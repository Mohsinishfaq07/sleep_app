import 'package:sleeping_app/common_widgets/app_assets.dart';
import 'package:sleeping_app/packages.dart';

class BackGroundImage extends StatelessWidget {
  const BackGroundImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Image(
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
                            : themeController.currentTheme.value == 'lightblue'
                                ? AppAssets.lightBlueBG
                                : themeController.currentTheme.value ==
                                        'lightpurple'
                                    ? AppAssets.lightPurpleBG
                                    : themeController.currentTheme.value ==
                                            'lightyellow'
                                        ? AppAssets.lightYellowBG
                                        : themeController.currentTheme.value ==
                                                'purple'
                                            ? AppAssets.purpleBG
                                            : AppAssets.yellowBG),
        fit: BoxFit.fill,
      );
    });
  }
}
