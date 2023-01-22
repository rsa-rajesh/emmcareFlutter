import 'package:emmcare/model/document_hub_model.dart';
import 'package:emmcare/res/components/round_button.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DocumentHubViewer extends StatefulWidget {
  @override
  State<DocumentHubViewer> createState() => _DocumentHubViewerState();
}

class _DocumentHubViewerState extends State<DocumentHubViewer> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final newdocumentHubList =
        ModalRoute.of(context)!.settings.arguments as DocumentHub;

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.lightBlueAccent //appbar background color
            ),
        body: Stack(
          children: [
            SfPdfViewer.network(
              // 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
              newdocumentHubList.documentUrl.toString(),
              key: _pdfViewerKey,
              enableDoubleTapZooming: true,
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
