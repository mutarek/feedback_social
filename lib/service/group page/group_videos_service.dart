import 'package:als_frontend/const/url.dart';
import 'package:als_frontend/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class GroupVideosService {
  String? token;
  int? id;
  int groupId;
  GroupVideosService({required this.groupId});

  Future<List<ProfileVideoModel>?> getGroupImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    id = (prefs.getInt('id') ?? '') as int?;
    var uri = Uri.parse("$baseUrl/group/$groupId/video/list/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var json = response.body;
      return profileVideoModelFromJson(json);
    }
    return null;
  }
}
