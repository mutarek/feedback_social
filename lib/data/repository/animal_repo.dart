import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;

class AnimalRepo {
  final ApiClient apiClient;
  final AuthRepo authRepo;

  AnimalRepo({required this.apiClient, required this.authRepo});

  Future<Response> getAnimals(int page) async {
    return await apiClient.getData("${AppConstant.animalOwnerURI}${authRepo.getUserID()}/?page=$page");
  }

  Future<Response> addedAnimal(Map<String, String> body, List<http.MultipartFile> multipartData) async{
    return await apiClient.postMultipartData(AppConstant.animalUri, body, multipartData);
  }

  Future<Response> updateAnimal(Map<String, String> body, List<http.MultipartFile> multipartData, int id) async {
    return await apiClient.patchMultipartData("${AppConstant.animalUri}$id/", body, multipartData);
  }

  Future<Response> deleteAnimal(int id) async {
    return await apiClient.deleteData("${AppConstant.animalUri}$id/");
  }
  Future<Response> searchAnimal(String id) async {
    return await apiClient.getData("${AppConstant.animalUri}search/$id/");
  }
}
