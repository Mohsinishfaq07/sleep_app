import 'package:sleeping_app/bottom_navigation_bar/my_bottom_navigation_bar.dart';
import 'package:sleeping_app/common_widgets/app_assets.dart';
import 'package:sleeping_app/common_widgets/backgroundImage.dart';
import 'package:sleeping_app/common_widgets/connect_button.dart';
import 'package:sleeping_app/common_widgets/custom_appbar.dart';
import 'package:sleeping_app/common_widgets/custom_text_form_field.dart';
import 'package:sleeping_app/auth/register_screen.dart';
import 'package:sleeping_app/common_widgets/logoImageContainer.dart';
import 'package:sleeping_app/screens/welcome_screen/welcome_screen.dart';
import '../common_widgets/custom_button.dart';
import '../screens/forget_password_screen/forget_password_screen.dart';
import 'package:sleeping_app/packages.dart';

class SignInScreen extends StatelessWidget {
  final bool showBackButton;
  const SignInScreen({super.key, required this.showBackButton});

  @override
  Widget build(BuildContext context) {
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
              children: [
                CustomAppBarWidget(
                    showBackButton: showBackButton,
                    backButtonColor: Colors.white,
                    ontap: () => Get.to(
                          () => const WelcomeScreen(
                            comingForSignUp: true,
                          ),
                          transition:
                              Transition.rightToLeft, // Use built-in transition
                          duration: const Duration(
                              milliseconds:
                                  1000), // Duration for the transition
                        )),
                const LogoImageContainer(),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      onChanged: (value) {
                        authController.userEmail.value = value;
                      },
                      label: "E-mail",
                      hintText: 'Email',
                      prefix: const Icon(Icons.mail_outline),
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      onChanged: (value) {
                        authController.password.value = value;
                      },
                      label: "Password",
                      hintText: 'Password',
                      isPasswordField: true,
                      prefix: const Icon(Icons.lock_clock_outlined),
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ForgetPasswordScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;
                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);
                              return SlideTransition(
                                  position: offsetAnimation, child: child);
                            },
                            transitionDuration:
                                const Duration(milliseconds: 1000),
                          ),
                        );
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Get.off(() => BottomNavigationBarScreen());
                      },
                      child: Text(
                        "Continue as Guest",
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    CustomButton(
                      onPressed: () {
                        authService.loginUser(
                          userEmail: authController.userEmail.value,
                          userPass: authController.password.value,
                        );
                      },
                      text: 'Login',
                    ),
                    const SizedBox(height: 15),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: 1,
                        color: Colors.red),
                    const SizedBox(height: 15),
                    ConnectButton(
                      image: AppAssets.googleIcon,
                      ontap: () {
                        authService.loginWithGoogle();
                        //    authService.loginWithGoogle();
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Center the row content

                      children: [
                        const Text(
                          "Dont have an account? ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              () => const WelcomeScreen(
                                comingForSignUp: true,
                              ),
                              transition: Transition
                                  .rightToLeft, // Use built-in transition
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
                                "Create Account",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 13,
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
                      height: 5,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
