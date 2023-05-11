import 'package:flutter/material.dart';
import '../data/response/api_response.dart';
import '../model/client_profile_goal_model.dart';
import '../repository/client_profile_goal_repository.dart';

class ClientProfileGoalViewViewModel extends ChangeNotifier {
  final _myRepo = ClientProfileGoalRepository();

  ApiResponse<ClientProfileGoalModel> clientProfileGoalList =
      ApiResponse.loading();

  setClientProfileGoalList(ApiResponse<ClientProfileGoalModel> response) {
    clientProfileGoalList = response;
    notifyListeners();
  }

  Future<void> fetchClientProfileGoalListApi(int page) async {
    setClientProfileGoalList(ApiResponse.loading());
    _myRepo.fetchClientProfileGoalList(page).then(
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
