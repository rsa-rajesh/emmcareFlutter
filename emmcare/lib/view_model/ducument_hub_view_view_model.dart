import 'package:emmcare/data/response/api_response.dart';
import 'package:emmcare/model/document_hub_model.dart';
import 'package:emmcare/repository/document_hub_repository.dart';
import 'package:flutter/cupertino.dart';

class DocumentHubViewViewModel with ChangeNotifier {
  final _myRepo = DocumentHubRepository();

  ApiResponse<DocumentHubModel> documentHubList = ApiResponse.loading();

  setDocumentHubList(ApiResponse<DocumentHubModel> response) {
    documentHubList = response;
    notifyListeners();
  }

  Future<void> fetchDocumentHubListApi() async {
    setDocumentHubList(ApiResponse.loading());
    _myRepo.fetchDocumentHubList().then(
      (value) {
        setDocumentHubList(ApiResponse.completed(value));
      },
    ).onError(
      (error, stackTrace) {
        setDocumentHubList(ApiResponse.error(error.toString()));
      },
    );
  }
}
