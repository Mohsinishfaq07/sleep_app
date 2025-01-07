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
                : AppAssets.blueBg),
        fit: BoxFit.fill,
      );
    });
  }
}
