import 'package:flutter/material.dart';
import '../model/events_model.dart';
import '../repository/events_repository.dart';

class EventsViewViewModel extends ChangeNotifier {
  int _page = 1;
  int get page => _page;

  bool _apiLoading = false;
  bool get apiLoading => _apiLoading;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  List<Result> _events = <Result>[];

  List<Result> get events => _events;

  set events(List<Result> value) {
    _events = value;
    notifyListeners();
  }

  fetchEventsListApi(_refresh) async {
    if (_refresh == true) {
      _events.clear();
      _page = 1;
      _apiLoading = true;
      await EventsRepository().fetchEventsList(_page).then((response) {
        _page = _page + 1;
        var data = EventsModel.fromJson(response);
        _events.clear();
        _events = data.results;
      });
      _apiLoading = false;
      notifyListeners();
    } else if (_refresh == false) {
      _apiLoading = true;
      await EventsRepository().fetchEventsList(_page).then((response) {
        _page = _page + 1;
        var data = EventsModel.fromJson(response);
        addEventsToList(data.results);
      });
      _apiLoading = false;
      notifyListeners();
    }
  }

  void addEventsToList(List<Result> eventData) {
    _events.addAll(eventData);
    _apiLoading = false;
    notifyListeners();
  }
}
