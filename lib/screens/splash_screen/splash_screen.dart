import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sleeping_app/common_widgets/dialogue_boxes.dart';
import 'package:sleeping_app/common_widgets/logoImageContainer.dart';
import 'package:sleeping_app/screens/splash_screen/splash_controller.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashScreenController controller = Get.put(SplashScreenController());

    return WillPopScope(
      onWillPop: () async {
        showExitDialogue();
        return false;
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: _buildBody(controller, context),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(SplashScreenController controller, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAnimatedSplashImage(controller, context),
        Obx(() => Visibility(
              visible: controller.imageAnimationCompleted.value,
              child: _buildLoadingIndicator(controller),
            )),
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: _buildAnimatedSmile(controller, context),
        ),
        Obx(() => Visibility(
              visible: controller.loadingProgress.value >= 1.0,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: _buildShimmerText(context),
              ),
            )),
      ],
    );
  }

  Widget _buildAnimatedSplashImage(
      SplashScreenController controller, BuildContext context) {
    return FadeTransition(
      opacity: controller.fadeAnimation,
      child: ScaleTransition(
        scale: controller.scaleAnimation,
        child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 26),
            child: LogoImageContainer()),
      ),
    );
  }

  Widget _buildLoadingIndicator(SplashScreenController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 8, left: 8, top: 1),
      child: Center(
        child: Obx(() {
          double progress = controller.loadingProgress.value;
          return Center(
            child: CustomPaint(
              size: const Size(200, 50),
              painter: TextDrawingPainter(progress),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildAnimatedSmile(
      SplashScreenController controller, BuildContext context) {
    return Obx(() => Visibility(
          visible: controller.loadingProgress.value >= 1.0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: GestureDetector(
              onTap: () async {
                // Close the keyboard if open
                FocusScope.of(context).unfocus();

                // Check the user status
                await controller.checkUserStatus();
              },
              child: Container(
                width: 100, // Adjust the width and height as needed
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Makes the container round
                  border: Border.all(
                      color: Colors.orange, width: 1), // Optional border
                ),
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      "😴",
                      style: TextStyle(fontSize: 60),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildShimmerText(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.blueGrey,
      highlightColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height) * 0.1,
        child: const Text(
          'Click on emoji to continue',
          style: TextStyle(fontSize: 20, color: Colors.blueGrey),
        ),
      ),
    );
  }
}

class TextDrawingPainter extends CustomPainter {
  final double progress;
  TextDrawingPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height / 2);
    path.lineTo(size.width * progress, size.height / 2);

    // Define the text style and span
    final textSpan = TextSpan(
      text: 'Sleep Mingle',
      style: TextStyle(
        fontSize: 24,
        color: Colors.white.withOpacity(progress),
      ),
    );

    // Setup the text painter
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    // Layout the text based on the available space
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    // Calculate the offset for centered text
    final offset = Offset(
      (size.width - textPainter.width) / 2, // Center horizontally
      size.height / 2 - textPainter.height / 2, // Center vertically
    );

    // Paint the text
    textPainter.paint(canvas, offset);

    // Draw the path (for progress line, if necessary)
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
