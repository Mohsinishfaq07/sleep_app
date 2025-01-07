import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleeping_app/common_widgets/custom_button.dart';
import 'package:sleeping_app/common_widgets/custom_elevated_button.dart';
import 'package:sleeping_app/packages.dart';

class AccountInfoChangeSheet extends StatelessWidget {
  final Function() onPress;
  final String buttonTitle;
  final String hintText;

  final Function(String) onTextFieldChange;

  bool showSecondTextField;
  Function(String)? onSecondTextFieldChange;
  String? hintText2;
  AccountInfoChangeSheet(
      {super.key,
      required this.onPress,
      required this.buttonTitle,
      required this.hintText,
      required this.onTextFieldChange,
      required this.showSecondTextField,
      this.onSecondTextFieldChange,
      this.hintText2});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showSecondTextField)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextField(
              onChanged: onSecondTextFieldChange,
              decoration: InputDecoration(
                hintText: hintText2,
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        TextField(
          onChanged: onTextFieldChange,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        CustomButton(
          onPressed: onPress,
          text: 'Update Name',
        ),
      ],
    );
  }
}

showCustomBottomSheet(
    {required Widget sheetWidget,
    bool? showButton,
    String? text,
    Function()? onPressed}) {
  bool shouldShowButton = showButton ?? false;
  final String buttonLabel = text ?? '';
  final Function() buttonOnPressed = onPressed ?? () {};

  return Get.bottomSheet(
    Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 29, 34, 37),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            sheetWidget,
            shouldShowButton
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                        text: buttonLabel, onPressed: buttonOnPressed),
                  )
                : const SizedBox.shrink()
          ],
        )),
    isScrollControlled: true,
  );
}
