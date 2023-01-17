import 'dart:async';
import 'dart:convert';
import 'package:emmcare/model/document_model.dart';
import 'package:emmcare/widgets/document_view_screen.dart';
import 'package:emmcare/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class MyDocumentScreen extends StatefulWidget {
  const MyDocumentScreen({super.key});

  @override
  State<MyDocumentScreen> createState() => _MyDocumentScreenState();
}

class _MyDocumentScreenState extends State<MyDocumentScreen> {
  late Future<List<DocumentModel>> futureDocument;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  void initState() {
    super.initState();

    futureDocument = fetchDocument();

    //
    //
  }

  // List of Client coming from api.
  List<DocumentModel> documentList = [];

  // Future fuction used to fetch data from the server.
  // It is also used to refresh the home page.
  Future<List<DocumentModel>> fetchDocument() async {
    // Encoded data from the api.
    final response = await http.get(
      Uri.parse("https://6396d55077359127a023e18b.mockapi.io/emmcare_client"),
    );

    // Decoded data
    var data = jsonDecode(response.body);
    // clearing the list item.
    documentList.clear();
    if (response.statusCode == 200) {
      for (Map i in data) {
        setState(() {
          documentList.add(DocumentModel.fromJson(i));
        });
      }
      return documentList;
    } else {
      throw Exception("Failed to load Documents.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: Text(
          "My Document",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: FutureBuilder<List<DocumentModel>>(
                future: fetchDocument(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return RefreshIndicator(
                      onRefresh: fetchDocument,
                      child: ListView.builder(
                        itemCount: documentList.length,
                        // Make listView scrollable
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Card(
                                        color: Colors.white,
                                        child: Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    _pdfViewerKey.currentState
                                                        ?.openBookmarkView();
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              DocumentView(),
                                                          settings: RouteSettings(
                                                              arguments:
                                                                  documentList[
                                                                      index]),
                                                        ));
                                                  },
                                                  icon: Icon(
                                                      Icons.picture_as_pdf),
                                                )
                                              ],
                                            ),
                                            VerticalDivider(),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          snapshot.data![index]
                                                              .expiryDate
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .redAccent,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      snapshot.data![index]
                                                          .documentName
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                              ],
                            ),
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
