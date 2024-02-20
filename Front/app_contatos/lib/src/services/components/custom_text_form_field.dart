import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool? isDense;
  final InputBorder? border;
  final bool autofocus;
  final TextInputType? keyboardType;
  const CustomTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.inputFormatters,
    this.prefixIcon,
    this.labelText,
    this.hintText,
    this.validator,
    this.suffixIcon,
    this.isDense,
    this.border,
    this.autofocus = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      autofocus: autofocus,
      initialValue: initialValue,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
        hintText: hintText,
        isDense: true,
        border: border,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
