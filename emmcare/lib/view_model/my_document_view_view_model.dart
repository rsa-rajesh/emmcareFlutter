import 'package:emmcare/model/my_document_model.dart';
import 'package:flutter/material.dart';
import '../data/response/api_response.dart';
import '../repository/my_document_repository.dart';

class MyDocumentViewViewModel extends ChangeNotifier {
  final _myRepo = MyDocumentRepository();

  ApiResponse<MyDocumentModel> mydocumentList = ApiResponse.loading();

  setDocumentsList(ApiResponse<MyDocumentModel> response) {
    mydocumentList = response;
    notifyListeners();
  }

  Future<void> fetchDocumentsListApi(int page) async {
    setDocumentsList(ApiResponse.loading());
    _myRepo.fetchMyDocumentList(page).then(
      (value) {
        setDocumentsList(ApiResponse.completed(value));
      },
    ).onError(
      (error, stackTrace) {
        setDocumentsList(ApiResponse.error(error.toString()));
      },
    );
  }
}
