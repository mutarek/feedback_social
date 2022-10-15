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
// Future<ApiResponse> getCustomerAddress() async {
//   Response response = Response(requestOptions: RequestOptions(path: '22222'));
//   try {
//     response = await Dio().get(
//         '${AppConstant.baseUrl}customer/${authRepo.getCustomerID()}/address'
//         ,options: Options(
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer ${authRepo.getUserToken()}'
//       }
//     ));
//     return ApiResponse.withSuccess(response);
//   } catch (e) {
//
//     return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
//   }
// }
//
// Future<ApiResponse> getCountries() async {
//   Response response = Response(requestOptions: RequestOptions(path: '22222'));
//   try {
//     response = await dioClient.get('/countries');
//     return ApiResponse.withSuccess(response);
//   } catch (e) {
//     return ApiResponse.withError(ApiErrorHandler.getMessage(e),);
//   }
// }
//
// Future<ApiResponse> getAddress(double lat,double long) async {
//   Response response = Response(requestOptions: RequestOptions(path: '22222'));
//   try {
//     response = await Dio().get(
//         '${AppConstant.baseUrl}customer/address?longitude=$long&latitude=$lat',options: Options(
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': 'Bearer ${authRepo.getUserToken()}'
//         }
//     ));
//     return ApiResponse.withSuccess(response);
//   } catch (e) {
//     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
//   }
// }
//
// Future<ApiResponse> getCitiesBySynonyms(String city) async {
//   Response response = Response(requestOptions: RequestOptions(path: '22222'));
//   try {
//     response = await Dio().get('${AppConstant.baseUrl}cities/synonyms/$city',options: Options(
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer ${authRepo.getUserToken()}'
//       }
//     ));
//     return ApiResponse.withSuccess(response);
//   } catch (e) {
//     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
//   }
// }
// Future<ApiResponse> getCitiesByCountryID(int countryID) async {
//   Response response = Response(requestOptions: RequestOptions(path: '22222'));
//   try {
//     response = await dioClient.get('/cities/country/$countryID');
//     return ApiResponse.withSuccess(response);
//   } catch (e) {
//     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
//   }
// }
// //
// // Future<ApiResponse> addAddress(Map addressData) async {
// //   Response response = Response(requestOptions: RequestOptions(path: '22222'));
// //   try {
// //     response = await dioClient.post('/customer/${authRepo.getCustomerID()}/address', data: addressData);
// //     return ApiResponse.withSuccess(response);
// //   } catch (e) {
// //     return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
// //   }
// // }
// //
// // Future<ApiResponse> editAddress(Map addressData) async {
// //   Response response = Response(requestOptions: RequestOptions(path: '22222'));
// //   try {
// //     response =
// //         await dioClient.put('/customer/${authRepo.getCustomerID()}/address/${addressData['id']}', data: addressData);
// //
// //     return ApiResponse.withSuccess(response);
// //   } catch (e) {
// //
// //     return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
// //   }
// // }
// //
// // Future<ApiResponse> deleteAddress(String addressID) async {
// //   Response response = Response(requestOptions: RequestOptions(path: '22222'));
// //   try {
// //     response = await dioClient.delete('/customer/${authRepo.getCustomerID()}/address/$addressID');
// //     return ApiResponse.withSuccess(response);
// //   } catch (e) {
// //     return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
// //   }
// // }
// //
// // Future<ApiResponse> getCustomerProfile() async {
// //   Response response = Response(requestOptions: RequestOptions(path: '22222'));
// //   try {
// //     response = await dioClient.get('/customer/${authRepo.getCustomerID()}');
// //     return ApiResponse.withSuccess(response);
// //   } catch (e) {
// //     return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
// //   }
// // }
//
// Future<ApiResponse> uploadPhoto(File file) async {
//   Response response = Response(requestOptions: RequestOptions(path: '22222'));
//   try {
//     String fileName = file.path.split('/').last;
//     final data = FormData.fromMap({
//       "files": await MultipartFile.fromFile(file.path, filename: fileName, contentType:  MediaType("image", "png")),
//       "title": fileName,
//       "description": fileName,
//       "isPublic": true
//     });
//
//     response = await dioClient.post(AppConstant.photoUploadURI, data: data);
//     return ApiResponse.withSuccess(response);
//   } catch (e) {
//     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
//   }
// }
//
// Future<ApiResponse> updateProfile(Map map) async {
//   Response response = Response(requestOptions: RequestOptions(path: '22222'));
//   try {
//     response = await dioClient.put('/customer', data: map);
//     return ApiResponse.withSuccess(response);
//   } catch (e) {
//     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
//   }
// }
//
// Future<ApiResponse> updatePassword(Map<String, dynamic> map) async {
//   Response response = Response(requestOptions: RequestOptions(path: '22222'));
//   try {
//     response = await dioClient.put('/user/change-password/${authRepo.getUserID()}', data: map);
//     return ApiResponse.withSuccess(response);
//   } catch (e) {
//     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
//   }
// }
}
