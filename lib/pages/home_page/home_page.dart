
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:modul8_tack_getx/widgets/animations/animation.dart';
import 'package:modul8_tack_getx/pages/audio_page/audio_page.dart';
import 'package:modul8_tack_getx/pages/home_page/home_bloc.dart';
import 'package:modul8_tack_getx/pages/home_page/home_event.dart';
import 'package:modul8_tack_getx/pages/home_page/home_state.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    bloc.add(FetchQuranEvent());
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: buildAppbar(bloc),
      body: buildBody(context, bloc),
    );
  }

  buildAppbar(HomeBloc bloc) {
    return AppBar(
      backgroundColor: Colors.black,
      foregroundColor: Colors.amber,
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Surah",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 34,
                    ),
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(
                      "assets/images/quran6.png",
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _editingController,
                onChanged: (value) {
                  if (value.isEmpty) {
                    bloc.add(OnpressedEmptyEvent());
                  }
                  if (value.isNotEmpty) {
                    bloc.add(OnpressedSearchEvent(value: value));
                  }
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  hintText: "Search Surah disini....",
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  fillColor: Colors.black,
                  filled: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildBody(BuildContext context, HomeBloc bloc) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: bloc,
      builder: (context, state) {
        final isLoading =
            state is FetchQuranStat && state.state == BaseState.Loading;
        return isLoading
            ? Transform.scale(
                scale: 0.5,
                child: Center(
                  child: Lottie.asset("assets/lottie/loading.json"),
                ),
              )
            : bloc.chaptersSearch!.isNotEmpty
                ? ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) => const WidgetAnimator(
                      child: Divider(
                        color: Colors.amber,
                        height: 0.5,
                        thickness: 1,
                      ),
                    ),
                    itemBuilder: (context, index) {
                      final chapterSearch = bloc.chaptersSearch?[index];
                      return WidgetAnimator(
                        child: ListTile(
                          tileColor: Colors.grey.shade800,
                          title: Row(
                            children: [
                              Text(
                                "${index + 1}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 18),
                              Text(
                                chapterSearch?.englishName ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          trailing: Text(
                            chapterSearch?.name ?? "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AudioPage(),
                                settings: RouteSettings(
                                  arguments: [chapterSearch, index],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    itemCount: bloc.chaptersSearch?.length as int,
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      // bloc.add(FetchQuranEvent());
                      await Future.delayed(const Duration(milliseconds: 700))
                          .then((value) {
                        bloc.add(OnpressedEvent());
                      });
                      await Future.delayed(const Duration(milliseconds: 300))
                          .then((value) {
                        bloc.add(OnpressedEvent());
                      });
                    },
                    color: Colors.black,
                    backgroundColor: Colors.amber,
                    child: !bloc.isRefresh
                        ? ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const WidgetAnimator(
                              child: Divider(
                                color: Colors.amber,
                                height: 0.5,
                                thickness: 1,
                              ),
                            ),
                            itemBuilder: (context, index) {
                              final chapter = bloc.chapter?[index];
                              return WidgetAnimator(
                                child: ListTile(
                                  tileColor: Colors.grey.shade800,
                                  title: Row(
                                    children: [
                                      Text(
                                        "${index + 1}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 18),
                                      Text(
                                        chapter?.englishName ?? "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Text(
                                    chapter?.name ?? "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const AudioPage(),
                                        settings: RouteSettings(
                                          arguments: [chapter, index],
                                        ),
                                      ),
                                    ).then((value) {
                                    });
                                  },
                                ),
                              );
                            },
                            itemCount: bloc.chapter?.length ?? 0,
                          )
                        : Container(),
                  );
      },
    );
  }
}
