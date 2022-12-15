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

  Future<ApiResponse> createPageWithImageUpload(FormData formData) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response = await dioClient.post(AppConstant.pageURI,data: formData);
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> callForGetPageAllPosts(String pageID,int page) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response = await dioClient.get("/posts/page/$pageID/?page=$page");
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> callForGetPageAllImages(String pageId) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response = await dioClient.get("/page/$pageId/image/list/");
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> callForGetPageAllVideo(String pageID) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response = await dioClient.get("/page/$pageID/video/list/");
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> callForGetPageDetails(String pageID) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response = await dioClient.get("${AppConstant.pageURI}$pageID/");
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> updatePageWithoutImageUpload(Map map, int pageID) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response = await dioClient.patch("${AppConstant.pageURI}$pageID/", data: map);
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> updatePageWithImageUpload(FormData formData, int pageID) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response = await dioClient.patch("${AppConstant.pageURI}$pageID/", data: formData);
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> pageLikeUnlike(String pageId) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response = await dioClient.post("/page/$pageId/like/",data: {});
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
}
