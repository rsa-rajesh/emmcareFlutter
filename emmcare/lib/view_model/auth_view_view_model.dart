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
        access: value["access"].toString(),
      ));
      //
      //

      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (r) => false);
      Utils.flushBarErrorMessage('You are logged in successfully.', context);

      print(value["profile_img"].toString());
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Navigator.pop(context);
      Utils.flushBarErrorMessage("Invalid Crendential, Try again.", context);

      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
