import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/res/app_url.dart';

import '../model/events_model.dart';

class EventsRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  Future<EventsModel> fetchEventsList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.eventsEndPoint);
      return response = EventsModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
