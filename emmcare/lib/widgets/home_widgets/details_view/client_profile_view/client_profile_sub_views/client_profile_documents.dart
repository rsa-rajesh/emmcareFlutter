import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../res/colors.dart';
import '../../../../../utils/utils.dart';
import '../../../../../view_model/client_profile_document_view_view_model.dart';
import '../../../../file_viewer/document_hub_viewer.dart';
import 'package:http/http.dart' as http;

class ClientProfileDocumentsView extends StatefulWidget {
  @override
  _ClientProfileDocumentsViewState createState() =>
      _ClientProfileDocumentsViewState();
}

class _ClientProfileDocumentsViewState
    extends State<ClientProfileDocumentsView> {
  ClientProfileDocumentViewViewModel _clientProfileDocumentViewViewModel =
      ClientProfileDocumentViewViewModel();
  final ScrollController _controller = ScrollController();
  bool _refresh = true;
  @override
  void initState() {
    _clientProfileDocumentViewViewModel
        .fetchClientProfileDocumentListApi(_refresh == false);
    super.initState();
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      _clientProfileDocumentViewViewModel
          .fetchClientProfileDocumentListApi(_refresh == false);
    }
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  Future<void> refresh() async {
    setState(() {
      _clientProfileDocumentViewViewModel
          .fetchClientProfileDocumentListApi(_refresh == true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bodyBackgroudColor,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: refresh,
        child: ChangeNotifierProvider<ClientProfileDocumentViewViewModel>(
            create: (BuildContext context) =>
                _clientProfileDocumentViewViewModel,
            child: Consumer<ClientProfileDocumentViewViewModel>(
              builder: (context, value, child) {
                return value.documents.length == 0
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        controller: _controller,
                        itemCount: value.documents.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 6, 8, 6),
                                        child: Text(
                                          checkDocCat(value
                                              .documents[index].docCategory
                                              .toString()),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 6, 8, 6),
                                        child: Text(
                                          checkExpiry(value
                                              .documents[index].expiryDate
                                              .toString()),
                                          style: TextStyle(
                                              color: Colors.redAccent),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 6, 8, 6),
                                          child: Text(
                                            splitFileName(value
                                                .documents[index].file
                                                .toString()),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 6, 8, 6),
                                        child: InkWell(
                                          onTap: () {
                                            String fileExtention =
                                                checkFileExtention(value
                                                    .documents[index].file
                                                    .toString());
                                            String fileName = splitFileName(
                                                value.documents[index].file
                                                    .toString());
                                            String pdfExtension = "pdf";
                                            if (fileExtention == pdfExtension) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DocumentHubViewer(),
                                                  settings: RouteSettings(
                                                    arguments:
                                                        value.documents[index],
                                                  ),
                                                ),
                                              );
                                            } else {
                                              _saveFile(
                                                  context,
                                                  value.documents[index].file
                                                      .toString(),
                                                  fileName);
                                            }
                                          },
                                          child: Icon(Icons.download),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
              },
            )),
      ),
    );
  }

  String splitFileName(String fileName) {
    String unSplittedFileName = fileName;
    //split string
    var splitteFileName = unSplittedFileName.split('/');
    return splitteFileName[5];
  }

  String checkFileExtention(String fileName) {
    String unSplittedFileName = fileName;
    //split string
    var splitteFileName = unSplittedFileName.split('.');
    return splitteFileName[4];
  }

  Future<void> _saveFile(BuildContext context, url, fileName) async {
    String? message;

    try {
      // Download image
      final http.Response response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 2));

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

  String checkDocCat(String _docCategory) {
    if (_docCategory == "null") {
      return "";
    } else {
      return _docCategory;
    }
  }

  String checkExpiry(String _expiry) {
    if (_expiry == "null") {
      return "";
    } else {
      return _expiry;
    }
  }
}
