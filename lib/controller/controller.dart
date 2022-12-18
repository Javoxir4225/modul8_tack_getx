import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:modul8_tack_getx/models/chapter/chapter.dart';
import 'package:modul8_tack_getx/servis/network.dart';

class Controller extends GetxController {
  bool _isRefresh = false;
  bool _istext = false;

  // data

  List<Chapter?>? _chapters = [];

  List<Chapter?>? get chapters => _chapters;

  bool get isRefresh => _isRefresh;
  bool get istext => _istext;

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
  void onPressed2(bool loading) {
    _istext = loading;
    update();
  }

  void getApi() async {
    try {
      updateApiState(EnumState.loading);
      final res = await Network.getApi();
      _chapters = res;
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
