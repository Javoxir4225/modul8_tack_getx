import 'dart:async';
import 'dart:typed_data';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:modul8_tack_getx/util/print_debug.dart';
import 'package:path_provider/path_provider.dart';

enum DownloadStatusEnum {notStarted, started, downloading, completed}

class FileDownloaderProvider with ChangeNotifier {
  late StreamSubscription _downloadSubscription;
  DownloadStatusEnum _downloadStatus = DownloadStatusEnum.notStarted;
  int _downloadPercentage = 0;
  String _downloadedFile = "";

  int get downloadPercentage => _downloadPercentage;
  DownloadStatusEnum get downloadStatus => _downloadStatus;
  String get downloadedFile => _downloadedFile;

  Future downloadFile(String url, String filename, BuildContext context) async {
    final Completer<void> completer = Completer<void>();

    var httpClient = http.Client();
    var request = http.Request('GET', Uri.parse(url));
    var response = httpClient.send(request);

    final dir = Platform.isAndroid
        ? '/sdcard/download'
        : (await getApplicationDocumentsDirectory()).path;

    List<List<int>> chunks = [];
    int downloaded = 0;

    updateDownloadStatus(DownloadStatusEnum.started);

    _downloadSubscription =
        response.asStream().listen((http.StreamedResponse r) {
      updateDownloadStatus(DownloadStatusEnum.downloading);
      r.stream.listen((List<int> chunk) async {
        // Display percentage of completion
        printDebug('downloadPercentage onListen : $_downloadPercentage');

        chunks.add(chunk);
        downloaded += chunk.length;
        _downloadPercentage =
            (downloaded / (r.contentLength ?? 0) * 100).round();
        notifyListeners();
      }, onDone: () async {
        // Display percentage of completion
        _downloadPercentage =
            (downloaded / (r.contentLength ?? 0) * 100).round();
        notifyListeners();
        printDebug('downloadPercentage onDone: $_downloadPercentage');

        // Save the file
        File file = File('$dir/$filename');

        _downloadedFile = '$dir/$filename';
        printDebug(_downloadedFile);

        final Uint8List bytes = Uint8List(r.contentLength ?? 0);
        int offset = 0;
        for (List<int> chunk in chunks) {
          bytes.setRange(offset, offset + chunk.length, chunk);
          offset += chunk.length;
        }
        await file.writeAsBytes(bytes); 


        updateDownloadStatus(DownloadStatusEnum.completed);
        _downloadSubscription.cancel();
        _downloadPercentage = 0;

        notifyListeners();
        printDebug('DownloadFile: Completed');
        completer.complete();

        Navigator.pop(context);
        return;
      });
    });

    await completer.future;
  }

  void updateDownloadStatus(DownloadStatusEnum status) {
    _downloadStatus = status;
    printDebug('updateDownloadStatus: $status');
    notifyListeners();
  }
}
