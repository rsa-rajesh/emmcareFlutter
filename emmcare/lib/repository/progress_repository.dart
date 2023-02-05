import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/res/app_url.dart';
import '../model/progress_model.dart';

class ProgressRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  Future<ProgressModel> fetchProgressList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.progressEndPoint);
      return response = ProgressModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
