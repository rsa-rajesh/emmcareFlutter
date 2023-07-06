import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/res/app_url.dart';

class OtpRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> otpApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
        AppUrl.postPasswordResetOtpVerify(),
        // jsonEncode(data),
        data,
      );
      return response;
    } catch (e) {
      throw e;
    }
  }
}
