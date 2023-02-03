import 'package:emmcare/data/response/api_response.dart';
import 'package:flutter/cupertino.dart';
import '../model/client_profile_documents_model.dart';
import '../repository/client_profile_documents_repository.dart';

class ClientProfileDocumentsViewViewModel with ChangeNotifier {
  final _myRepo = ClientProfileDocumentsRepository();

  ApiResponse<ClientProfileDocumentsModel> clientProfiledocumentsList =
      ApiResponse.loading();

  setClientProfileDocumentsList(
      ApiResponse<ClientProfileDocumentsModel> response) {
    clientProfiledocumentsList = response;
    notifyListeners();
  }

  Future<void> fetchClientProfileDocumentsListApi() async {
    setClientProfileDocumentsList(ApiResponse.loading());
    _myRepo.fetchClientProfileDocumentsList().then(
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
