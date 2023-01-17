import 'dart:convert';

import 'package:emmcare/model/document_hub_model.dart';
import 'package:emmcare/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

class DocumentHubScreen extends StatefulWidget {
  const DocumentHubScreen({super.key});

  @override
  State<DocumentHubScreen> createState() => _DocumentHubScreenState();
}

class _DocumentHubScreenState extends State<DocumentHubScreen> {
  late Future<List<DocumentHubModel>> futureDocumentHub;

  void initState() {
    super.initState();

    futureDocumentHub = fetchDocumentHub();

    //
    //
  }

  // List of Client coming from api.
  List<DocumentHubModel> documentHubList = [];

  // Future fuction used to fetch data from the server.
  // It is also used to refresh the home page.
  Future<List<DocumentHubModel>> fetchDocumentHub() async {
    // Encoded data from the api.
    final response = await http.get(
      Uri.parse("https://6396d55077359127a023e18b.mockapi.io/document_hub"),
    );

    // Decoded data
    var data = jsonDecode(response.body);
    // clearing the list item.
    documentHubList.clear();
    if (response.statusCode == 200) {
      for (Map i in data) {
        setState(() {
          documentHubList.add(DocumentHubModel.fromJson(i));
        });
      }
      return documentHubList;
    } else {
      throw Exception("Failed to load Documents.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text(
          "Document Hub",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: FutureBuilder<List<DocumentHubModel>>(
                future: fetchDocumentHub(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return RefreshIndicator(
                      onRefresh: fetchDocumentHub,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: documentHubList.length,
                        // Make listView scrollable
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  // height of the card widget
                                  constraints: BoxConstraints(maxHeight: 120),
                                  //  Home Screen Card Widget. //
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Card(
                                        elevation: 0,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Wrap(
                                            direction: Axis.horizontal,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Expanded(
                                                  //   child: Text(
                                                  //     snapshot.data![index]
                                                  //         .documentName
                                                  //         .toString(),
                                                  //     style: TextStyle(
                                                  //         fontSize: 12,
                                                  //         fontWeight:
                                                  //             FontWeight
                                                  //                 .bold),
                                                  //   ),
                                                  // ),
                                                  Expanded(
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.right,
                                                      snapshot.data![index]
                                                          .uploadDate
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Expanded(
                                                  //     child: Container()),
                                                  Expanded(
                                                      child: Text(
                                                    snapshot.data![index]
                                                        .documentName
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  Expanded(
                                                      child: IconButton(
                                                    onPressed: () async {},
                                                    alignment:
                                                        Alignment(2.0, 3.0),
                                                    icon: Icon(Icons.download),
                                                  ))
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // Show a loading spinner.
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
