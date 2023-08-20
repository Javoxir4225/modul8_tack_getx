import 'package:flutter/material.dart';

class WidgetOverScroll extends StatelessWidget {
  final Widget child;

  const WidgetOverScroll({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      child: child,
      onNotification: (notification) {
        notification.disallowIndicator();
        return true;
      },
    );
  }
}
