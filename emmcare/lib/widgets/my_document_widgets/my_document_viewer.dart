import 'package:emmcare/model/my_document_model.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/res/components/round_button.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class MyDocumentViewer extends StatefulWidget {
  const MyDocumentViewer({super.key});

  @override
  State<MyDocumentViewer> createState() => _MyDocumentViewerState();
}

class _MyDocumentViewerState extends State<MyDocumentViewer> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final newdocumentList =
        ModalRoute.of(context)!.settings.arguments as Mydocuments;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
          automaticallyImplyLeading: true,
        ),
        body: Stack(
          children: [
            SfPdfViewer.network(
              // 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
              newdocumentList.documentUrl.toString(),
              key: _pdfViewerKey,
              enableDoubleTapZooming: true,
              canShowScrollStatus: true,
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
