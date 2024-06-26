import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../style/app_colors.dart';
import '../style/font_style.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.validator,
    required this.controller,
    required this.label,
    this.isPass = false,
    this.keyboardType,
    this.autovalidateMode,
    this.prefixIcon,
    this.inputFormatters,
    this.onChanged,
    this.onFieldSubmitted,
  });
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool isPass;
  final String label;
  final AutovalidateMode? autovalidateMode;
  final IconData? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final double _borderRadius = 10;
  final Function(String value)? onChanged;
  final Function(String value)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: inputFormatters,
      autovalidateMode: autovalidateMode,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPass,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        hintText: label,
        hintStyle: FontStyle.size18Normal,
        filled: true,
        fillColor: const Color(0xffE2E2E2),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
            borderSide: BorderSide.none),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
            borderSide: BorderSide.none),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
            borderSide: BorderSide.none),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: const BorderSide(color: AppColors.errorColor),
        ),
      ),
    );
  }
}
