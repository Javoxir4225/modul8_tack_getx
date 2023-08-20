import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WidgetTextRich extends StatelessWidget {
  final String text1;
  final String text2;
  final double size;
  final Color? color;
  final FontWeight weght1;
  final FontWeight weght2;
  final VoidCallback? onPressed1;
  final VoidCallback? onPressed2;
  const WidgetTextRich({
    Key? key,
    required this.text1,
    required this.text2,
    required this.size,
    this.color,
    required this.weght1,
    required this.weght2,
    this.onPressed1,
    this.onPressed2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text1,
             recognizer: TapGestureRecognizer()..onTap = onPressed1,
            style: TextStyle(
              fontWeight: weght1,
              color: Colors.black,
              fontSize: size,
            ),
          ),
          TextSpan(
            text: text2,
            recognizer: TapGestureRecognizer()..onTap = onPressed2,
            style: TextStyle(
              fontWeight: weght2,
              color: color ?? Colors.blue,
              fontSize: size,
            ),
          )
        ],
      ),
    );
  }
}
