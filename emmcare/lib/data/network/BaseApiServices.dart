abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> getGetClintsResponse(String url);
  // Future<dynamic> getGetApiResponse(String url, headers: headers);
}
