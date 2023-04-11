import 'package:emmcare/view_model/my_document_view_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../res/colors.dart';
import '../widgets/file_viewer/my_document_viewer.dart';

class MyDocumentView extends StatefulWidget {
  @override
  _MyDocumentViewState createState() => _MyDocumentViewState();
}

class _MyDocumentViewState extends State<MyDocumentView> {
  MyDocumentViewViewModel _myDocumentViewViewModel = MyDocumentViewViewModel();
  final ScrollController _controller = ScrollController();
  bool _refresh = true;
  @override
  void initState() {
    _myDocumentViewViewModel.fetchDocumentListApi(_refresh == false);
    super.initState();
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      _myDocumentViewViewModel.fetchDocumentListApi(_refresh == false);
    }
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  Future<void> refresh() async {
    setState(() {
      _myDocumentViewViewModel.fetchDocumentListApi(_refresh == true);
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
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: refresh,
        child: ChangeNotifierProvider<MyDocumentViewViewModel>(
            create: (BuildContext context) => _myDocumentViewViewModel,
            child: Consumer<MyDocumentViewViewModel>(
              builder: (context, value, child) {
                return ListView.builder(
                  controller: _controller,
                  itemCount: value.documents.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 200, 8, 200),
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
                                    value.documents[index].id.toString(),
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
                                                MyDocumentViewer(),
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
