import 'package:emmcare/model/user_model.dart';
import 'package:emmcare/repository/auth_repository.dart';
import 'package:emmcare/utils/routes/routes_name.dart';
import 'package:emmcare/utils/utils.dart';
import 'package:emmcare/view_model/user_view_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class AuthViewViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo.loginApi(data).then((value) {
      setLoading(false);

      //
      // Finally shared preference fixed.
      final userPreference =
          Provider.of<UserViewViewModel>(context, listen: false);
      userPreference.saveUser(UserModel(
        token: value["token"].toString(),
      ));
      //
      //

      Utils.flushBarErrorMessage('Login Successfully', context);
      Navigator.pushReplacementNamed(context, RoutesName.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}