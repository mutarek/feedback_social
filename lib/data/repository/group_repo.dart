import 'package:als_frontend/data/datasource/remote/exception/api_error_handler.dart';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:dio/dio.dart';

import '../datasource/remote/dio/dio_client.dart';

double progressPercent = 0;

class GroupRepo {
  final DioClient dioClient;
  final AuthRepo authRepo1;

  GroupRepo({required this.dioClient, required this.authRepo1});

  Response response = Response(requestOptions: RequestOptions(path: ''));

  Future<ApiResponse> getAllSuggestGroup() async {
    try {
      response = await dioClient.get(AppConstant.groupSuggestAllURI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getAllJoinGroup() async {
    try {
      response = await dioClient.get(AppConstant.groupJoinAllURI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getOwnGroupList() async {
    try {
      response = await dioClient.get("${AppConstant.groupCreatorAllURI}${authRepo1.getUserID()}/all");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> createGroupWithoutImageUpload(Map map) async {
    try {
      response = await dioClient.post(AppConstant.groupUri, data: map);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> createGroup(FormData formData) async {
    try {
      response = await dioClient.post(AppConstant.newGroupURI, data: formData);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getAllAuthorGroups(int page) async {
    try {
      response = await dioClient.get("${AppConstant.authorGroupURI}?page=$page");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  // TODO: get all joined group list
  Future<ApiResponse> getAllJoinedGroups(int page) async {
    try {
      response = await dioClient.get("${AppConstant.newJoinedGroup}?page=$page");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

// TODO: get all suggested group list
  Future<ApiResponse> getALLSuggestedGroups(int page) async {
    try {
      response = await dioClient.get("${AppConstant.suggestedGroup}?page=$page");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> createGroupWithImageUpload(FormData formData) async {
    try {
      response = await dioClient.post(AppConstant.groupUri, data: formData);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> updateGroupWithoutImageUpload(Map map, int groupID) async {
    try {
      response = await dioClient.patch("${AppConstant.groupUri}$groupID/", data: map);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> updateGroupWithImageUpload(FormData formData, int groupID) async {
    try {
      response = await dioClient.patch("${AppConstant.groupUri}$groupID/", data: formData);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> callForGetGroupDetails(String groupID) async {
    try {
      response = await dioClient.get("${AppConstant.groupUri}$groupID/up-del-retr/");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> callForGetGroupMembers(String groupID) async {
    try {
      response = await dioClient.get("${AppConstant.groupUri}$groupID/member/all/");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> leaveGroup(String groupID, int memberID) async {
    try {
      response = await dioClient.delete("/group/member/$groupID/$memberID/delete/");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> callForGetGroupAllPosts(String groupID, int page) async {
    try {
      response = await dioClient.get("/group/post/$groupID/create-list/?page=$page");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> callForGetGroupAllImages(String groupID) async {
    try {
      response = await dioClient.get("/group/$groupID/image/list/");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> callForGetGroupAllVideo(String groupID) async {
    try {
      response = await dioClient.get("/group/$groupID/video/list/");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> callForGetAllGroupMemberWhoNotMember(String groupID) async {
    try {
      response = await dioClient.get("/group/$groupID/friend/list/");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> memberJoin(String groupID) async {
    try {
      response = await dioClient.post("/group/member/join/$groupID/create/", data: {});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> sendInvitation(String groupID, int userID) async {
    try {
      response = await dioClient.post("/group/$groupID/$userID/invitation-send/", data: {});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getCategory() async {
    try {
      response = await dioClient.get(AppConstant.groupCategoryUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> findGroup(String findGroupName, int page) async {
    try {
      response = await dioClient.get("/group/search/?q=$findGroupName&page=$page");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getAuthorGroupById(String id) async {
    try {
      response = await dioClient.get("${AppConstant.groupUri}/$id/up-del-retr/");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> setupGroup(FormData formData, String groupId) async {
    try {
      response = await dioClient.patch("${AppConstant.groupUri}/$groupId/up-del-retr/", data: formData);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getGroupMembers(int page, String groupId) async {
    try {
      response = await dioClient.get("${AppConstant.groupUri}member/$groupId/list/?page=$page");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> callForGetAllPhotos(String url) async {
    try {
      response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> callForGetAllVideos(String url) async {
    try {
      response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> updateGroupCoverPhoto(FormData formData, String groupID) async {
    try {
      response = await dioClient.patch("${AppConstant.groupUri}$groupID/up-del-retr/", data: formData);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> pinGroupList(int page) async {
    try {
      response = await dioClient.get("${AppConstant.pinGroupUri}?page=$page");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> pinGroup(int groupID) async {
    try {
      response = await dioClient.post('/group/pin/$groupID/create/');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> deletePinGroup(int groupID) async {
    try {
      response = await dioClient.delete('/group/unpin/$groupID/');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getAllFriendsForInvite(String groupID, int page) async {
    try {
      response = await dioClient.get("${AppConstant.groupInvitationUri}friend/user/$groupID/list/");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> invitationCreate(int groupID, List<int> users) async {
    try {
      response = await dioClient.post("${AppConstant.groupInvitationUri}create/", data: {"group": groupID, "users": users});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getInvitedGroups(int page) async {
    try {
      response = await dioClient.get("${AppConstant.groupInvitationUri}list/?page=$page");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }


  Future<ApiResponse> groupBlockCreate(int pageID) async {
    Response response = Response(requestOptions: RequestOptions(path: ''));
    try {
      response = await dioClient.post("${AppConstant.groupBlockURI}$pageID/create/");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> groupUnBlockCreate(int groupID) async {
    Response response = Response(requestOptions: RequestOptions(path: ''));
    try {
      response = await dioClient.delete(AppConstant.groupUnBlockURI.replaceAll("{group_id}", "$groupID"));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> groupBlockLists(int page) async {
    Response response = Response(requestOptions: RequestOptions(path: ''));
    try {
      response = await dioClient.get("${AppConstant.groupBlockURI}list/?page=$page");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

}
