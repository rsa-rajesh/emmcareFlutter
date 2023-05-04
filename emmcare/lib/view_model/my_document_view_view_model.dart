import 'package:emmcare/model/my_document_model.dart';
import 'package:flutter/material.dart';
import '../repository/my_document_repository.dart';

class MyDocumentViewViewModel extends ChangeNotifier {
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

  fetchDocumentListApi(_refresh) async {
    if (_refresh == true) {
      _documents.clear();
      _page = 1;
      await MyDocumentRepository().fetchDocumentList(_page).then((response) {
        _page = _page + 1;
        var data = MyDocumentModel.fromJson(response);
        _documents.clear();
        _documents = data.results!;
      });
      notifyListeners();
    } else if (_refresh == false) {
      await MyDocumentRepository().fetchDocumentList(_page).then((response) {
        _page = _page + 1;
        var data = MyDocumentModel.fromJson(response);
        addDocumentsToList(data.results!);
      });
      notifyListeners();
    }
  }

  void addDocumentsToList(List<Result> documentData) {
    _documents.addAll(documentData);
    notifyListeners();
  }
}
