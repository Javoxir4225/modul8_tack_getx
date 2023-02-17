import 'package:modul8_tack_getx/models/chapter/chapter.dart';

abstract class HomeState {}

class Initial extends HomeState {}

class FetchQuranStat extends HomeState {
  final List<Chapter>? chapters;
  final BaseState state;
  final String? error;
  FetchQuranStat({this.chapters = const [], required this.state, this.error});
}

enum BaseState {
  Loading,
  Loaded,
  Error,
  Initial,
}
