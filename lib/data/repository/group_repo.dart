import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as Http;

class GroupRepo {
  final ApiClient apiClient;
  final AuthRepo authRepo;

  GroupRepo({required this.apiClient, required this.authRepo});

  Future<Response> getAllSuggestGroup() async {
    return await apiClient.getData(AppConstant.groupSuggestAllURI);
  }

  Future<Response> getAllJoinGroup() async {
    return await apiClient.getData(AppConstant.groupJoinAllURI);
  }

  Future<Response> getOwnGroupList() async {
    return await apiClient.getData(AppConstant.groupCreatorAllURI + "${authRepo.getUserID()}/all");
  }

  Future<Response> createGroupWithoutImageUpload(Map map) async {
    return await apiClient.postData(AppConstant.groupUri, map);
  }

  Future<Response> createGroupWithImageUpload(Map<String, String> body, List<Http.MultipartFile> multipartData) async {
    return await apiClient.postMultipartData(AppConstant.groupUri, body, multipartData);
  }

  Future<Response> updateGroupWithoutImageUpload(Map map,int groupID) async {
    return await apiClient.patchData(AppConstant.groupUri+"$groupID/", map);
  }

  Future<Response> updateGroupWithImageUpload(Map<String, String> body, List<Http.MultipartFile> multipartData,int groupID) async {
    return await apiClient.patchMultipartData(AppConstant.groupUri+"$groupID/", body, multipartData);
  }

  Future<Response> callForGetGroupDetails(String groupID) async {
    return await apiClient.getData(AppConstant.groupUri + "$groupID/");
  }

  Future<Response> callForGetGroupMembers(String groupID) async {
    return await apiClient.getData(AppConstant.groupUri + "$groupID/member/all/");
  }

  Future<Response> callForGetGroupAllPosts(String groupID,int page) async {
    return await apiClient.getData("/posts/group/$groupID/?page=$page");
  }

  Future<Response> callForGetGroupAllImages(String groupID) async {
    return await apiClient.getData("/group/$groupID/image/list/");
  }

  Future<Response> callForGetGroupAllVideo(String groupID) async {
    return await apiClient.getData("/group/$groupID/video/list/");
  }

  Future<Response> callForGetAllGroupMemberWhoNotMember(String groupID) async {
    return await apiClient.getData("/group/$groupID/friend/list/");
  }

  Future<Response> memberJoin(String groupID) async {
    return await apiClient.postData("/group/$groupID/member/join/", {});
  }

  Future<Response> leaveGroup(String groupID) async {
    return await apiClient.deleteData("/group/$groupID/member/leave/");
  }

  Future<Response> sendInvitation(String groupID, int userID) async {
    return await apiClient.postData("/group/$groupID/$userID/invitation-send/", {});
  }

  Future<Response> getCategory() async {
    return await apiClient.getData(AppConstant.groupCategoryUri);
  }
}
