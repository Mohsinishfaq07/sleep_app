import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleeping_app/packages.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback? ontap;
  final Widget? trailing;
  final Widget? leading;
  final dynamic backgroundColor;
  final dynamic titleColor;
  final dynamic backButtonColor;
  final bool showBackButton;
  final Widget? title;
  final bool showTitle;
  const CustomAppBarWidget({
    this.backgroundColor = Colors.white,
    this.trailing,
    this.leading,
    this.backButtonColor = Colors.black,
    this.titleColor = Colors.black,
    this.showBackButton = false,
    this.showTitle = false,
    this.title,
    this.ontap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      leading: leading,
      foregroundColor: Colors.white,
      shadowColor: Colors.white,
      surfaceTintColor: Colors.white,
      forceMaterialTransparency: true,
      elevation: 0,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          if (showBackButton) ...[
            GestureDetector(
                onTap: () {
                  if (FocusScope.of(context).hasFocus) {
                    FocusScope.of(context).unfocus();
                  }
                  if (showBackButton) {
                    Get.back();
                  }
                },
                child: Icon(Icons.arrow_back, color: backButtonColor)),
            // const SizedBox(width: 8),
          ],
          const SizedBox(width: 2),
          if (showTitle &&
              title != null) // Show title only if showTitle is true
            title!,
          if (showTitle &&
              title == null) // If title is null and showTitle is true
            const SizedBox.shrink(),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Container(
            child: trailing,
          ),
        ),
        const SizedBox(
          width: 2,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
