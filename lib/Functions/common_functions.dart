import 'package:sleeping_app/packages.dart';

class CommonFunctions {
  // snack bar showing function

  showSnackBar(
      {required String title,
      required String message,
      required Color backgroundColor,
      required Color colorText,
      required Duration duration}) {
    return Get.snackbar(
      title,
      message,
      backgroundColor: Colors.grey,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.black,
      duration: const Duration(seconds: 1),
    );
  }

  shoeSnackMessage({
    required String message,
  }) {
    return Get.snackbar(
      'Alert',
      message,
      backgroundColor: Colors.grey,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.black,
      duration: const Duration(seconds: 3),
    );
  }
}
