import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:modul8_tack_getx/core/network_info/network_info.dart';
import 'package:modul8_tack_getx/exceptions.dart';
import 'package:modul8_tack_getx/models/chapter/chapter.dart';
import 'package:modul8_tack_getx/servis/hive.dart';

class GetQuranApi {
  final NetworkInfo networkInfo;
  final HiveSave localHive;
  final Box local;
  GetQuranApi({
    required this.networkInfo,
    required this.localHive,
    required this.local,
  });
  static String baseUrl = "api.alquran.cloud/v1/quran/quran-uthmani";
  static Dio ins = Dio();

  Future<List<Chapter>?> getApi() async {
    // final isGuest = prefs.getBool("is_guest");
    final isGuest = local.get("is_guest");

    if (isGuest == false) {
      final chapterHive = localHive.localHiveGetChapter();
      return chapterHive;
    } else {
      if (await networkInfo.isConnected) {
        final resp = await ins.get(
          'http://api.alquran.cloud/v1/quran/quran-uthmani',
        );
        final Map<String, dynamic> raw = resp.data['data'];
        final List data = raw['surahs'];
        final List<Chapter> chapters = List.generate(
          data.length,
          (index) {
            final chapter = Chapter.fromMap(data[index]);
            localHive.localHiveAddChapter(chapter);
            return chapter;
          },
        );
        // prefs.setBool("is_guest", false);
        local.put("is_guest", false);
        return chapters;
      } else {
        throw NetworkException();
      }
    }
  }
}
