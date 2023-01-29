import 'package:emmcare/data/response/status.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/res/components/navigation_drawer.dart';
import 'package:emmcare/widgets/document_hub_widgets/document_hub_viewer.dart';
import 'package:emmcare/view_model/ducument_hub_view_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DocumentHubView extends StatefulWidget {
  const DocumentHubView({super.key});

  @override
  State<DocumentHubView> createState() => _DocumentHubViewState();
}

class _DocumentHubViewState extends State<DocumentHubView> {
  DocumentHubViewViewModel documentHubViewViewModel =
      DocumentHubViewViewModel();

  @override
  void initState() {
    documentHubViewViewModel.fetchDocumentHubListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Document Hub"),
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
        automaticallyImplyLeading: true,
      ),
      body: ChangeNotifierProvider<DocumentHubViewViewModel>(
        create: (BuildContext context) => documentHubViewViewModel,
        child: Consumer<DocumentHubViewViewModel>(
          builder: (context, value, _) {
            switch (value.documentHubList.status) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());

              case Status.ERROR:
                return Center(
                    child: Text(value.documentHubList.message.toString()));

              case Status.COMPLETED:
                return ListView.builder(
                  itemCount: value.documentHubList.data!.documentHub!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: IconButton(
                          iconSize: 30,
                          splashColor: Colors.lightBlueAccent,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DocumentHubViewer(),
                                // Pass the arguments as part of the RouteSettings. The
                                // DetailScreen reads the arguments from these settings.
                                settings: RouteSettings(
                                  arguments: value.documentHubList.data!
                                      .documentHub![index],
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.picture_as_pdf),
                        ),
                        title: Text(
                          value.documentHubList.data!.documentHub![index]
                              .documentName
                              .toString(),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        trailing: Text(
                          value.documentHubList.data!.documentHub![index]
                              .uploadDate
                              .toString(),
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                );
              default:
                return Container(); // just to satisfy flutter analyzer

            }
          },
        ),
      ),
      drawer: NavigationDrawer(),
    );
  }
}
