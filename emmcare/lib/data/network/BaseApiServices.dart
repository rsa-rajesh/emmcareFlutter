abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> getGetResponseWithAuth(String url, String token);
  // Future<dynamic> getGetApiResponse(String url, headers: headers);
}
