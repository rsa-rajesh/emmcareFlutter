import 'package:emmcare/model/my_document_model.dart';
import 'package:flutter/material.dart';
import '../repository/my_document_repository.dart';

class MyDocumentViewViewModel extends ChangeNotifier {
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

  fetchDocumentListApi(_refresh) async {
    if (_refresh == true) {
      _documents.clear();
      _page = 1;
      _apiLoading = true;
      await MyDocumentRepository().fetchDocumentList(_page).then((response) {
        _page = _page + 1;
        var data = MyDocumentModel.fromJson(response);
        _documents.clear();
        _documents = data.results!;
      });
      _apiLoading = false;
      notifyListeners();
    } else if (_refresh == false) {
      _apiLoading = true;
      await MyDocumentRepository().fetchDocumentList(_page).then((response) {
        _page = _page + 1;
        var data = MyDocumentModel.fromJson(response);
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
