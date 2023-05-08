import 'dart:io';
import 'package:emmcare/res/components/navigation_drawer.dart';
import 'package:emmcare/view_model/my_document_view_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../res/colors.dart';
import '../utils/utils.dart';
import '../widgets/file_viewer/my_document_viewer.dart';
import 'package:http/http.dart' as http;

class MyDocumentView extends StatefulWidget {
  @override
  _MyDocumentViewState createState() => _MyDocumentViewState();
}

class _MyDocumentViewState extends State<MyDocumentView> {
  MyDocumentViewViewModel _myDocumentViewViewModel = MyDocumentViewViewModel();
  final ScrollController _controller = ScrollController();
  bool _refresh = true;
  @override
  void initState() {
    _myDocumentViewViewModel.fetchDocumentListApi(_refresh == false);
    super.initState();
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      _myDocumentViewViewModel.fetchDocumentListApi(_refresh == false);
    }
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  Future<void> refresh() async {
    setState(() {
      _myDocumentViewViewModel.fetchDocumentListApi(_refresh == true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bodyBackgroudColor,
      appBar: AppBar(
        title: Text("MY Documents"),
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
        automaticallyImplyLeading: true,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: refresh,
        child: ChangeNotifierProvider<MyDocumentViewViewModel>(
            create: (BuildContext context) => _myDocumentViewViewModel,
            child: Consumer<MyDocumentViewViewModel>(
              builder: (context, value, child) {
                return _myDocumentViewViewModel.apiLoading
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
                                          checkDocCat(
                                            value.documents[index].docCategory
                                                .toString(),
                                          ),
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
                                                      MyDocumentViewer(),
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
      drawer: NavDrawer(),
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
      // Download file
      final http.Response response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 20));

      // Get Application Documents
      final Directory appDocumentsDir =
          await getApplicationDocumentsDirectory();

      // Create a file name.
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
