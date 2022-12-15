import 'package:als_frontend/data/datasource/remote/dio/dio_client.dart';
import 'package:als_frontend/data/datasource/remote/exception/api_error_handler.dart';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

double progressPercent = 0;

class AnimalRepo {
  final DioClient dioClient;
  final AuthRepo authRepo1;
  final SharedPreferences sharedPreferences;

  AnimalRepo({required this.dioClient,
    required this.sharedPreferences,
    required this.authRepo1,
  });

  Future<ApiResponse> getAnimals(int page) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response =  await dioClient.get("${AppConstant.animalOwnerURI}${authRepo1.getUserID()}/?page=$page");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
  Future<ApiResponse> addedAnimal(FormData formData) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response =  await dioClient.post(AppConstant.animalUri,data: formData);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
  Future<ApiResponse> updateAnimal( FormData formData ,int id) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response =  await dioClient.patch("${AppConstant.animalUri}$id/", data: formData);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
  Future<ApiResponse> deleteAnimal(int id) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response =  await dioClient.delete("${AppConstant.animalUri}$id/");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
  Future<ApiResponse> searchAnimal(String id) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response =  await dioClient.get("${AppConstant.animalUri}search/$id/");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

}
