import 'package:als_frontend/data/datasource/api_client.dart';
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

  /*........................edit profile repo..............*/


  Future<Response> updateProfileDetails(String firstName, lastName, company, education, gender,
      religion, liveInAdress, fromAdress) async {
    return await apiClient.putData(AppConstant.editProfile,
        {
          'first_name': firstName,
          'last_name': lastName,
          'gender': gender,
          'lives_in_address': liveInAdress,
          'from_address': fromAdress,
          'religion': religion,
          'company': company,
          'education': education,},);

  }

}
