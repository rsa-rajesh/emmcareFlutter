import 'package:flutter/material.dart';
import '../model/client_profile_goal_model.dart';
import '../repository/client_profile_goal_repository.dart';

class ClientProfileGoalViewViewModel extends ChangeNotifier {
  int _page = 1;
  int get page => _page;
  set page(int value) {
    _page = value;
    notifyListeners();
  }

  List<Result> _goals = <Result>[];

  List<Result> get goals => _goals;

  set goals(List<Result> value) {
    _goals = value;
    notifyListeners();
  }

  fetchClientProfileGoalListApi(_refresh) async {
    if (_refresh == true) {
      _goals.clear();
      _page = 1;
      await ClientProfileGoalRepository()
          .fetchClientProfileGoalList(_page)
          .then((response) {
        _page = _page + 1;
        var data = ClientProfileGoalModel.fromJson(response);
        _goals.clear();
        _goals = data.results!;
      });
      notifyListeners();
    } else if (_refresh == false) {
      await ClientProfileGoalRepository()
          .fetchClientProfileGoalList(_page)
          .then((response) {
        _page = _page + 1;
        var data = ClientProfileGoalModel.fromJson(response);
        addGoalsToList(data.results!);
      });
      notifyListeners();
    }
  }

  void addGoalsToList(List<Result> goalData) {
    _goals.addAll(goalData);
    notifyListeners();
  }
}
