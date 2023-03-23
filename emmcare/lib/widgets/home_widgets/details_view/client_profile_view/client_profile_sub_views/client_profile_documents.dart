import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../../model/client_profile_documents_model.dart';
import '../../../../../model/user_model.dart';
import '../../../../../res/app_url.dart';
import '../../../../../view_model/user_view_view_model.dart';
import '../../../../file_viewer/client_profile_documents_viewer.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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
    fetchData(offset);
    handleNext();
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
    // Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
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
    print(response);

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
              child: Wrap(
                children: [
                  ListTile(
                    leading: InkWell(
                      onTap: () {
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
                      },
                      child: Icon(Icons.picture_as_pdf),
                    ),
                  ),
                  Text(
                    result[index].user,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  Text(
                    result[index].file,
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  Text(
                    result[index].docCategory,
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  Text(
                    result[index].relatedUserType,
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  Text(
                    result[index].contentType,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
