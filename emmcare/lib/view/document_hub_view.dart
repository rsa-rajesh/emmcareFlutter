import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../res/colors.dart';
import '../view_model/document_hub_view_view_model.dart';
import '../widgets/file_viewer/document_hub_viewer.dart';

class DocumentHubView extends StatefulWidget {
  @override
  _DocumentHubViewState createState() => _DocumentHubViewState();
}

class _DocumentHubViewState extends State<DocumentHubView> {
  DocumentHubViewViewModel _DocumentHubViewViewModel =
      DocumentHubViewViewModel();
  final ScrollController _controller = ScrollController();
  bool _refresh = true;
  @override
  void initState() {
    _DocumentHubViewViewModel.fetchDocumentHubListApi(_refresh == false);
    super.initState();
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      _DocumentHubViewViewModel.fetchDocumentHubListApi(_refresh == false);
    }
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  Future<void> refresh() async {
    setState(() {
      _DocumentHubViewViewModel.fetchDocumentHubListApi(_refresh == true);
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
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: refresh,
        child: ChangeNotifierProvider<DocumentHubViewViewModel>(
            create: (BuildContext context) => _DocumentHubViewViewModel,
            child: Consumer<DocumentHubViewViewModel>(
              builder: (context, value, child) {
                return ListView.builder(
                  controller: _controller,
                  itemCount: value.documents.length,
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
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 6, 8, 6),
                                  child: Text(
                                    value.documents[index].docCategory
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 6, 8, 6),
                                  child: Text(
                                    value.documents[index].expiryDate
                                        .toString(),
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 6, 8, 6),
                                    child: Text(
                                      splitFileName(value.documents[index].file
                                          .toString()),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 6, 8, 6),
                                  child: InkWell(
                                    onTap: () {
                                      String fileExtention = checkFileExtention(
                                          value.documents[index].file
                                              .toString());
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
                                                DocumentHubViewer(),
                                            settings: RouteSettings(
                                              arguments: value.documents[index],
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
                  },
                );
              },
            )),
      ),
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
