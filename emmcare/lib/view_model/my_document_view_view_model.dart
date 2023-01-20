import 'package:emmcare/data/response/api_response.dart';
import 'package:emmcare/model/my_document_model.dart';
import 'package:emmcare/repository/my_document_repository.dart';
import 'package:flutter/cupertino.dart';

class MyDocumentViewViewModel with ChangeNotifier {
  final _myRepo = MyDocumentRepository();

  ApiResponse<MyDocumentModel> mydocumentList = ApiResponse.loading();

  setDocumentsList(ApiResponse<MyDocumentModel> response) {
    mydocumentList = response;
    notifyListeners();
  }

  Future<void> fetchDocumentsListApi() async {
    setDocumentsList(ApiResponse.loading());
    _myRepo.fetchMyDocumentList().then(
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
