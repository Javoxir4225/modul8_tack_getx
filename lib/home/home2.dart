
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:modul8_tack_getx/animations/animation.dart';
import 'package:modul8_tack_getx/controller/controller.dart';
import 'package:modul8_tack_getx/home/home3.dart';

class MyHome2 extends StatelessWidget {
  final Controller ctrll;
  MyHome2({super.key, required this.ctrll});

  final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: buildAppbar(),
      body: buildBody(context),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _onRefresh();
      //   },
      //   backgroundColor: Colors.amber,
      //   child: const Icon(
      //     Icons.refresh,
      //     color: Colors.black,
      //     size: 32,
      //   ),
      // ),
    );
  }

  buildAppbar() {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    "Surat",
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
                    ctrll.onPressed3();
                    // ctrll.onPressed2(false);
                  }
                  if (value.isNotEmpty) {
                    ctrll.onPressed4(value);
                    // ctrll.onPressed2(true);
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
                  hintText: "Search Surat disini....",
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

  buildBody(BuildContext context) {
    return GetBuilder(
      init: ctrll,
      builder: (context) {
        final isLoading = ctrll.chapterState == EnumState.loading;
        // return ctrll.chapters!.isEmpty ==true
        return isLoading
            ? Transform.scale(
                scale: 0.5,
                child: Center(
                  child: Lottie.asset("assets/lottie/loading.json"),
                ),
              )
            : ctrll.chaptersSearch!.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.amber,
                      height: 0.5,
                      thickness: 1,
                    ),
                    itemBuilder: (context, index) => ListTile(
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
                            ctrll.chaptersSearch?[index]?.englishName ?? "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      trailing: Text(
                        ctrll.chaptersSearch?[index]?.name ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        Get.to(
                          MyHome3(),
                          arguments: ctrll.chaptersSearch?[index],
                        );
                        // Get.offNamed("/home3",arguments: chapters?[index]);
                      },
                    ),
                    itemCount: ctrll.chaptersSearch?.length as int,
                  )
                : RefreshIndicator(
                    onRefresh: _onRefresh,
                    color: Colors.black,
                    backgroundColor: Colors.amber,
                    child: ctrll.isRefresh
                        ? WidgetAnimator(
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                color: Colors.amber,
                                height: 0.5,
                                thickness: 1,
                              ),
                              itemBuilder: (context, index) => ListTile(
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
                                      ctrll.chapters?[index]?.englishName ?? "",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Text(
                                  ctrll.chapters?[index]?.name ?? "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  Get.to(
                                    MyHome3(),
                                    arguments: ctrll.chapters?[index],
                                  );
                                  // Get.offNamed("/home3",arguments: chapters?[index]);
                                },
                              ),
                              itemCount: ctrll.chapters?.length as int,
                            ),
                          )
                        : Container(),
                  );
      },
    );
  }

  Future _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 700)).then((value) {
      ctrll.onPressed();
    });
    await Future.delayed(const Duration(milliseconds: 300)).then((value) {
      ctrll.onPressed();
    });
  }
}
