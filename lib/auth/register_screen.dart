import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleeping_app/auth/sign_in_screen.dart';
import 'package:sleeping_app/common_widgets/app_assets.dart';
import 'package:sleeping_app/common_widgets/backgroundImage.dart';
import 'package:sleeping_app/common_widgets/connect_button.dart';
import 'package:sleeping_app/common_widgets/custom_appbar.dart';
import 'package:sleeping_app/common_widgets/custom_text_form_field.dart';
import 'package:sleeping_app/common_widgets/logoImageContainer.dart';
import 'package:sleeping_app/constants.dart';
import '../common_widgets/custom_button.dart';
import '../utils/colors.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(themeController.currentTheme.value == 'dark'
                ? AppAssets.bg
                : themeController.currentTheme.value == 'red'
                    ? AppAssets.redBg
                    : AppAssets.blueBg),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomAppBarWidget(
                  showBackButton: false,
                  backButtonColor: Colors.white,
                ),
                const LogoImageContainer(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Create a new account",
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  onChanged: (value) {
                    authController.userEmail.value = value;
                  },
                  label: "E-mail",
                  hintText: 'Email',
                  prefix: const Icon(Icons.mail_outline),
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  onChanged: (value) {
                    authController.userName.value = value;
                  },
                  label: "User Name",
                  hintText: 'UserName',
                  prefix: const Icon(Icons.supervised_user_circle_outlined),
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  onChanged: (value) {
                    authController.password.value = value;
                  },
                  label: "Password",
                  hintText: 'Password',
                  isPasswordField: true,
                  prefix: const Icon(Icons.lock_clock_rounded),
                ),
                const SizedBox(height: 10),
                Obx(() {
                  return CustomButton(
                    isLoading: authController.showLoading.value,
                    onPressed: () {
                      Get.log('hello');
                      authService.createUser(
                          userEmail: authController.userEmail.value,
                          userPass: authController.password.value,
                          userName: authController.userName.value);
                      // Get.to(const SignInScreen());
                    },
                    text: 'Sign Up',
                  );
                }),
                const SizedBox(height: 15),
                Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: 1,
                    color: Colors.red),
                const SizedBox(height: 15),
                ConnectButton(
                  image: AppAssets.googleIcon,
                  ontap: () {
                    authService.signUpWithGoogle();
                  },
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center the row content

                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => const SignInScreen(
                            showBackButton: false,
                          ),
                          transition:
                              Transition.leftToRight, // Use built-in transition
                          duration: const Duration(
                              milliseconds:
                                  1000), // Duration for the transition
                        );
                      },
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
