import 'dart:convert';
import 'package:emmcare/widgets/file_viewer/my_document_viewer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/my_document_model.dart';
import '../model/user_model.dart';
import '../res/app_url.dart';
import '../res/colors.dart';
import '../view_model/user_view_view_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class MyDocumentView extends StatefulWidget {
  MyDocumentView({Key? key}) : super(key: key);
  @override
  State<MyDocumentView> createState() => _MyDocumentViewState();
}

class _MyDocumentViewState extends State<MyDocumentView> {
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
        AppUrl.getPersonalDocuments(page, realtedUserType, realtedUserId),
      ),
      headers: requestHeaders,
    );
    //
    //
    print(response);
    print(AppUrl.getPersonalDocuments(page, realtedUserType, realtedUserId));
    //
    //

    var data = json.decode(response.body);
    MyDocumentModel modelClass = MyDocumentModel.fromJson(data);
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
        title: Text("MY Documents"),
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
        automaticallyImplyLeading: true,
      ),
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
                                        builder: (context) =>
                                            MyDocumentViewer(),
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
