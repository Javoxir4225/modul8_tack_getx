import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:modul8_tack_getx/controller/controller.dart';
import 'package:modul8_tack_getx/models/ayah/ayah.dart';
import 'package:modul8_tack_getx/models/chapter/chapter.dart';
import 'package:modul8_tack_getx/pages/splash_page/splash_page.dart';
import 'package:modul8_tack_getx/pages/home_page/home.dart';
import 'package:modul8_tack_getx/pages/audio_page/audio_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ChapterAdapter());
  Hive.registerAdapter(AyahAdapter());

  // Initialize the injection container
  await di.init();

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
      getPages: [
        GetPage(
          name: "/home",
          page: () => const SplashPage(),
        ),
        GetPage(
          name: "/home2",
          page: () => MyHome(ctrll: Controller()),
        ),
        GetPage(
          name: "/home3",
          page: () => const AudioPage(),
        ),
      ],
    );
  }
}
