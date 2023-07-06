import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/res/app_url.dart';

class ForgotPasswordRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> forgotPasswordApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
        AppUrl.postPasswordResetOtp(),
        data,
      );
      return response;
    } catch (e) {
      throw e;
    }
  }
}
