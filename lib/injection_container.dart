// Dependency injection file

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:modul8_tack_getx/models/chapter/chapter.dart';
import 'package:modul8_tack_getx/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await Hive.initFlutter();
  final Box<dynamic> hiveBox = await Hive.openBox("default");
  final Box<Chapter> chapterBox = await Hive.openBox("user");

  // External
  sl.registerLazySingleton<Box<dynamic>>(() => hiveBox);
  sl.registerLazySingleton<Box<Chapter>>(() => chapterBox);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
        connectivity: sl(),
        dataChecker: sl(),
      ));

  // sl.registerLazySingleton(
  //   () => UserRepo(
  //     networkInfo: sl.get(),
  //     auth: FirebaseAuth.instance,
  //     localDb: sl.get(),
  //     storage: FirebaseStorage.instance,
  //     db: FirebaseFirestore.instance,
  //   ),
  // );
}
