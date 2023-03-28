abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getGetResponseWithAuth(String url, String token);
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> getPostResponseWithAuth(String url, String token);
  Future<dynamic> getPostResponseWithAuthData(
      String url, dynamic data, String token);
}
