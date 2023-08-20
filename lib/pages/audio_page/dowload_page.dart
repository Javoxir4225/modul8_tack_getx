import 'package:flutter/material.dart';
import 'package:modul8_tack_getx/pages/audio_page/download_provider.dart';
import 'package:modul8_tack_getx/widgets/regular_text.dart';
import 'package:provider/provider.dart';

class DowloadPage extends StatelessWidget {
  final int index;
  final String surahName;
  const DowloadPage({
    Key? key,
    required this.index,
    required this.surahName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fileDownloaderProvider =
        Provider.of<FileDownloaderProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("File Downloading"),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 400,
            right: 0,
            left: 0,
            child: Image.asset(
              "assets/images/quran3.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 280,
            right: 0,
            left: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RegularText(
                    text: "/sdcard/download/$surahName",
                    color: Colors.amber,
                    size: 22,
                  ),
                  const SizedBox(height: 12),
                  dowloadButton(
                    fileDownloaderProvider,
                    context,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dowloadButton(
    FileDownloaderProvider downloaderProvider,
    BuildContext context,
  ) {
    return ElevatedButton(
      onPressed: () {
        // Navigator.pop(context);
        if (downloaderProvider.downloadStatus ==
            DownloadStatusEnum.notStarted) {
          downloaderProvider
              .downloadFile(
                index < 10
                    ? "https://server8.mp3quran.net/afs/00${index + 1}.mp3"
                    : index < 100
                        ? 'https://server8.mp3quran.net/afs/0${index + 1}.mp3'
                        : 'https://server8.mp3quran.net/afs/${index + 1}.mp3',
                "$surahName.mp3",
                context,
              )
              .then((onValue) {});
        } else {}
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
      ),
      child: downloadProgress(context),
    );
  }

  Widget downloadProgress(BuildContext context) {
    var fileDownloaderProvider =
        Provider.of<FileDownloaderProvider>(context, listen: true);

    return Text(
      downloadStatus(
        fileDownloaderProvider,
        context,
      ),
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  downloadStatus(
    FileDownloaderProvider fileDownloaderProvider,
    BuildContext context,
  ) {
    var retStatus = "";

    switch (fileDownloaderProvider.downloadStatus) {
      case DownloadStatusEnum.downloading:
        {
          retStatus =
              "Download Progress : ${fileDownloaderProvider.downloadPercentage}%";
        }
        break;
      case DownloadStatusEnum.completed:
        {
          retStatus = "Download Completed";
        }
        break;
      case DownloadStatusEnum.notStarted:
        {
          retStatus = "Download File";
        }
        break;
      case DownloadStatusEnum.started:
        {
          retStatus = "Download Started";
        }
        break;
    }

    return retStatus;
  }
}



