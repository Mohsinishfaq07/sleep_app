import 'package:sleeping_app/common_widgets/custom_button.dart';
import 'package:sleeping_app/common_widgets/custom_text_form_field.dart';
import 'package:sleeping_app/packages.dart';

class PasswordSheet extends StatelessWidget {
  final Function() deleteAccountFunction;

  const PasswordSheet({super.key, required this.deleteAccountFunction});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          // Added SingleChildScrollView to prevent overflow
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              const SizedBox(height: 50),
              CustomButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    deleteAccountFunction();
                  }
                },
                height: 40,
                width: MediaQuery.of(context).size.width - 20,
                text: 'yes',
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
