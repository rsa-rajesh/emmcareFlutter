import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/res/app_url.dart';
import '../model/tasks_model.dart';

class TasksRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  Future<TasksModel> fetchTasksList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.tasksEndPoint);
      return response = TasksModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
