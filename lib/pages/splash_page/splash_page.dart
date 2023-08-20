import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:modul8_tack_getx/pages/home_page/home_bloc.dart';
import 'package:modul8_tack_getx/pages/home_page/home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
        const SizedBox(height: 40),
        Expanded(
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 116, horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return BlocProvider(
                          create: (context) => HomeBloc(
                            network: GetIt.instance.get(),
                          ),
                          child: MyHomePage(),
                        );
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 185, 139, 41),
                  shadowColor: Colors.amber,
                  elevation: 6,
                  fixedSize: const Size(double.maxFinite, double.maxFinite),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Surah",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
        const Center(
          child: Text(
            "Mishari Rashid Al-Qur'an",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Center(
          child: Text(
            "Surat Al-Hijr",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        SizedBox(height: ScreenUtil().bottomBarHeight + 8),
      ],
    );
  }
}
