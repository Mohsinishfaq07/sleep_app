import 'package:sleeping_app/common_widgets/backgroundImage.dart';
import 'package:sleeping_app/common_widgets/custom_appbar.dart';
import 'package:sleeping_app/common_widgets/custom_button.dart';
import 'package:sleeping_app/common_widgets/custom_text_form_field.dart';
import 'package:sleeping_app/common_widgets/logoImageContainer.dart';
import 'package:sleeping_app/packages.dart';
import '../../utils/global_variables.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const BackGroundImage(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomAppBarWidget(
                  showBackButton: true,
                  backButtonColor: Colors.white,
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                const LogoImageContainer(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Forgot Password",
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Enter the email associated with your $appName account. We will send you a link to safely reset your password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: whiteColor95,
                      wordSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: formKey,
                  child: Column(
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
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                      CustomButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {}
                          authService.forgotPassword(
                              userEmail: authController.userEmail.value);
                        },
                        text: 'Send',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
