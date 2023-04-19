import 'package:flutter/material.dart';
import '../model/client_profile_documents_model.dart';
import '../repository/client_profile_document_repository.dart';

class ClientProfileDocumentViewViewModel extends ChangeNotifier {
  int _page = 1;
  int get page => _page;
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
      await ClientProfileDocumentRepository()
          .fetchClientProfileDocumentList(_page)
          .then((response) {
        _page = _page + 1;
        var data = ClientProfileDocumentsModel.fromJson(response);
        _documents.clear();
        _documents = data.results;
      });
      notifyListeners();
    } else if (_refresh == false) {
      await ClientProfileDocumentRepository()
          .fetchClientProfileDocumentList(_page)
          .then((response) {
        _page = _page + 1;
        var data = ClientProfileDocumentsModel.fromJson(response);
        addDocumentsToList(data.results);
      });
      notifyListeners();
    }
  }

  void addDocumentsToList(List<Result> documentData) {
    _documents.addAll(documentData);
    notifyListeners();
  }
}
