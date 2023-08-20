import 'package:hive_flutter/adapters.dart';
import 'package:modul8_tack_getx/models/chapter/chapter.dart';
import 'package:modul8_tack_getx/util/print_debug.dart';

class HiveSave {
  final Box<Chapter> localHive;

  HiveSave({required this.localHive});

  Future<bool> localHiveAddChapter(Chapter chapter) async {
    final r = await localHive.add(chapter);
    printDebug("****************************************==========>$r");
    return true;
  }

  Future<List<Chapter>?> localHiveGetChapter() async {
    final chapter = localHive.values.cast<Chapter>().toList();
    printDebug(
        "get hive ==>${chapter.length}");
    return chapter;
  }
}
