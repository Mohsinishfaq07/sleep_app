import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final String title;
  final double width;
  final double height;
  final VoidCallback onTap;

  const CustomElevatedButton({
    required this.title,
    required this.onTap,
    this.width = 100,
    this.height = 42,
    super.key,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.black,
            // gradient: const LinearGradient(
            //   colors: [
            //     // Colors.purple,
            //     Colors.black,
            //   ],
            // ),
            borderRadius: BorderRadius.circular(30),
            //    border: Border.all(color: Colors.white)
          ),
          child: Center(
            child: Text(
              widget.title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ));
  }
}
