import 'package:flutter/material.dart';
import '../data/response/api_response.dart';
import '../model/client_profile_documents_model.dart';
import '../repository/client_profile_document_repository.dart';

class ClientProfileDocumentsViewViewModel extends ChangeNotifier {
  final _myRepo = ClientProfileDocumentsRepository();

  ApiResponse<ClientProfileDocumentsModel> clientProfiledocumentsList =
      ApiResponse.loading();

  setClientProfileDocumentsList(
      ApiResponse<ClientProfileDocumentsModel> response) {
    clientProfiledocumentsList = response;
    notifyListeners();
  }

  Future<void> fetchClientProfileDocumentsListApi(int page) async {
    setClientProfileDocumentsList(ApiResponse.loading());
    _myRepo.fetchClientProfileDocumentsList(page).then(
      (value) {
        setClientProfileDocumentsList(ApiResponse.completed(value));
      },
    ).onError(
      (error, stackTrace) {
        setClientProfileDocumentsList(ApiResponse.error(error.toString()));
      },
    );
  }
}
