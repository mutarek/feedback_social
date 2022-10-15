import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as Http;

class ProfileRepo {
  final ApiClient apiClient;

  ProfileRepo({required this.apiClient});

  Future<Response> getUserNewsfeedDataByUsingID(String userID, int page) async {
    return await apiClient.getData('/posts/$userID/list?page=$page');
  }

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstant.profileURI);
  }

  Future<Response> uploadPhoto(List<Http.MultipartFile> multipartData, {bool isCover = false}) async {
    return await apiClient.putMultipartData(
        isCover ? AppConstant.uploadCoverImageURI : AppConstant.uploadProfileImageURI, {}, multipartData);
  }

  Future<Response> getPublicProfileInfo(String id) async {
    return await apiClient.getData('${AppConstant.profileURI}$id/');
  }
}
