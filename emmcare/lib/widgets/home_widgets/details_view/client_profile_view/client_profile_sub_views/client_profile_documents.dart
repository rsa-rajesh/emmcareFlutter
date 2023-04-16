import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../model/client_profile_documents_model.dart';
import '../../../../../model/user_model.dart';
import '../../../../../res/app_url.dart';
import '../../../../../res/colors.dart';
import '../../../../../utils/utils.dart';
import '../../../../../view/home_view.dart';
import '../../../../../view_model/user_view_view_model.dart';
import '../../../../file_viewer/client_profile_documents_viewer.dart';

class ClientProfileDocumentsView extends StatefulWidget {
  ClientProfileDocumentsView({Key? key}) : super(key: key);

  @override
  State<ClientProfileDocumentsView> createState() =>
      _ClientProfileDocumentsViewState();
}

class _ClientProfileDocumentsViewState
    extends State<ClientProfileDocumentsView> {
  List<Result> result = [];
  ScrollController scrollController = ScrollController();
  bool loading = true;
  int offset = 1;
  @override
  void initState() {
    super.initState();
    getClientId();
    fetchData(offset);
    handleNext();
  }

  int? cltId;
  Future<void> getClientId() async {
    final sharedpref = await SharedPreferences.getInstance();
    setState(() {
      cltId = sharedpref.getInt(HomeViewState.KEYCLIENTID)!;
    });
  }

  void fetchData(page) async {
    setState(() {
      loading = true;
    });
    var token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      setState(() {
        token = value.access.toString();
      });
    });
    await Future.delayed(Duration(microseconds: 1));
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    // var realtedUserType = "client";
    // var realtedUserId = cltId;
    var realtedUserType = "";
    var realtedUserId = "";

    var response = await http.get(
      Uri.parse(
        AppUrl.getPersonalDocuments(page, realtedUserType, realtedUserId),
      ),
      headers: requestHeaders,
    );
    //
    //
    print(response);
    print(
      AppUrl.getPersonalDocuments(page, realtedUserType, realtedUserId),
    );
    //
    //
    var data = json.decode(response.body);
    ClientProfileDocumentsModel modelClass =
        ClientProfileDocumentsModel.fromJson(data);
    result = result + modelClass.results;
    int localOffset = offset + 1;
    setState(() {
      result;
      loading = false;
      offset = localOffset;
    });
  }

  void handleNext() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        fetchData(offset);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bodyBackgroudColor,
      body: result.length == 0
          ? Center(
              child: loading
                  ? CircularProgressIndicator()
                  : Center(
                      child: Text(
                        "No Documents!",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
            )
          : ListView.builder(
              controller: scrollController,
              itemCount: result.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                              child: Text(
                                result[index].docCategory.toString(),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            )),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                              child: Text(
                                result[index].expiryDate.toString(),
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                                child: Text(
                                  splitFileName(result[index].file.toString()),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                              child: InkWell(
                                onTap: () {
                                  String fileExtention = checkFileExtention(
                                      result[index].file.toString());
                                  String fileName = splitFileName(
                                      result[index].file.toString());
                                  String pdfExtension = "pdf";
                                  if (fileExtention == pdfExtension) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ClientProfileDocumentsViewer(),
                                        settings: RouteSettings(
                                          arguments: result[index],
                                        ),
                                      ),
                                    );
                                  } else {
                                    _saveFile(
                                        context,
                                        result[index].file.toString(),
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
              }),
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
}
