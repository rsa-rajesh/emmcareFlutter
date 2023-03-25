import 'package:emmcare/res/colors.dart';
import 'package:emmcare/res/components/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import '../../model/my_document_model.dart';

class MyDocumentViewer extends StatefulWidget {
  const MyDocumentViewer({super.key});
  @override
  State<MyDocumentViewer> createState() => _MyDocumentViewerState();
}

class _MyDocumentViewerState extends State<MyDocumentViewer> {
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
                  onPress: () {},
                ))
          ],
        ));
  }
}
