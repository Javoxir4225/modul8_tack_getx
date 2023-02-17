// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modul8_tack_getx/controller/controller.dart';
import 'package:modul8_tack_getx/home/home2.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              "assets/images/quran1.png",
              height: 300,
              width: 250,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Yuk...!",
                style: TextStyle(color: Colors.grey, fontSize: 28),
              ),
              SizedBox(height: 8),
              Text(
                "Baca",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 44,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Al-Quran",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 44,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
        Expanded(
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                Get.to(
                  MyHome2(
                    ctrll: Controller(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 185, 139, 41),
                shadowColor: Colors.amber,
                elevation: 6,
                fixedSize: const Size(250, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Surat",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        Text(
          "\"Sesungguhnya Kami-lah yang menurunkan Al-Qur'an \ndan sesungguhnya Kamilah yang memeliharanya\"",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 12),
        Center(
          child: Text(
            "Surat Al-Hijr\n",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
