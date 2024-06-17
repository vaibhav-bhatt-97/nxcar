import 'package:flutter/material.dart';
import 'package:nxcar/constants/nx_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final String? Function(String?) validator;
  final bool required;
  final int? maxLength;

  CustomTextFormField({
    required this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    required this.validator,
    required this.required,
    this.maxLength
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus; // Update focus state
        });
      },
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        maxLength: widget.maxLength??255,
        decoration: InputDecoration(
          counterText: "",
          label: RichText(
            text: TextSpan(
              text: widget.labelText,
              style: const TextStyle(color: Colors.grey),
              children: widget.required
                  ? [
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
              ]
                  : [],
            ),
          ),
          filled: true,
          fillColor:
          _isFocused ? NXColors.focusedTextFieldBG : NXColors.textFieldBG,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 12.0,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: NXColors.border,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 0.2,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 0.2,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}