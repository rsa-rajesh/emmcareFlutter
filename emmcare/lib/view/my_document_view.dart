import 'dart:convert';
import 'package:emmcare/widgets/file_viewer/my_document_viewer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/my_document_model.dart';
import '../res/colors.dart';

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
    var token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjg2MTk4Njg5LCJpYXQiOjE2Nzc1NTg2ODksImp0aSI6ImRhNGIyYTEwYTcyZjQ1MTM5MzUyYWQyMWJjNGM4NjA3IiwidXNlcl9pZCI6NjUsInVzZXJuYW1lIjoiRW1tY19BZG1pbkRSN1giLCJlbWFpbCI6Im5hYmFAZW1tYy5jb20uYXUiLCJyb2xlIjoib3duZXIiLCJwcm9maWxlX2lkIjo2NCwiaWQiOjY1LCJmY21fcmVnaXN0cmF0aW9uX2lkIjoiZFVmeEZJNVNSRk9xRURsVzdvZWh4QTpBUEE5MWJINlhhNzJubnJxZUpYVVo3OWpxZURyVXJTaWtCQUZ2WFJ2RnNMRTR4RDBfX25zbjJuTlRLamZ0QVpyTDFrUWhXTHh0S1BzTHVPT0lZeFMyNjJidlZRQ0RrM1hseENGZnlYNFVsMXY5ZlJCQ3gxSi1JSERscmV1REM3VmhjTkxQaVJDbWx4WCIsImVuZHNfaW4iOiIyMDI5LTAyLTA2In0.EwkcNKY0BJQzmq7OlVsKuJUqhTOx3ZElRvJRHk1TPnU";
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(
        Uri.parse(
            "http://pwnbot-agecare-backend.clouds.nepalicloud.com/v1/api/document/document-list/?page=${page}&page_size=2"),
        headers: requestHeaders);
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
                      height: 200,
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                        ),
                      ),
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
                            builder: (context) => MyDocumentViewer(),
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
