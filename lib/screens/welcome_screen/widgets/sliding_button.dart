import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SlidingButton extends StatefulWidget {
  Function() ontap;
  final String text;
  SlidingButton({
    Key? key,
    required this.ontap,
    required this.text,
  }) : super(key: key);

  @override
  State<SlidingButton> createState() => _SlidingButtonState();
}

class _SlidingButtonState extends State<SlidingButton> {
  bool istaped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          istaped = !istaped;
        });
        widget.ontap();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(
                color: istaped ? Colors.white : Colors.white54, width: 2),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
