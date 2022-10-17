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

  Future<Response> getOwnGroupList() async {
    return await apiClient.getData(AppConstant.groupCreatorAllURI + "${authRepo.getUserID()}/all");
  }

  Future<Response> createGroupWithoutImageUpload(Map map) async {
    return await apiClient.postData(AppConstant.groupUri, map);
  }

  Future<Response> createGroupWithImageUpload(Map<String, String> body, List<Http.MultipartFile> multipartData) async {
    return await apiClient.postMultipartData(AppConstant.groupUri, body, multipartData);
  }
}
