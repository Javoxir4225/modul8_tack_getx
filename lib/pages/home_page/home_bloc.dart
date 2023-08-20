import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modul8_tack_getx/models/chapter/chapter.dart';
import 'package:modul8_tack_getx/pages/home_page/home_event.dart';
import 'package:modul8_tack_getx/pages/home_page/home_state.dart';
import 'package:modul8_tack_getx/servis/network.dart';
import 'package:modul8_tack_getx/util/print_debug.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetQuranApi network;
  HomeBloc({required this.network}) : super(Initial()) {
    on<FetchQuranEvent>((event, emit) async {
      await _fetchQuran(emit);
    });
    on<OnpressedEvent>((event, emit) async {
      await _onPressed(emit);
    });
    on<OnpressedEmptyEvent>((event, emit) async {
      await _onPressedEmpty(emit);
    });
    on<OnpressedSearchEvent>((event, emit) async {
      await _onPressedSearch(emit, event.value);
    });
  }

  bool _isRefresh = false;
  bool get isRefresh => _isRefresh;

  List<Chapter>? chapter = [];
  List<Chapter?>? _chaptersSearch = [];
  List<Chapter?>? get chaptersSearch => _chaptersSearch;

  _fetchQuran(Emitter<HomeState> emit) async {
    try {
      emit(FetchQuranStat(state: BaseState.Loading));

      chapter = await network.getApi();
      // await locadHive.localHiveAddChapter(chapter ?? []);
      // final res = await locadHive.localHiveGetChapter();
      emit(FetchQuranStat(state: BaseState.Loaded, chapters: chapter));
    } catch (e) {
      printDebug("Homebloc: fetchQuran: Error: ==============>$e");
      emit(FetchQuranStat(state: BaseState.Error, error: "No Intertet"));
    }
  }

  _onPressed(Emitter<HomeState> emit) {
    _isRefresh = !_isRefresh;
    emit(OnpressedState());
  }

  _onPressedEmpty(Emitter<HomeState> emit) {
    _chaptersSearch = [];
    emit(OnpressedEmptyState());
  }

  _onPressedSearch(Emitter<HomeState> emit, String value) {
    var lowerCaseQuery = value.toLowerCase();
    _chaptersSearch = chapter!.where((chapter) {
      final chapterName =
          chapter.englishName!.toLowerCase().contains(lowerCaseQuery);
      return chapterName;
    }).toList(growable: false)
      ..sort(
        (a, b) =>
            a.englishName!.toLowerCase().indexOf(lowerCaseQuery).compareTo(
                  b.englishName!.toLowerCase().indexOf(lowerCaseQuery),
                ),
      );
    emit(OnpressedSearchState());
  }
}
