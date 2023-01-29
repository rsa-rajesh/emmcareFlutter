import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/model/job_board_model.dart';
import 'package:emmcare/res/app_url.dart';

class JobRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  Future<JobBoardModel> fetchJobList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.JobListEndPoint);
      return response = JobBoardModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
