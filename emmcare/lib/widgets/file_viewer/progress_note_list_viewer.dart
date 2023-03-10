import 'package:emmcare/model/progress_model.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/res/components/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class ProgressNoteViewer extends StatefulWidget {
  ProgressNoteViewer({super.key});

  @override
  State<ProgressNoteViewer> createState() => _ProgressNoteViewerState();
}

class _ProgressNoteViewerState extends State<ProgressNoteViewer> {
  @override
  Widget build(BuildContext context) {
    final newdocumentList =
        ModalRoute.of(context)!.settings.arguments as Progress;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
          automaticallyImplyLeading: true,
        ),
        body: Stack(
          children: [
            PDF().cachedFromUrl(
              newdocumentList.attachment.toString(),
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
