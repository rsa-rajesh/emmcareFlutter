import 'package:emmcare/data/response/api_response.dart';
import 'package:flutter/cupertino.dart';
import '../model/client_profile_detail_model.dart';
import '../repository/client_profile_detail_repository.dart';

class ClientProfileDetailViewViewModel with ChangeNotifier {
  final _myRepo = ClientProfileDetailRepository();

  ApiResponse<ClientProfileDetailModel> clientProfileDetailList =
      ApiResponse.loading();

  setClientProfileDetailList(ApiResponse<ClientProfileDetailModel> response) {
    clientProfileDetailList = response;
    notifyListeners();
  }

  Future<void> fetchClientProfileDetailListApi() async {
    setClientProfileDetailList(ApiResponse.loading());
    _myRepo.fetchClientProfileDetailList().then(
      (value) {
        setClientProfileDetailList(ApiResponse.completed(value));
      },
    ).onError(
      (error, stackTrace) {
        setClientProfileDetailList(ApiResponse.error(error.toString()));
      },
    );
  }


}
