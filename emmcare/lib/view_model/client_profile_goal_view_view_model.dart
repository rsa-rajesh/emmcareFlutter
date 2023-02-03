import 'package:emmcare/data/response/api_response.dart';
import 'package:flutter/cupertino.dart';
import '../model/client_profile_goal_model.dart';
import '../repository/client_profile_goal_repository.dart';

class ClientProfileGoalViewViewModel with ChangeNotifier {
  final _myRepo = ClientProfileGoalRepository();

  ApiResponse<ClientProfileGoalModel> clientProfileGoalList =
      ApiResponse.loading();

  setClientProfileGoalList(ApiResponse<ClientProfileGoalModel> response) {
    clientProfileGoalList = response;
    notifyListeners();
  }

  Future<void> fetchClientProfileGoalListApi() async {
    setClientProfileGoalList(ApiResponse.loading());
    _myRepo.fetchClientProfileGoalList().then(
      (value) {
        setClientProfileGoalList(ApiResponse.completed(value));
      },
    ).onError(
      (error, stackTrace) {
        setClientProfileGoalList(ApiResponse.error(error.toString()));
      },
    );
  }
}
