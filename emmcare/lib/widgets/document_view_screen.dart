import 'package:emmcare/model/document_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() {
  runApp(MaterialApp(home: DocumentView()));
}

class DocumentView extends StatefulWidget {
  @override
  State<DocumentView> createState() => _DocumentViewState();
}

class _DocumentViewState extends State<DocumentView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dlist = ModalRoute.of(context)!.settings.arguments as DocumentModel;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.lightBlueAccent //appbar background color
            ),
        body: Stack(
          children: [
            SfPdfViewer.network(
              dlist.documentUrl!,
              scrollDirection: PdfScrollDirection.vertical,
            ),
            // Positioned(
            //     bottom: 34,
            //     right: 150,
            //     child:
            //         ElevatedButton(onPressed: () {}, child: Text("Download")))
          ],
        ));
  }
}
