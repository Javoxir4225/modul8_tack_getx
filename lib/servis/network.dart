import 'package:dio/dio.dart';
import 'package:modul8_tack_getx/models/chapter/chapter.dart';

class Network {
  static String baseUrl = "api.alquran.cloud/v1/quran/quran-uthmani";
  static Map<String, String> headers = {
    "Content-Type": "applicaton/json; charset=UTF-8"
  };
  static Dio ins = Dio();
// static final cache = Hive.box('data');

  Future<List<Chapter>?> getApi() async {
    final resp = await ins.get(
      'http://api.alquran.cloud/v1/quran/quran-uthmani',
    );
    final Map<String, dynamic> raw = resp.data['data'];
    //  print("-----------------------");
    final List data = raw['surahs'];
    //  print("==============${data.length}");
    final List<Chapter> chapters = List.generate(
      data.length,
      (index) => Chapter.fromMap(data[index]),
    );
    // await cache.put(
    //   'chapters',
    //   chapters,
    // );
    //  print("22222222222222${chapters[0].}")
    return chapters;
  }
  // static Future<List<Chapter?>?> chapterHive() async {
  //   try {
  //     final chapter = await cache.get('chapters');

  //     if (chapter == null) return null;

  //     final List<Chapter?>? chapters = List.from(chapter);

  //     return chapters;
  //   } catch (e) {
  //     throw Exception("Internal Server Error");
  //   }
  // }
}
