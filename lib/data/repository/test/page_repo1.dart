import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/data/datasource/remote/dio/dio_client.dart';
import 'package:als_frontend/data/datasource/remote/exception/api_error_handler.dart';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:dio/dio.dart';

class PageRepo {
  final DioClient dioClient;
  final AuthRepo authRepo;

  PageRepo({required this.dioClient, required this.authRepo});

  Future<ApiResponse> getAuthorPage() async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response = await dioClient.get(AppConstant.pageAuthorURI);
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getAllSuggestedPage() async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response = await dioClient.get(AppConstant.pageSuggestedURI);
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
  Future<ApiResponse> getAllLikedPageLists() async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response = await dioClient.get(AppConstant.pageLikeAllURI);
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getCategory() async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response = await dioClient.get(AppConstant.pageCategoryURI);
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> createPageWithoutImageUpload(Map map) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response = await dioClient.post(AppConstant.pageURI,data: map);
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
  //
  // Future<Response> createPageWithImageUpload(Map<String, String> body, List<http.MultipartFile> multipartData) async {
  //   return await apiClient.postMultipartData(AppConstant.pageURI, body, multipartData);
  // }
  //
  // Future<Response> callForGetPageAllPosts(String pageID,int page) async {
  //   return await apiClient.getData("/posts/page/$pageID/?page=$page");
  // }
  //
  // Future<Response> callForGetPageAllImages(String pageId) async {
  //   return await apiClient.getData("/page/$pageId/image/list/");
  // }
  //
  // Future<Response> callForGetPageAllVideo(String pageID) async {
  //   return await apiClient.getData("/page/$pageID/video/list/");
  // }
  //
  // Future<Response> callForGetPageDetails(String pageID) async {
  //   return await apiClient.getData(AppConstant.pageURI + "$pageID/");
  // }
  //
  // Future<Response> updatePageWithoutImageUpload(Map map, int pageID) async {
  //   return await apiClient.patchData(AppConstant.pageURI + "$pageID/", map);
  // }
  //
  // Future<Response> updatePageWithImageUpload(Map<String, String> body, List<http.MultipartFile> multipartData, int pageID) async {
  //   return await apiClient.patchMultipartData(AppConstant.pageURI + "$pageID/", body, multipartData);
  // }
  //
  // Future<Response> pageLikeUnlike(String pageId) async {
  //   return await apiClient.postData("/page/$pageId/like/", {});
  // }
}
