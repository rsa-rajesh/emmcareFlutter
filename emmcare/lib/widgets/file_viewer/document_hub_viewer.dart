import 'dart:io';

import 'package:dio/dio.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/res/components/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../model/document_hub_model.dart';
import 'package:path_provider/path_provider.dart';

class DocumentHubViewer extends StatefulWidget {
  const DocumentHubViewer({super.key});
  @override
  State<DocumentHubViewer> createState() => _DocumentHubViewerState();
}

class _DocumentHubViewerState extends State<DocumentHubViewer> {
  @override
  Widget build(BuildContext context) {
    final newdocumentList =
        ModalRoute.of(context)!.settings.arguments as Result;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
          automaticallyImplyLeading: true,
        ),
        body: Stack(
          children: [
            PDF().cachedFromUrl(
              newdocumentList.file.toString(),
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
                    // You can request multiple permissions at once.
                    Map<Permission, PermissionStatus> statuses = await [
                      Permission.storage,
                    ].request();

                    print(statuses[Permission.storage]);

                    if (statuses[Permission.storage]!.isGranted) {
                      final Directory appDocumentsDir =
                          await getApplicationDocumentsDirectory();

                      if (appDocumentsDir != null) {
                        String savename = "banner.pdf";
                        String savePath = appDocumentsDir.path + "/$savename";
                        print(savePath);
                        //output:  /storage/emulated/0/Download/banner.png

                        try {
                          await Dio().download(
                              newdocumentList.file.toString(), savePath,
                              onReceiveProgress: (received, total) {
                            if (total != -1) {
                              print(
                                  (received / total * 100).toStringAsFixed(0) +
                                      "%");
                              //you can build progressbar feature too
                            }
                          });
                          print("Image is saved to download folder.");
                        } on DioError catch (e) {
                          print(e.message);
                        }
                      }
                    } else {
                      print("No permission to read and write.");
                    }
                  },
                ))
          ],
        ));
  }
}
