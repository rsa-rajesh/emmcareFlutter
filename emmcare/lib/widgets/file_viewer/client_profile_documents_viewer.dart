import 'dart:io';
import 'package:emmcare/model/client_profile_documents_model.dart';
import 'package:emmcare/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import '../../utils/utils.dart';
import 'package:http/http.dart' as http;

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
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.appBarColor, //appbar background color
        actions: [
          InkWell(
              onTap: () {
                String fileName = splitFileName(
                    newclientProfielDocumentsList.file.toString());
                _saveFile(context,
                    newclientProfielDocumentsList.file.toString(), fileName);
              },
              splashColor: Colors.lightBlueAccent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.download),
                  ],
                ),
              ))
        ],
      ),
      body: PDF().cachedFromUrl(
        newclientProfielDocumentsList.file.toString(),
        maxAgeCacheObject: Duration(days: 30), //duration of cache
        placeholder: (progress) => Center(child: Text('$progress %')),
        errorWidget: (error) => Center(child: Text(error.toString())),
      ),
    );
  }

  String splitFileName(String fileName) {
    String unSplittedFileName = fileName;
    //split string
    var splitteFileName = unSplittedFileName.split('/');
    return splitteFileName[5];
  }

  Future<void> _saveFile(BuildContext context, url, fileName) async {
    String? message;

    try {
      // Download image
      final http.Response response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 20));

      // Get Application Documents
      final Directory appDocumentsDir =
          await getApplicationDocumentsDirectory();

      // Create an image name
      var filename = '${appDocumentsDir.path}/$fileName';

      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      // Ask the user to save it
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        message = 'File downloaded to ${appDocumentsDir.path} successfully.';
      }
    } catch (e) {
      message = 'An error occurred while downloading the file.';
    }

    if (message != null) {
      Utils.toastMessage(message);
    }
  }
}
