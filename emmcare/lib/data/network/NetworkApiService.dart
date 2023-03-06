import 'dart:convert';
import 'dart:io';

import 'package:emmcare/data/app_exceptions.dart';
import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiServices {
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
  
  @override
  Future getGetClintsResponse(String url) async {
    dynamic responseJson;
    try {
      Response response = await get(
        Uri.parse(url),
        headers: {
      HttpHeaders.authorizationHeader: 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjg2NzIzOTk3LCJpYXQiOjE2NzgwODM5OTcsImp0aSI6IjhlNjBiZWM0OTY0NjQ1NmU4OTFhMDg2ZTVhMDE0OWQzIiwidXNlcl9pZCI6NjUsInVzZXJuYW1lIjoiRW1tY19BZG1pbkRSN1giLCJlbWFpbCI6Im5hYmFAZW1tYy5jb20uYXUiLCJyb2xlIjoib3duZXIiLCJwcm9maWxlX2lkIjo2NCwiaWQiOjY1LCJmY21fcmVnaXN0cmF0aW9uX2lkIjoiZFVmeEZJNVNSRk9xRURsVzdvZWh4QTpBUEE5MWJINlhhNzJubnJxZUpYVVo3OWpxZURyVXJTaWtCQUZ2WFJ2RnNMRTR4RDBfX25zbjJuTlRLamZ0QVpyTDFrUWhXTHh0S1BzTHVPT0lZeFMyNjJidlZRQ0RrM1hseENGZnlYNFVsMXY5ZlJCQ3gxSi1JSERscmV1REM3VmhjTkxQaVJDbWx4WCIsImVuZHNfaW4iOiIyMDI5LTAyLTA2In0.llAS_vSzmYDKWEoqd2uxsUJNUasx2pDpeiFKlu0SuGQ',
    },
      ).timeout(Duration(seconds: 20));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }
}
