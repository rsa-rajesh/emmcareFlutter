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
      appBar: AppBar(
        title: Text("MY Documents"),
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
            return Card(
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyDocumentViewer(),
                            settings: RouteSettings(
                              arguments: result[index],
                            ),
                          ),
                        );
                      },
                      child: Icon(Icons.download),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

//
// Method for spliting the file name
  String splitFileName(String fileName) {
    String unSplittedFileName = fileName;
    //split string
    var splitteFileName = unSplittedFileName.split('/');
    print(splitteFileName);
    return splitteFileName[5];
  }
// Method for spliting the file name
//
}
