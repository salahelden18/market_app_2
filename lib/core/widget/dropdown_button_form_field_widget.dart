import 'package:flutter/material.dart';

class DropdownButtonFormFieldWidget extends StatelessWidget {
  const DropdownButtonFormFieldWidget({
    super.key,
    required this.items,
    required this.onChanged,
    this.validator,
    this.selectedValue,
    required this.hint,
  });
  final List<DropdownMenuItem> items;
  final void Function(dynamic)? onChanged;
  final String? Function(dynamic)? validator;
  final String? selectedValue;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text(hint),
      value: selectedValue,
      items: [
        DropdownMenuItem(
          enabled: false,
          value: null,
          child: Text(hint),
        ),
        ...items,
      ],
      onChanged: onChanged,
      validator: validator,
    );
  }
}
