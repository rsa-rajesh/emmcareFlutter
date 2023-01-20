import 'package:emmcare/res/components/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DocumentHubViewer extends StatefulWidget {
  @override
  State<DocumentHubViewer> createState() => _DocumentHubViewerState();
}

class _DocumentHubViewerState extends State<DocumentHubViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.lightBlueAccent //appbar background color
            ),
        body: Stack(
          children: [
            PDF().cachedFromUrl(
              "https://www.fluttercampus.com/sample.pdf",

              maxAgeCacheObject: Duration(days: 30), //duration of cache
              placeholder: (progress) => Center(child: Text('$progress %')),
              errorWidget: (error) => Center(child: Text(error.toString())),
            ),
            Positioned(
                bottom: 37,
                right: 105,
                child: RoundButton(
                  title: "Download",
                  onPress: () async {
                    // final status = await Permission.storage.request();

                    // if (status.isGranted) {
                    //   final externalDir = await getExternalStorageDirectory();
                    //   final id = await FlutterDownloader.enqueue(
                    //       url: "https://www.fluttercampus.com/sample.pdf",
                    //       savedDir: externalDir!.path,
                    //       fileName: "download",
                    //       showNotification: true,
                    //       openFileFromNotification: true);
                    // } else {
                    //   print("Permission denied");
                    // }
                  },
                ))
          ],
        ));
  }
}
