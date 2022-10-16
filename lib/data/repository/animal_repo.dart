import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as Http;

class AnimalRepo {
  final ApiClient apiClient;
  final AuthRepo authRepo;

  AnimalRepo({required this.apiClient, required this.authRepo});

  Future<Response> getAnimals(int page) async {
    return await apiClient.getData(AppConstant.animalOwnerURI + "${authRepo.getUserID()}/?page=$page");
  }

  Future<Response> addedAnimal(Map<String, String> body, List<Http.MultipartFile> multipartData) async {
    return await apiClient.postMultipartData(AppConstant.animalUri, body, multipartData);
  }
}
