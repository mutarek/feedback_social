import 'dart:convert';

import 'package:als_frontend/data/model/response/base/error_response.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as Http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static const String noInternetMessage = 'Connection to API server failed due to internet connection';
  final int timeoutInSeconds = 30;

  String token = '';
  Map<String, String>? _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    if (sharedPreferences.containsKey(AppConstant.token)) {
      token = sharedPreferences.getString(AppConstant.token)!;
    } else {
      token = '';
    }
    debugPrint('Token: $token');

    updateHeader(token);
  }
  void updateHeader(String token) {
    _mainHeaders = {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'};
  }

  Future<Response> getData(String uri, {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      Http.Response _response = await Http.get(
        Uri.parse(appBaseUrl + uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      debugPrint('====> API Body: $body');
      Http.Response _response = await Http.post(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }
  Future<Response> patchData(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      debugPrint('====> API Body: $body');
      Http.Response _response = await Http.patch(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartData(String uri, Map<String, String> body, List<Http.MultipartFile> multipartBody,
      {Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      debugPrint('====> API Body: $body with ${multipartBody.length} files');
      Http.MultipartRequest _request = Http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
      _request.headers.addAll(headers ?? _mainHeaders!);
      if(multipartBody.isNotEmpty){
        _request.files.addAll(multipartBody);
      }
      _request.fields.addAll(body);
      Http.Response _response = await Http.Response.fromStream(await _request.send());
      return handleResponse(_response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }
  Future<Response> patchMultipartData(String uri, Map<String, String> body, List<Http.MultipartFile> multipartBody,
      {Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      debugPrint('====> API Body: $body with ${multipartBody.length} files');
      Http.MultipartRequest _request = Http.MultipartRequest('PATCH', Uri.parse(appBaseUrl + uri));
      _request.headers.addAll(headers ?? _mainHeaders!);
      if(multipartBody.isNotEmpty){
        _request.files.addAll(multipartBody);
      }
      _request.fields.addAll(body);
      Http.Response _response = await Http.Response.fromStream(await _request.send());
      return handleResponse(_response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putMultipartData(String uri, Map<String, String> body, List<Http.MultipartFile> multipartBody,
      {Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      debugPrint('====> API Body: $body with ${multipartBody.length} files');
      Http.MultipartRequest _request = Http.MultipartRequest('PUT', Uri.parse(appBaseUrl + uri));
      _request.headers.addAll(headers ?? _mainHeaders!);
      if(multipartBody.isNotEmpty){
        _request.files.addAll(multipartBody);
      }
      _request.fields.addAll(body);
      Http.Response _response = await Http.Response.fromStream(await _request.send());
      return handleResponse(_response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      debugPrint('====> API Body: $body');
      Http.Response _response = await Http.put(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri, {Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      Http.Response _response = await Http.delete(
        Uri.parse(appBaseUrl + uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(Http.Response response, String uri) {
    dynamic _body;
    try {
      _body = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      debugPrint(e.toString());
    }

    Response _response = Response(
      body: _body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(headers: response.request!.headers, method: response.request!.method, url: response.request!.url),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (_response.statusCode != 200 && _response.body != null && _response.body is! String) {
      if (_response.body.toString().startsWith('{errors')) {
        ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _errorResponse.error);
      } else if (_response.body.toString().startsWith('{otp_verified')) {
        _response =
            Response(statusCode: _response.statusCode, body: _response.body, statusText: 'OTP Verified Failed Please Insert correct OTP');
      } else if (_response.body.toString().startsWith('{message')) {
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _response.body['message']);
      } else if (_response.body.toString().startsWith('{detail')) {
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _response.body['detail']);
      }
    } else if (_response.statusCode != 200 && _response.body == null) {
      _response = const Response(statusCode: 0, statusText: noInternetMessage);
    }
    debugPrint('====> API Response: [${_response.statusCode}] $uri\n${_response.body}');
    return _response;
  }
}