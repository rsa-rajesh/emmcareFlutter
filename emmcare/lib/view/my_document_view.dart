import 'dart:io';
import 'package:emmcare/res/components/navigation_drawer.dart';
import 'package:emmcare/view_model/my_document_view_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../data/response/status.dart';
import '../res/colors.dart';
import '../utils/utils.dart';
import '../widgets/file_viewer/my_document_viewer.dart';
import 'package:http/http.dart' as http;

class MyDocumentView extends StatefulWidget {
  @override
  _MyDocumentViewState createState() => _MyDocumentViewState();
}

class _MyDocumentViewState extends State<MyDocumentView> {
  int page = 1;
  MyDocumentViewViewModel myDocumentViewViewModel = MyDocumentViewViewModel();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    myDocumentViewViewModel.fetchDocumentsListApi(page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.appBarColor,
        title: Text(
          "My Records",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () {
          return refresh();
        },
        child: ChangeNotifierProvider<MyDocumentViewViewModel>(
          create: (BuildContext context) => myDocumentViewViewModel,
          child: Consumer<MyDocumentViewViewModel>(
            builder: (context, value, _) {
              switch (value.mydocumentList.status) {
                case Status.LOADING:
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                case Status.ERROR:
                  return Stack(
                    children: [
                      Image.asset(
                        'assets/images/something_went_wrong.png',
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      ),
                      const Positioned(
                        bottom: 230,
                        left: 150,
                        child: Text(
                          'Oh no!',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w900,
                              fontSize: 40),
                        ),
                      ),
                      const Positioned(
                        bottom: 170,
                        left: 100,
                        child: Text(
                          'Something went wrong,\nplease try again.',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w900,
                              fontSize: 20),
                        ),
                      ),
                      Positioned(
                        bottom: 100,
                        left: 130,
                        right: 130,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: StadiumBorder(),
                          ),
                          onPressed: () {
                            refresh();
                          },
                          child: Text(
                            'Try Again',
                          ),
                        ),
                      ),
                    ],
                  );

                case Status.COMPLETED:
                  return value.mydocumentList.data!.results!.isEmpty
                      ? Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "No Records!",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: StadiumBorder(),
                                ),
                                onPressed: () {
                                  refresh();
                                },
                                child: Text(
                                  'Refresh',
                                ),
                              )
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: value.mydocumentList.data!.results!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: Card(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                              value.mydocumentList.data!
                                                  .results![index].docCategory
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
                                                .mydocumentList
                                                .data!
                                                .results![index]
                                                .expiryDate
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
                                              splitFileName(value.mydocumentList
                                                  .data!.results![index].file
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
                                                      .mydocumentList
                                                      .data!
                                                      .results![index]
                                                      .file
                                                      .toString());
                                              String fileName = splitFileName(
                                                  value.mydocumentList.data!
                                                      .results![index].file
                                                      .toString());
                                              String pdfExtension = "pdf";
                                              if (fileExtention ==
                                                  pdfExtension) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyDocumentViewer(),
                                                    settings: RouteSettings(
                                                      arguments: value
                                                          .mydocumentList
                                                          .data!
                                                          .results![index],
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                _saveFile(
                                                    context,
                                                    value.mydocumentList.data!
                                                        .results![index].file
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

                default:
                  return Container(); // just to satisfy flutter analyzer
              }
            },
          ),
        ),
      ),
      drawer: NavDrawer(),
    );
  }

  Future<void> refresh() async {
    setState(() {
      myDocumentViewViewModel.fetchDocumentsListApi(page);
    });
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
