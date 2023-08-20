// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modul8_tack_getx/core/network_info/network_info.dart';
import 'package:modul8_tack_getx/pages/audio_page/download_provider.dart';
import 'package:modul8_tack_getx/pages/audio_page/dowload_page.dart';
import 'package:provider/provider.dart';

class MyAudio extends StatefulWidget {
  final int index;
  final String surahName;
  final NetworkInfo networkInfo;
  const MyAudio({
    Key? key,
    required this.index,
    required this.surahName,
    required this.networkInfo,
  }) : super(key: key);

  @override
  State<MyAudio> createState() => _MyAudioState();
}

class _MyAudioState extends State<MyAudio> {
  final audioPlayer = AudioPlayer();
  bool isPlayer = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  late var timer;
  @override
  void initState() {
    super.initState();

    if (mounted) {
      timer = Timer.periodic(
          const Duration(seconds: 60), (Timer t) => setState(() {}));
    }
    // setAudio();

    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlayer = event == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    // Load audio from file
    // final result = await FilePicker.platform.pickFiles();
    // if (result != null) {
    //   final file = File(result.files.single.path!);
    //   audioPlayer.setSourceUrl(file.path);
    // }

    // Load audio player (assets/player)
    final player = AudioCache(prefix: "assets/audio/");
    final url = await player.load("001.mp3");
    audioPlayer.setSourceUrl(url.path);
  }

  @override
  void dispose() {
    audioPlayer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          bottom: 28,
          left: 0,
          right: 8,
          child: Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) {
                      return ChangeNotifierProvider(
                        create: (context) => FileDownloaderProvider(),
                        child: DowloadPage(
                          index: widget.index,
                          surahName: widget.surahName,
                        ),
                      );
                    },
                  ),
                );
              },
              child: const Icon(
                Icons.download,
                color: Colors.green,
                size: 30,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 24,
          left: 16,
          right: 16,
          child: Slider(
            thumbColor: Colors.amber,
            inactiveColor: Colors.grey,
            activeColor: Colors.amber,
            secondaryActiveColor: Colors.amber,
            min: 0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds.toDouble(),
            onChanged: (value) async {
              final position = Duration(seconds: value.toInt());

              await audioPlayer.seek(position);
              await audioPlayer.resume();
            },
          ),
        ),
        Positioned(
          bottom: 14,
          right: 36,
          left: 36,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                // formatTime(position),
                "",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                formatTime(duration - position),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        Positioned(
          top: 30,
          child: GestureDetector(
            onTap: () async {
              // print("------------$position");
              if (await widget.networkInfo.isConnected) {
                if (isPlayer) {
                  await audioPlayer.pause();
                } else {
                  // await audioPlayer.resume();
                  String url;
                  if (widget.index < 10) {
                    url =
                        'https://server8.mp3quran.net/afs/00${widget.index + 1}.mp3';
                  } else if (widget.index < 100) {
                    url =
                        'https://server8.mp3quran.net/afs/0${widget.index + 1}.mp3';
                  } else {
                    url =
                        'https://server8.mp3quran.net/afs/${widget.index + 1}.mp3';
                  }
                  // await audioPlayer.play(url);
                  await audioPlayer.play(
                    UrlSource(
                      url,
                    ),
                  );
                }
              } else {
                Fluttertoast.showToast(
                  msg: "No Internet",
                  backgroundColor: Colors.red,
                  gravity: ToastGravity.TOP,
                  toastLength: Toast.LENGTH_LONG,
                );
              }
            },
            child: Icon(
              isPlayer ? Icons.pause : Icons.play_arrow,
              size: 38,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  String formatTime(Duration position) {
    String res(int x) => x.toString().padLeft(2, "0");
    final hours = res(duration.inHours);
    final minutes = res(duration.inMinutes.remainder(60));
    final seconds = res(duration.inSeconds.remainder(60));
    setState(() {});
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(":");
  }
}
