import 'package:als_frontend/data/model/response/profile-images_model.dart';
import 'package:als_frontend/old_code/const/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/model.dart';
import 'package:http/http.dart' as http;

class ProfileImagesService {
  String? token;
  int? id;
  int userId;
  ProfileImagesService({required this.userId});

  Future<List<ProfileImagesModel>?> getProfileImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    id = (prefs.getInt('id') ?? '') as int?;
    var uri = Uri.parse("$baseUrl/accounts/profile/$userId/image/list/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var json = response.body;
      return profileImagesModelFromJson(json);
    }
    return null;
  }
}
