import 'package:flutter/material.dart';
import '../model/document_hub_model.dart';
import '../repository/document_hub_repository.dart';

class DocumentHubViewViewModel extends ChangeNotifier {
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

  fetchDocumentHubListApi(_refresh) async {
    if (_refresh == true) {
      _documents.clear();
      _page = 1;
      await DocumentHubRepository()
          .fetchDocumentHubList(_page)
          .then((response) {
        _page = _page + 1;
        var data = DocumentHubModel.fromJson(response);
        _documents.clear();
        _documents = data.results!;
      });
      notifyListeners();
    } else if (_refresh == false) {
      await DocumentHubRepository()
          .fetchDocumentHubList(_page)
          .then((response) {
        _page = _page + 1;
        var data = DocumentHubModel.fromJson(response);
        addDocumentHubToList(data.results!);
      });
      notifyListeners();
    }
  }

  void addDocumentHubToList(List<Result> documentData) {
    _documents.addAll(documentData);
    notifyListeners();
  }
}
