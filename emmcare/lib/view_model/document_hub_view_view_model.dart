import 'package:flutter/material.dart';
import '../data/response/api_response.dart';
import '../model/document_hub_model.dart';
import '../repository/document_hub_repository.dart';

class DocumentHubViewViewModel extends ChangeNotifier {
  final _myRepo = DocumentHubRepository();

  ApiResponse<DocumentHubModel> documentHubList = ApiResponse.loading();

  setDocumentHubList(ApiResponse<DocumentHubModel> response) {
    documentHubList = response;
    notifyListeners();
  }

  Future<void> fetchDocumentHubListApi(int page) async {
    setDocumentHubList(ApiResponse.loading());
    _myRepo.fetchMyDocumentList(page).then(
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
