import 'package:emmcare/model/client_profile_documents_model.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/res/components/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class ClientProfileDocumentsViewer extends StatefulWidget {
  @override
  State<ClientProfileDocumentsViewer> createState() =>
      _ClientProfileDocumentsViewerState();
}

class _ClientProfileDocumentsViewerState
    extends State<ClientProfileDocumentsViewer> {
  @override
  Widget build(BuildContext context) {
    final newclientProfielDocumentsList =
        ModalRoute.of(context)!.settings.arguments as Result;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor, //appbar background color
        ),
        body: Stack(
          children: [
            PDF().cachedFromUrl(
              newclientProfielDocumentsList.file.toString(),
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
