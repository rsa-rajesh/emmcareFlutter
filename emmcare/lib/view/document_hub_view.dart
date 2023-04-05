import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/document_hub_model.dart';
import '../model/user_model.dart';
import '../res/app_url.dart';
import '../res/colors.dart';
import '../view_model/user_view_view_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../widgets/file_viewer/document_hub_viewer.dart';

class DocumentHubView extends StatefulWidget {
  DocumentHubView({Key? key}) : super(key: key);
  @override
  State<DocumentHubView> createState() => _DocumentHubViewState();
}

class _DocumentHubViewState extends State<DocumentHubView> {
  List<Result> result = [];
  ScrollController scrollController = ScrollController();
  bool loading = true;
  int offset = 1;

  @override
  void initState() {
    super.initState();
    fetchData(offset);
    handleNext();
  }

  void fetchData(page) async {
    setState(() {
      loading = true;
    });
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 1));

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    // var realtedUserType = decodedToken["role"];
    // var realtedUserId = decodedToken["user_id"];
    var realtedUserType = "";
    var realtedUserId = "";

    var response = await http.get(
      Uri.parse(
        AppUrl.getDocumentHub(page, realtedUserType, realtedUserId),
      ),
      headers: requestHeaders,
    );
    //
    //
    print(response);
    print(AppUrl.getDocumentHub(page, realtedUserType, realtedUserId));
    //
    //

    var data = json.decode(response.body);
    DocumentHubModel modelClass = DocumentHubModel.fromJson(data);
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
      appBar: AppBar(
        title: Text("Document Hub"),
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
        automaticallyImplyLeading: true,
      ),
      body: ListView.builder(
          controller: scrollController,
          itemCount: result.length + 1,
          itemBuilder: (context, index) {
            if (index == result.length) {
              return loading
                  ? Container()
                  : Container(
                      // height: 200,
                      // child: const Center(
                      //   child: CircularProgressIndicator(
                      //     strokeWidth: 4,
                      //   ),
                      // ),
                      );
            }
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
                              String pdfExtension = "pdf";
                              // String docExtension = "doc";
                              // String docxExtension = "docx";
                              // String pngExtension = "png";
                              // String jpgExtension = "jpg";
                              // String jpegExtension = "jpeg";
                              if (fileExtention == pdfExtension) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DocumentHubViewer(),
                                    settings: RouteSettings(
                                      arguments: result[index],
                                    ),
                                  ),
                                );
                              } else {
                                return null;
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
}
