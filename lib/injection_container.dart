// Dependency injection file

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:modul8_tack_getx/core/network_info/network_info.dart';
import 'package:modul8_tack_getx/models/chapter/chapter.dart';
import 'package:modul8_tack_getx/servis/hive.dart';
import 'package:modul8_tack_getx/servis/network.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await Hive.initFlutter();
  final Box<dynamic> hiveBox = await Hive.openBox("default");
  final Box<Chapter> chapterBox = await Hive.openBox("hhhh");
  final prefs = await SharedPreferences.getInstance();

  // External
  sl.registerLazySingleton<Box<dynamic>>(() => hiveBox);
  sl.registerLazySingleton<Box<Chapter>>(() => chapterBox);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerSingleton(prefs);
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
        connectivity: sl(),
        dataChecker: sl(),
      ));

  sl.registerLazySingleton(
    () => HiveSave(
      localHive: sl.get(),
    ),
  );
  sl.registerLazySingleton(
    () => GetQuranApi(
      localHive: sl.get(),
      networkInfo: sl.get(),
      local: hiveBox,
    ),
  );
}
