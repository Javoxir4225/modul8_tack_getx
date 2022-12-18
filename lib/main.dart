import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modul8_tack_getx/controller/controller.dart';
import 'package:modul8_tack_getx/home/home.dart';
import 'package:modul8_tack_getx/home/home2.dart';
import 'package:modul8_tack_getx/home/home3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
     debugShowCheckedModeBanner: false,
      home:   const MyHome(),

      getPages: [
        GetPage(name: "/home", page:() =>    const MyHome(),),
        GetPage(name: "/home2", page:() =>   MyHome2(ctrll: Controller()),),
        GetPage(name: "/home3", page:() =>   MyHome3(),),
      ],
    );
  }
}

