import 'package:emmcare/data/response/api_response.dart';
import 'package:emmcare/model/client_model_v2.dart';
import 'package:emmcare/model/job_board_model.dart';
import 'package:emmcare/repository/job_repository.dart';
import 'package:flutter/cupertino.dart';

class JobBoardViewViewModel with ChangeNotifier {
  final _myRepo = JobRepository();

  ApiResponse<JobBoardModel> JobList = ApiResponse.loading();

  setJobList(ApiResponse<JobBoardModel> response) {
    JobList = response;
    notifyListeners();
  }

  Future<void> fetchJobListApi() async {
    setJobList(ApiResponse.loading());
    _myRepo.fetchJobList().then(
      (value) {
        setJobList(ApiResponse.completed(value));
      },
    ).onError(
      (error, stackTrace) {
        setJobList(ApiResponse.error(error.toString()));
      },
    );
  }
}
