import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modul8_tack_getx/animations/animation.dart';
import 'package:modul8_tack_getx/pages/audio_page/audio.dart';
import 'package:modul8_tack_getx/models/chapter/chapter.dart';

class AudioPage extends StatelessWidget {
  const AudioPage({
    Key? key,
  }) : super(key: key);
  // Chapter? data;
  @override
  Widget build(BuildContext context) {
    final Chapter data = Get.arguments[0] as Chapter;
    final index = Get.arguments[1] as int;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          height: 74,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          child: MyAudio(index: index),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.orange,
            pinned: true,
            floating: true,
            expandedHeight: height * 0.27,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  data.englishName ?? "dd",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              background: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: 0.3,
                      child: Image.asset("assets/images/quran.jpg"),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          data.name!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 36),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final verse = data.ayahs?[index]?.text;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: WidgetAnimator(
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      trailing: CircleAvatar(
                        radius: 10,
                        backgroundColor: const Color(0xff04364f),
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.white,
                          child: Text(
                            (index + 1).toString(),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      title: Text(
                        verse ?? "--",
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          fontFamily: 'Noor',
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: data.ayahs!.length,
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.all(40),
          ),
        ],
      ),
    );
  }
}
