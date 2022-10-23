import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as Http;

class PageRepo {
  final ApiClient apiClient;
  final AuthRepo authRepo;

  PageRepo({required this.apiClient, required this.authRepo});

  Future<Response> getAuthorPage() async {
    return await apiClient.getData(AppConstant.pageAuthorURI);
  }

  Future<Response> getAllSuggestedPage() async {
    return await apiClient.getData(AppConstant.pageSuggestedURI);
  }

  Future<Response> getCategory() async {
    return await apiClient.getData(AppConstant.pageCategoryURI);
  }

  Future<Response> createPageWithoutImageUpload(Map map) async {
    return await apiClient.postData(AppConstant.pageURI, map);
  }

  Future<Response> createPageWithImageUpload(Map<String, String> body, List<Http.MultipartFile> multipartData) async {
    return await apiClient.postMultipartData(AppConstant.pageURI, body, multipartData);
  }

  Future<Response> callForGetPageAllPosts(String pageID) async {
    return await apiClient.getData("/posts/page/$pageID/");
  }

  Future<Response> callForGetPageAllImages(String pageId) async {
    return await apiClient.getData("/page/$pageId/image/list/");
  }

  Future<Response> callForGetPageAllVideo(String pageID) async {
    return await apiClient.getData("/page/$pageID/video/list/");
  }

  Future<Response> callForGetPageDetails(String pageID) async {
    return await apiClient.getData(AppConstant.pageURI + "$pageID/");
  }

  //////**************************************

  Future<Response> getOwnGroupList() async {
    return await apiClient.getData(AppConstant.groupCreatorAllURI + "${authRepo.getUserID()}/all");
  }

  Future<Response> updateGroupWithoutImageUpload(Map map, int groupID) async {
    return await apiClient.patchData(AppConstant.groupUri + "$groupID/", map);
  }

  Future<Response> updateGroupWithImageUpload(Map<String, String> body, List<Http.MultipartFile> multipartData, int groupID) async {
    return await apiClient.patchMultipartData(AppConstant.groupUri + "$groupID/", body, multipartData);
  }

  Future<Response> callForGetGroupMembers(String groupID) async {
    return await apiClient.getData(AppConstant.groupUri + "$groupID/member/all/");
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
}
