import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class SingleSoundCategory extends StatelessWidget {
  final String name;
  final bool isTaped;

  const SingleSoundCategory(
      {super.key, required this.name, required this.isTaped});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 10,

      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: isTaped ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: lightWhiteColor,
        ),
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            color: isTaped ? Colors.black : Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
