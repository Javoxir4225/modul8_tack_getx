import 'package:flutter/material.dart';

class RegularButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback onPressed;
  final Size size;
  final Color? color;
  final double? radius;
  final double? textSize;
  const RegularButton(
      {Key? key,
      this.text,
      this.child,
      this.color,
      this.radius,
      this.textSize,
      required this.onPressed,
      required this.size})
      : assert(text != null && child == null || text == null && child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.green,
          fixedSize: size,
          
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 10),
          )),
      onPressed: onPressed,
      child: child ??
          Text(
            text!,
            style: TextStyle(
              fontSize: textSize ?? 16,
              fontWeight: FontWeight.w700,
            ),
          ),
    );
  }
}
