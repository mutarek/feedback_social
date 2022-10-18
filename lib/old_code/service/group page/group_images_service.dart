import 'package:als_frontend/old_code/const/url.dart';
import 'package:als_frontend/data/model/response/group/group_images_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class GroupImagesService {
  String? token;
  int? id;
  int groupId;
  GroupImagesService({required this.groupId});

  Future<List<GroupImagesModel>?> getGroupImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    id = (prefs.getInt('id') ?? '') as int?;
    var uri = Uri.parse("$baseUrl/group/$groupId/image/list/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var json = response.body;
      return groupImagesModelFromJson(json);
    }
    return null;
  }
}
