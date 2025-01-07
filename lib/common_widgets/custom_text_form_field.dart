import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    this.controller,
    required this.hintText,
    this.keyboardType,
    this.onFieldSubmitted,
    this.focusNode,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.textInputAction = TextInputAction.next,
    this.isPasswordField = false,
    this.maxLength,
    this.prefix,
    this.suffix,
    this.onPressedSuffix,
    this.readOnly = false,
    this.width,
    this.height,
    this.label,
    this.autoValidateMode,
    this.fillColor = Colors.white,
    this.floatingLabelBehavior,
    super.key,
  });

  final String? label;
  final AutovalidateMode? autoValidateMode;
  final double? width;
  final double? height;
  final IconData? suffix;
  final Widget? prefix;
  final bool isPasswordField;
  final TextInputAction textInputAction;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? onFieldSubmitted;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final dynamic suffixIcon;
  final int? maxLength;
  final VoidCallback? onPressedSuffix;
  final bool readOnly;
  final Color? fillColor;
  final FloatingLabelBehavior? floatingLabelBehavior;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;
  late FocusNode _focusNode;
  Color _prefixContainerColor = Colors.grey; // Default color

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPasswordField;
    _focusNode = widget.focusNode ?? FocusNode();

    // Listen to focus changes
    _focusNode.addListener(() {
      setState(() {
        _prefixContainerColor = _focusNode.hasFocus
            ? Colors.blue.shade800
            : Colors.grey; // Update color based on focus
      });
    });
  }

  @override
  void dispose() {
    // Dispose the focus node to free up resources
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  Widget? _buildSuffixIcon() {
    if (widget.isPasswordField) {
      return IconButton(
        icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    } else if (widget.suffix != null && widget.onPressedSuffix != null) {
      return IconButton(
        icon: Icon(
          widget.suffix,
        ),
        onPressed: widget.onPressedSuffix,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double defaultWidth =
        widget.width ?? MediaQuery.of(context).size.width * 0.9;
    double defaultHeight = widget.height ?? 50;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(
              widget.label!,
              style:  TextStyle(
                color: Colors.blue.shade800,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        SizedBox(
          width: defaultWidth,
          height: defaultHeight,
          child: SingleChildScrollView(
            // Allows for scrolling if content exceeds height
            child: TextFormField(
              readOnly: widget.readOnly,
              maxLength: widget.maxLength,
              onChanged: widget.onChanged,
              keyboardType: widget.keyboardType,
              focusNode: _focusNode, // Use the local focus node
              controller: widget.controller,
              obscureText: _obscureText,
              onFieldSubmitted: widget.onFieldSubmitted,
              validator: widget.validator,
              cursorColor: Colors.blue.shade800,
              autovalidateMode:
                  widget.autoValidateMode ?? AutovalidateMode.disabled,
              cursorHeight: 20,
              decoration: InputDecoration(
                fillColor: widget.fillColor,
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                floatingLabelBehavior: widget.floatingLabelBehavior,
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
                labelStyle:
                    TextStyle(color: Colors.grey.shade200, fontSize: 14),
                suffixIcon: _buildSuffixIcon(),
                prefixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.prefix != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: IconTheme(
                          data: IconThemeData(
                            color: _prefixContainerColor, // Dynamic color here
                          ),
                          child: widget.prefix!,
                        ),
                      ),
                    Container(
                      height: defaultHeight - 15,
                      width: 1,
                      color: _prefixContainerColor, // Change the color here
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                // Border when the TextFormField is focused
                focusedBorder: OutlineInputBorder(
                  borderSide:  BorderSide(color: Colors.blue.shade800, width: 1.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                // Border when the TextFormField is not focused
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                hoverColor: Colors.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
