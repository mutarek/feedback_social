import 'package:als_frontend/data/datasource/remote/dio/dio_client.dart';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:dio/dio.dart';

import '../datasource/remote/exception/api_error_handler.dart';

class SearchRepo{
  final DioClient dioClient;
  final AuthRepo authRepo;

  SearchRepo({required this.dioClient,required this.authRepo});

  Future<ApiResponse> searchData(String query) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response = await dioClient.get('/search/?q=$query');
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
}