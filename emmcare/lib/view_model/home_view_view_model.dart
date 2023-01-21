import 'package:emmcare/data/response/api_response.dart';
import 'package:emmcare/model/client_model.dart';
import 'package:emmcare/repository/home_repository.dart';
import 'package:flutter/cupertino.dart';

class HomeViewViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  ApiResponse<ClientModel> clientList = ApiResponse.loading();

  setClientList(ApiResponse<ClientModel> response) {
    clientList = response;
    notifyListeners();
  }

  Future<void> fetchClientListApi() async {
    setClientList(ApiResponse.loading());
    _myRepo.fetchClientList().then(
      (value) {
        setClientList(ApiResponse.completed(value));
      },
    ).onError(
      (error, stackTrace) {
        setClientList(ApiResponse.error(error.toString()));
      },
    );
  }
}
