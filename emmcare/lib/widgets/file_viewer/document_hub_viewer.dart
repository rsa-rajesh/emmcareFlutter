import 'package:emmcare/model/document_hub_model.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/res/components/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class DocumentHubViewer extends StatefulWidget {
  @override
  State<DocumentHubViewer> createState() => _DocumentHubViewerState();
}

class _DocumentHubViewerState extends State<DocumentHubViewer> {
  @override
  Widget build(BuildContext context) {
    final newdocumentHubList =
        ModalRoute.of(context)!.settings.arguments as DocumentHub;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor, //appbar background color
        ),
        body: Stack(
          children: [
            PDF().cachedFromUrl(
              newdocumentHubList.documentUrl.toString(),
              maxAgeCacheObject: Duration(days: 30), //duration of cache
              placeholder: (progress) => Center(child: Text('$progress %')),
              errorWidget: (error) => Center(child: Text(error.toString())),
            ),
            Positioned(
                bottom: 37,
                right: 105,
                child: RoundButton(
                  title: "Download",
                  onPress: () async {},
                ))
          ],
        ));
  }
}
