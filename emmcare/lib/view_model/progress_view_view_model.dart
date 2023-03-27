import 'package:emmcare/data/response/api_response.dart';
import 'package:flutter/cupertino.dart';
import '../model/progress_model.dart';
import '../repository/progress_repository.dart';

class ProgressViewViewModel with ChangeNotifier {
  final _myRepo = ProgressRepository();

  ApiResponse<ProgressModel> progressList = ApiResponse.loading();

  setProgressList(ApiResponse<ProgressModel> response) {
    progressList = response;
    notifyListeners();
  }

  Future<void> fetchProgressListApi() async {
    setProgressList(ApiResponse.loading());

    _myRepo.fetchProgressList().then(
      (value) {
        setProgressList(ApiResponse.completed(value));
      },
    ).onError(
      (error, stackTrace) {
        setProgressList(ApiResponse.error(error.toString()));
      },
    );
  }
}
