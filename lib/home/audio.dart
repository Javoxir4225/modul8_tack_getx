import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MyAudio extends StatefulWidget {
  final int index;
  const MyAudio( {Key? key,required this.index}):super(key: key);

  @override
  State<MyAudio> createState() => _MyAudioState();
}

class _MyAudioState extends State<MyAudio> {
  final audioPlayer = AudioPlayer();
  bool isPlayer = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    // setAudio();
    
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlayer = event == PlayerState.PLAYING;
        
      });
    });
    
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
     
    });
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.LOOP);
    // Load audio from file
    // final result = await FilePicker.platform.pickFiles();
    // if (result != null) {
    //   final file = File(result.files.single.path!);
    //   audioPlayer.setSourceUrl(file.path);
    // }

    // Load audio player (assets/player)
    final player = AudioCache(prefix: "assets/audio/");
    final url = await player.load("001.mp3");
    audioPlayer.setUrl(url.path, isLocal: true);
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
          bottom: 24,
          left: 0,
          right: 0,
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
          bottom: 20,
          right: 10,
          left: 10,
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
              print("------------$position");
              if (isPlayer) {
                await audioPlayer.pause();
              } else {
                // await audioPlayer.resume();
                String url = 'https://server8.mp3quran.net/afs/00${widget.index+1}.mp3';
                await audioPlayer.play(  url);
                //   'https://server8.mp3quran.net/afs/002.mp3'
                //  'https://server8.mp3quran.net/afs/003.mp3'
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
