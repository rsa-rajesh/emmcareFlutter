import 'dart:convert';
import 'dart:io';

import 'package:emmcare/data/app_exceptions.dart';
import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiServices {
  // Get Api response
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }
  // Get Api response

  // Get Api response with  Authentication
  @override
  Future getGetResponseWithAuth(String url, String token) async {
    dynamic responseJson;
    try {
      Response response = await get(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      ).timeout(Duration(seconds: 20));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }
  // Get Api response with  Authentication

  // Post Api response
  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      Response response = await post(
        Uri.parse(url),
        body: data,
      ).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }
  // Post Api response

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorizedException(response.body.toString());

      default:
        throw FetchDataException(
            "Error occurred while communicating with server" +
                "with status code" +
                response.statusCode.toString());
    }
  }
}
