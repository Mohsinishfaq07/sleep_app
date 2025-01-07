import 'package:sleeping_app/common_widgets/custom_button.dart';
import 'package:sleeping_app/common_widgets/custom_text_form_field.dart';
import 'package:sleeping_app/packages.dart';

class UpdatePassword extends StatelessWidget {
  final Function() updatePassFunction;
  const UpdatePassword({super.key, required this.updatePassFunction});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(() {
              return CustomTextFormField(
                onChanged: (value) {
                  authController.password.value = value;
                },
                label: "Your password",
                hintText: 'Your Password',
                prefix: const Icon(Icons.mail_outline),
              isPasswordField: true,
              );

             }),
            const SizedBox(height: 20),
            Obx(() {
              return 
              CustomTextFormField(
                onChanged: (value) {
                  authController.newPassword.value = value;
                },
                label: "Your New password",
                hintText: 'Your New Password',
                prefix: const Icon(Icons.mail_outline),
                isPasswordField: true,
              );
              
          
            }),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  // Validations passed, perform login or other actions

                  updatePassFunction();
                }
              },
              height: 40,
              width: MediaQuery.sizeOf(context).width - 20,
              text: 'Update',
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
