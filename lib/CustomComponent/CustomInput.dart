import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final VoidCallback? onSuffixIconPressed;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.isObscure = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.onSuffixIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObscure,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: suffixIcon!,
                  onPressed: onSuffixIconPressed,
                )
              : null,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: labelText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
