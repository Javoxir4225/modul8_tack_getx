// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RegularCentrLoading extends StatelessWidget {
  final Widget? widget;
  const RegularCentrLoading({Key? key, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Center(
        child: Container(
          height: 100,
          width: 100,
          padding: const EdgeInsets.all(25),
          child: widget ??
              const CupertinoActivityIndicator(
                radius: 14,
              ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
