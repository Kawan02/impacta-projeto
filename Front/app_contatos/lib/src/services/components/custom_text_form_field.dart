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
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final EdgeInsetsGeometry? contentPadding;
  final AutovalidateMode? autovalidateMode;
  final ScrollPhysics? scrollPhysics;
  final bool? alignLabelWithHint;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
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
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.contentPadding,
    this.autovalidateMode,
    this.scrollPhysics,
    this.alignLabelWithHint,
    this.onChanged,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      autovalidateMode: autovalidateMode,
      focusNode: focusNode,
      scrollPhysics: scrollPhysics,
      autofocus: autofocus,
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        alignLabelWithHint: alignLabelWithHint,
        contentPadding: contentPadding,
        labelText: labelText,
        hintText: hintText,
        isDense: true,
        border: border,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
