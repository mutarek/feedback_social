import 'package:als_frontend/data/datasource/remote/dio/dio_client.dart';
import 'package:als_frontend/data/datasource/remote/exception/api_error_handler.dart';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:dio/dio.dart';

class ProfileRepo {
  final DioClient dioClient;
  final AuthRepo authRepo;

  ProfileRepo({ required this.dioClient,required this.authRepo});

  Future<ApiResponse> getUserNewsfeedDataByUsingID(
      String userID, int page) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.get('/posts/user/$userID/?page=$page');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getUserInfo() async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.get(AppConstant.profileURI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> uploadPhoto(FormData formData,
      {bool isCover = false}) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.put(
          isCover
              ? AppConstant.uploadCoverImageURI
              : AppConstant.uploadProfileImageURI,
          data: formData);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getPublicProfileInfo(String id) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.get('${AppConstant.profileURI}$id/');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getPublicProfileImageList(String id) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response =
          await dioClient.get('${AppConstant.profileURI}$id/image/list/');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getPublicProfileVideoList(String id) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response =
          await dioClient.get('${AppConstant.profileURI}$id/video/list/');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  /*........................edit profile repo..............*/

  Future<ApiResponse> updateProfileDetails(String firstName, lastName, company,
      education, gender, religion, liveInAddress, fromAddress) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.put(AppConstant.editProfile, data: {
        'first_name': firstName,
        'last_name': lastName,
        'gender': gender,
        'lives_in_address': liveInAddress,
        'from_address': fromAddress,
        'religion': religion,
        'company': company,
        'education': education
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  /*                Friend Request    */
  Future<ApiResponse> sendFriendRequest(String id) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response =
      await dioClient.post('${AppConstant.sendFriendRequestURI}$id/',data: {});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> acceptFriendRequest(String id) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response =
      await dioClient.post('${AppConstant.acceptFriendRequestURI}$id/',data: {});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> cancelFriendRequest(String id) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response =
      await dioClient.delete('${AppConstant.cancelFriendRequestURI}$id/');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> unfriend(String id) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response =
      await dioClient.post('${AppConstant.unfriendURI}$id/',data: {});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> sendFriendRequestLists(int page) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response =
      await dioClient.get('${AppConstant.sendFriendRequestListURI}$page');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> sendSuggestFriendRequestLists(int page) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response =
      await dioClient.get('${AppConstant.sendSuggestFriendListURI}$page');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getAllFriends(int page) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response =
      await dioClient.get('${AppConstant.friendListsURI}$page');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getAllFollowers(int page) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response =
      await dioClient.get('${AppConstant.follwersListsURI}$page');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> blockUser(int id) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response =
      await dioClient.post('/settings/block/$id/create/',data: {});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
}
