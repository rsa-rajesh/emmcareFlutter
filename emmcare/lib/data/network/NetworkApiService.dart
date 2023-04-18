import 'dart:convert';
import 'dart:io';
import 'package:emmcare/data/app_exceptions.dart';
import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

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
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Connection': 'keep-alive',
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

  // Post Api response with  Authentication
  @override
  Future getPostResponseWithAuth(String url, String token) async {
    dynamic responseJson;
    try {
      Response response = await post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Connection': 'keep-alive',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      ).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }
  // Post Api response with  Authentication

  // Post Api response with  Authentication and Data
  @override
  Future getPostResponseWithAuthData(
      String url, dynamic data, String token) async {
    dynamic responseJson;
    try {
      Response response = await post(
        Uri.parse(url),
        body: data,
        headers: {
          'Accept': 'application/json',
          'content-type': 'application/json',
          'Connection': 'keep-alive',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      ).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }
  // Post Api response with  Authentication and Data

  // Post Api response with  Authentication and Multipart Data
  @override
  Future getPostResponseWithAuthMultipartDataWithImage(
      String url,
      String _attachment,
      String _category,
      String _msg,
      int obj_id,
      String token) async {
    dynamic responseJson;
    try {
      var uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri);
      request.headers.addAll({"Authorization": "Bearer $token"});
      request.fields['msg'] = '$_msg';
      request.fields['obj_id'] = '$obj_id';
      request.fields['category'] = '$_category';
      request.files.add(await http.MultipartFile.fromPath(
        'attachment',
        _attachment,
        contentType: MediaType("Content-Type", "multipart/form-data"),
      ));
      var response = await request.send().timeout(Duration(seconds: 10));
      var responsed = await http.Response.fromStream(response);
      responseJson = returnResponse(responsed);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }
  // Post Api response with  Authentication and Multipart Data

  // Post Api response with  Authentication and Multipart Data Without Image.
  @override
  Future getPostResponseWithAuthMultipartDataWithoutImage(String url,
      String _category, String _msg, int obj_id, String token) async {
    dynamic responseJson;
    try {
      var uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri);
      request.headers.addAll({"Authorization": "Bearer $token"});
      request.fields['msg'] = '$_msg';
      request.fields['obj_id'] = '$obj_id';
      request.fields['category'] = '$_category';
      var response = await request.send().timeout(Duration(seconds: 10));
      var responsed = await http.Response.fromStream(response);
      responseJson = returnResponse(responsed);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }
  // Post Api response with  Authentication and Multipart Data Without Image.

  // Put Api response with  Authentication and Data
  @override
  Future getPutResponseWithAuthData(
      String url, dynamic data, String token) async {
    dynamic responseJson;
    try {
      Response response = await put(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {
          'Accept': 'application/json',
          'content-type': 'application/json',
          'Connection': 'keep-alive',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      ).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }
  // Put Api response with  Authentication and Data

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorizedException(response.body.toString());

      case 500:
        throw InernalServerException("");

      default:
        throw FetchDataException(
            "Error occurred while communicating with server" +
                "with status code" +
                response.statusCode.toString());
    }
  }
}
