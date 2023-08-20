import 'package:flutter/material.dart';

class RegularText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? size;

  const RegularText({
    Key? key,
    required this.text,
    this.color,
    this.fontWeight,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.blue,
        fontSize: size ?? 12,
        fontWeight: fontWeight ?? FontWeight.bold,
      ),
    );
  }
}
