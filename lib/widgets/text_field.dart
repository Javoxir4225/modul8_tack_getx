import 'package:flutter/material.dart';

class WidgetTextField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final bool? enabled;
  final String? Function(String? value)? validator;
  final VoidCallback? onTap;
  const WidgetTextField({
    Key? key,
    required this.label,
    this.enabled,
    this.icon,
    this.validator,
    this.controller,
    this.textInputType,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      validator: validator,
      keyboardType: textInputType,
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
          fillColor: Colors.grey,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: label,
          prefixIcon: Icon(icon)),
    );
  }
}
