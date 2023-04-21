import 'package:flutter/material.dart';
import '../model/events_model.dart';
import '../repository/events_repository.dart';

class EventsViewViewModel extends ChangeNotifier {
  int _page = 1;
  int get page => _page;
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
      await EventsRepository().fetchEventsList(_page).then((response) {
        _page = _page + 1;
        var data = EventsModel.fromJson(response);
        _events.clear();
        _events = data.results;
      });
      notifyListeners();
    } else if (_refresh == false) {
      await EventsRepository().fetchEventsList(_page).then((response) {
        _page = _page + 1;
        var data = EventsModel.fromJson(response);
        addEventsToList(data.results);
      });
      notifyListeners();
    }
  }

  void addEventsToList(List<Result> eventData) {
    _events.addAll(eventData);
    notifyListeners();
  }
}
