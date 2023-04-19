import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../repository/client_goal_strategy_repository.dart';
import '../utils/utils.dart';

class ClientGoalStrategyViewModel with ChangeNotifier {
  final _myRepo = ClientGoalStrategyRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> clientGoalStrategy(BuildContext context, star) async {
    setLoading(true);
    _myRepo.clientGoalStrategy(star).then((value) {
      setLoading(false);
      Utils.toastMessage("Client goal strategy rated successfully.");
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
