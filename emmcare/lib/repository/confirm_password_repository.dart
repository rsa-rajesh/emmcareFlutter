import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/res/app_url.dart';

class ConfirmPasswordRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> confirmPasswordapi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
        AppUrl.postPasswordResetOtpComplete(),
        // jsonEncode(data),
        data,
      );
      return response;
    } catch (e) {
      throw e;
    }
  }
}
