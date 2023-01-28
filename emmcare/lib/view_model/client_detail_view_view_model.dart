import 'package:emmcare/data/response/api_response.dart';
import 'package:emmcare/model/client_detail_model.dart';
import 'package:emmcare/repository/client_detail_repository.dart';
import 'package:flutter/cupertino.dart';

class ClientDetailViewViewModel with ChangeNotifier {
  final _myRepo = ClientDetailRepository();

  ApiResponse<ClientDetailModel> clientDetail = ApiResponse.loading();

  setClientDetail(ApiResponse<ClientDetailModel> response) {
    clientDetail = response;
    notifyListeners();
  }

  Future<void> fetchClientListApi() async {
    setClientDetail(ApiResponse.loading());
    _myRepo.fetchClientDetail().then(
      (value) {
        setClientDetail(ApiResponse.completed(value));
      },
    ).onError(
      (error, stackTrace) {
        setClientDetail(ApiResponse.error(error.toString()));
      },
    );
  }
}
