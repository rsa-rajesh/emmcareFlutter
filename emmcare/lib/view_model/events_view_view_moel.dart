import 'package:emmcare/data/response/api_response.dart';
import 'package:flutter/material.dart';
import '../model/events_model.dart';
import '../repository/events_repository.dart';

class EventsViewViewModel extends ChangeNotifier {
  final _myRepo = EventsRepository();

  ApiResponse<EventsModel> eventsList = ApiResponse.loading();

  setEventsList(ApiResponse<EventsModel> response) {
    eventsList = response;
    notifyListeners();
  }

  Future<void> fetchEventsListApi(int page) async {
    setEventsList(ApiResponse.loading());
    _myRepo.fetchEventsList(page).then(
      (value) {
        setEventsList(ApiResponse.completed(value));
      },
    ).onError(
      (error, stackTrace) {
        setEventsList(ApiResponse.error(error.toString()));
      },
    );
  }
}
