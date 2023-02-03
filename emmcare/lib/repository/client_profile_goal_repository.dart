import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/res/app_url.dart';

import '../model/client_profile_goal_model.dart';

class ClientProfileGoalRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  Future<ClientProfileGoalModel> fetchClientProfileGoalList() async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponse(AppUrl.clientProfileGoalEndPoint);
      return response = ClientProfileGoalModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
