import 'package:sleeping_app/packages.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void launchRateApp() async {
    final Uri url = Uri.parse('');

    await launchUrl(url);
  }

  launchContactUs() {
    try {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'mohsin.ishfaq.raja@gmail.com',
        query:
            'subject=${Uri.encodeComponent('Sleeping App')}&body=${Uri.encodeComponent(
          'Share your experience with us',
        )}',
      );
      launchUrl(emailLaunchUri);
    } catch (e) {
      Get.log('Error launching Gmail: $e');
    }
  }

  launchPrivacyPolicy() {
    final Uri url = Uri.parse('');
    launchUrl(url);
  }
}
