import 'package:als_frontend/old_code/const/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/model.dart';
import 'package:http/http.dart' as http;

class GroupMembersService {
  GroupMembersService(this.id);
  int? id;
  String? token;
  Future<List<GroupMembersModel>?> getMembers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse("$baseUrl/group/$id/member/all/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    print("group members: ${response.statusCode}");
    if (response.statusCode == 200) {
      var json = response.body;
      return groupMembersModelFromJson(json);
    } else {
      return null;
    }
  }
}