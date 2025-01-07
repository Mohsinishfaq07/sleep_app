import 'package:sleeping_app/packages.dart';

class ThemeController extends GetxController {
  RxString currentTheme = 'dark'.obs;

  @override
  void onInit() {
    currentTheme.value = prefs.getString('currentTheme') ?? 'dark';
    super.onInit();
  }
}
