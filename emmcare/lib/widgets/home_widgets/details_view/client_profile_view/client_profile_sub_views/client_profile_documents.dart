import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../model/client_profile_documents_model.dart';
import '../../../../../model/user_model.dart';
import '../../../../../res/app_url.dart';
import '../../../../../res/colors.dart';
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
                  children: [
                    ListTile(
                      title: Text(result[index].docCategory.toString()),
                      trailing: Text(
                        result[index].expiryDate.toString(),
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                    ListTile(
                      iconColor: AppColors.buttonColor,
                      subtitle: Text(
                        splitFileName(result[index].file.toString()),
                      ),
                      trailing: InkWell(
                        onTap: () {
                          String fileExtention =
                              checkFileExtention(result[index].file.toString());
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
                                    ClientProfileDocumentsViewer(),
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
