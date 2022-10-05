import 'dart:io';

import 'package:als_frontend/data/datasource/remote/dio/dio_client.dart';
import 'package:als_frontend/data/datasource/remote/exception/api_error_handler.dart';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
class ProfileRepo {
  final DioClient dioClient;
  final AuthRepo authRepo;

  ProfileRepo({required this.dioClient, required this.authRepo});

  Future<ApiResponse> getCustomerAddress() async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await Dio().get(
          '${AppConstant.baseUrl}customer/${authRepo.getCustomerID()}/address'
          ,options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${authRepo.getUserToken()}'
        }
      ));
      return ApiResponse.withSuccess(response);
    } catch (e) {

      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getCountries() async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.get('/countries');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getAddress(double lat,double long) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await Dio().get(
          '${AppConstant.baseUrl}customer/address?longitude=$long&latitude=$lat',options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${authRepo.getUserToken()}'
          }
      ));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getCitiesBySynonyms(String city) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await Dio().get('${AppConstant.baseUrl}cities/synonyms/$city',options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${authRepo.getUserToken()}'
        }
      ));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
  Future<ApiResponse> getCitiesByCountryID(int countryID) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.get('/cities/country/$countryID');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> addAddress(Map addressData) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.post('/customer/${authRepo.getCustomerID()}/address', data: addressData);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> editAddress(Map addressData) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response =
          await dioClient.put('/customer/${authRepo.getCustomerID()}/address/${addressData['id']}', data: addressData);

      return ApiResponse.withSuccess(response);
    } catch (e) {

      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> deleteAddress(String addressID) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.delete('/customer/${authRepo.getCustomerID()}/address/$addressID');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getCustomerProfile() async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.get('/customer/${authRepo.getCustomerID()}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> uploadPhoto(File file) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      String fileName = file.path.split('/').last;
      final data = FormData.fromMap({
        "files": await MultipartFile.fromFile(file.path, filename: fileName, contentType:  MediaType("image", "png")),
        "title": fileName,
        "description": fileName,
        "isPublic": true
      });

      response = await dioClient.post(AppConstant.photoUploadURI, data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> updateProfile(Map map) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.put('/customer', data: map);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> updatePassword(Map<String, dynamic> map) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.put('/user/change-password/${authRepo.getUserID()}', data: map);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
}
