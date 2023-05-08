import 'package:flutter/material.dart';
import '../model/client_profile_documents_model.dart';
import '../repository/client_profile_document_repository.dart';

class ClientProfileDocumentViewViewModel extends ChangeNotifier {
  int _page = 1;
  int get page => _page;

  bool _apiLoading = false;
  bool get apiLoading => _apiLoading;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  List<Result> _documents = <Result>[];

  List<Result> get documents => _documents;

  set documents(List<Result> value) {
    _documents = value;
    notifyListeners();
  }

  fetchClientProfileDocumentListApi(_refresh) async {
    if (_refresh == true) {
      _documents.clear();
      _page = 1;
      _apiLoading = true;
      await ClientProfileDocumentRepository()
          .fetchClientProfileDocumentList(_page)
          .then((response) {
        _page = _page + 1;
        var data = ClientProfileDocumentsModel.fromJson(response);
        _documents.clear();
        _documents = data.results!;
      });
      _apiLoading = false;
      notifyListeners();
    } else if (_refresh == false) {
      _apiLoading = true;
      await ClientProfileDocumentRepository()
          .fetchClientProfileDocumentList(_page)
          .then((response) {
        _page = _page + 1;
        var data = ClientProfileDocumentsModel.fromJson(response);
        addDocumentsToList(data.results!);
      });
      _apiLoading = false;
      notifyListeners();
    }
  }

  void addDocumentsToList(List<Result> documentData) {
    _documents.addAll(documentData);
    _apiLoading = false;
    notifyListeners();
  }
}
