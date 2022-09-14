import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ApiBaseHelper {
  _authFailure() async {
    print("Token is expired");
  }

  Future<dynamic> post(String url, Map reqBody) async {
    if (kDebugMode) {}
    var responseJson;

    try {
      final response = await http.post(
          Uri.parse(
              "http://205.134.254.135/~mobile/MtProject/public/api/product_list"),
          body: jsonEncode(reqBody),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            "token":
                "eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz"
          });
      responseJson = _returnResponse(response);
    } on SocketException {
      print("Network Exception");
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    if (kDebugMode) {}
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 401:
        _authFailure();
        return null;
      default:
        return null;
    }
  }
}
