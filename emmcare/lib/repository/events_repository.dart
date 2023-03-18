import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/res/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/events_model.dart';
import '../model/user_model.dart';
import '../view/home_view.dart';
import '../view_model/user_view_view_model.dart';

class EventsRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  Future<EventsModel> fetchEventsList() async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(seconds: 3));
    final sharedpref = await SharedPreferences.getInstance();
    int? Id = sharedpref.getInt(HomeViewState.KEYSHIFTID);
    try {
      dynamic response = await _apiServices.getGetResponseWithAuth(
          AppUrl.eventsEndPoint + "$Id", token);
      return response = EventsModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
