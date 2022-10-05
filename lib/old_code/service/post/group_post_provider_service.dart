import 'package:als_frontend/old_code/const/url.dart';
import 'package:als_frontend/old_code/model/post/group_post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class GroupPostService {
  String? token;
  int id;

  GroupPostService({required this.id});
  Future<List<GroupPostModel>?> getGroupPost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse("$baseUrl/posts/group/$id/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var json = response.body;

      return groupPostModelFromJson(json);
    }
    return null;
  }
}
