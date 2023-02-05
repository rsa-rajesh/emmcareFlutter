import 'package:emmcare/data/response/api_response.dart';
import 'package:flutter/cupertino.dart';
import '../model/tasks_model.dart';
import '../repository/tasks_repository.dart';

class TasksViewViewModel with ChangeNotifier {
  final _myRepo = TasksRepository();

  ApiResponse<TasksModel> tasksList = ApiResponse.loading();

  setTasksList(ApiResponse<TasksModel> response) {
    tasksList = response;
    notifyListeners();
  }

  Future<void> fetchTasksListApi() async {
    setTasksList(ApiResponse.loading());
    _myRepo.fetchTasksList().then(
      (value) {
        setTasksList(ApiResponse.completed(value));
      },
    ).onError(
      (error, stackTrace) {
        setTasksList(ApiResponse.error(error.toString()));
      },
    );
  }
}
