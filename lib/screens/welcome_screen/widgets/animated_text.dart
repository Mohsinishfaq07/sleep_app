
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/global_variables.dart';

class AnimatedTextWidget extends StatefulWidget {
  @override
  _AnimatedTextWidgetState createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget> {
  late String _currentText;

  @override
  void initState() {
    super.initState();
    _currentText = 'Hi there,\nWelcome to $appName';

    // Delay for 2 seconds before switching to the second text
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _currentText = 'Your new go-to for restful nights, and energized';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: Text(
            _currentText,
            key: ValueKey<String>(_currentText),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0,
              color: whiteColor,
            ),
          ),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
        ),
      ),
    );
  }
}
