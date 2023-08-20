import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:modul8_tack_getx/models/chapter/chapter.dart';

class Controller extends GetxController {
  bool _isRefresh = false;

  // data

  List<Chapter?>? _chapters = [];
  List<Chapter?>? _chaptersSearch = [];

  List<Chapter?>? get chapters => _chapters;
  List<Chapter?>? get chaptersSearch => _chaptersSearch;

  bool get isRefresh => _isRefresh;

  // states
  EnumState chapterState = EnumState.initial;

  @override
  void onInit() {
    getApi();
    onPressed();
    super.onInit();
  }

  void onPressed() {
    _isRefresh = !_isRefresh;
    update();
  }

  // void onPressed2(bool loading) {
  //   _istext = loading;
  //   update();
  // }

  void onPressed3() {
    _chaptersSearch = [];
    update();
  }

  void onPressed4(String value) {
    var lowerCaseQuery = value.toLowerCase();
    _chaptersSearch = chapters!.where((chapter) {
      final chapterName =
          chapter!.englishName!.toLowerCase().contains(lowerCaseQuery);
      return chapterName;
    }).toList(growable: false)
      ..sort(
        (a, b) =>
            a!.englishName!.toLowerCase().indexOf(lowerCaseQuery).compareTo(
                  b!.englishName!.toLowerCase().indexOf(lowerCaseQuery),
                ),
      );
    update();
  }

  void getApi() async {
    try {
      updateApiState(EnumState.loading);
      // final res = await Network.getApi();
      // _chapters = res;
      print("+++++++++++++++++");
      updateApiState(EnumState.loaded);
    } catch (e) {
      if (kDebugMode) {
        print("Controller: getApi $e");
      }
      updateApiState(EnumState.error);
    }
  }

  void updateApiState(EnumState state) {
    chapterState = state;
    update();
  }
}

enum EnumState {
  initial,
  loading,
  loaded,
  error,
}
