import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/accepted_order_response.dart';

class ApiClient extends GetConnect {
  static final ApiClient _apiClient = ApiClient._internal();

  factory ApiClient() {
    return _apiClient;
  }

  ApiClient._internal();

  static const baseAppUrl2 =
      'https://developmentalphawizz.com/pickport/api/Authentication/';
  static const baseAppUrl = 'https://developmentalphawizz.com/pickport/api/';

  @override
  void onInit() {
    baseUrl = baseAppUrl;
    /*httpClient.addAuthenticator<void>((request) async {
      final token = SharedPre.getStringValue(SharedPre.authToken);
      request.headers['Authorization'] =  'Bearer $token';
      return request;
    });*/

    ///Authenticator will be called 3 times if HttpStatus is
    ///HttpStatus.unauthorized
    //httpClient.maxAuthRetries = 3;
  }

  Future<String> getMethod({
    required String method,
    Map<String, String>? header,
  }) async {
    try {
      log('$baseAppUrl$method');
      if (header != null) {
        log(header.toString());
      }
      final response = await http.get(
        Uri.parse('$baseAppUrl$method'),
        headers: header,
      );
      log(response.body);
      final json = jsonDecode(response.body);
      return response.body;
    } catch (e) {
      log('______ getMethode error ${e.toString()}');
      return '';
    }
  }

  Future<String> postMethod({
    required method,
    required var body,
    Map<String, String>? header,
  }) async {
    try {
      log('$baseAppUrl$method');
      if (header != null) {
        log(header.toString());
      }
      log(body.toString());
      final response = await http.post(
        Uri.parse('$baseAppUrl$method'),
        body: body,
        headers: header,
      );
      final json = jsonDecode(response.body);
      log(response.body);
     // return json;
      return response.body;
    } catch (e) {
      log('______ post Method error ${e.toString()}');
      return '';
    }
  }



  Future<String> postMethodJson({
    required method,
    required var body,
    Map<String, String>? header,
  }) async {
    try {
      log('$baseAppUrl$method');
      if (header != null) {
        log(header.toString());
      }
      log(body.toString());
      //final response = await post(url, body, headers: header);
      final response = await http.post(
        Uri.parse('$baseAppUrl$method'),
        body: body,
        headers: header,
      );
      final json = jsonDecode(response.body);
      log(response.body);

      return response.body;
    } catch (e) {
      log('______ post Method error ${e.toString()}');
      return '';
    }
  }

  Future<String> postWithMultiPart({
    required method,
    required FormData formData,
    Map<String, String>? headers,
  }) async {
    try {
      String url = '$baseAppUrl$method';
      log(url);
      log(formData.files.toString());
      log(formData.fields.toString());
      if (headers?.isNotEmpty ?? false) {
        log(headers.toString());
      }
      final response = await post(
        url,
        formData,
        headers: headers,
      );
      log(response.bodyString.toString());
      if (response.body['code'].toString() == '401') {
        //token expired
        Get.offAndToNamed(
          'AppRoutes.login',
          arguments: 'Session expired!!!\nPlease login again.',
        );
        return '';
      } else {
        return response.bodyString ?? '';
      }
    } catch (e) {
      log(e.toString());
      return '';
    }
  }

  Future<String> postMethodMultipart(http.MultipartRequest request) async {
    log(request.fields.toString());
    if (request.files.isNotEmpty) {
      for (var element in request.files) {
        log('___ file ${element.field.toString()} length = ${element.length}');
      }
    } else {
      log('___ file empty');
    }
    http.Response response =
        await http.Response.fromStream(await request.send());
    log(response.body.toString());
    final data = jsonDecode(response.body);
    if (data['code'].toString() == '401') {
      //token expired
      Get.offAndToNamed(
        'AppRoutes.login',
        arguments: 'Session expired!!!\nPlease login again.',
      );
      return '';
    } else {
      return response.body;
    }
  }
}
