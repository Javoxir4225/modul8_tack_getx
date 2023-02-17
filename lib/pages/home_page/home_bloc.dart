import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modul8_tack_getx/models/chapter/chapter.dart';
import 'package:modul8_tack_getx/pages/home_page/home_event.dart';
import 'package:modul8_tack_getx/pages/home_page/home_state.dart';
import 'package:modul8_tack_getx/servis/network.dart';
import 'package:modul8_tack_getx/util/print_debug.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Network network;
  HomeBloc({required this.network}) : super(Initial()) {
    on<FetchQuranEvent>((event, emit) async {
      await _fetchQuran(emit);
    });
  }

  List<Chapter>? _chapter = [];
  List<Chapter>? get chapter => _chapter;

  _fetchQuran(Emitter<HomeState> emit) async {
    try {
      emit(FetchQuranStat(state: BaseState.Loading));
      _chapter = await network.getApi();
      emit(FetchQuranStat(state: BaseState.Loaded, chapters: _chapter));
    } catch (e) {
      printDebug("Homebloc: fetchQuran: Error: ==============>$e");
      emit(FetchQuranStat(state: BaseState.Error, error: "No Intertet"));
    }
  }
}
