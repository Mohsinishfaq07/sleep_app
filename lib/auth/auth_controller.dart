import 'package:sleeping_app/packages.dart';

class AuthController extends GetxController {
  RxString userEmail = ''.obs;
  RxString password = ''.obs;
  RxString userName = ''.obs;
  RxString newPassword = ''.obs;
  RxBool showPass = true.obs;
  RxBool showLoading = false.obs;

  RxString userAge = ''.obs;
  RxString userGender = ''.obs;

  RxBool userLoggedIn = false.obs;
}
