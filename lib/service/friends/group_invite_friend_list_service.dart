import 'package:als_frontend/const/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/model.dart';
import 'package:http/http.dart' as http;

class GroupInviteFriendListService {
  String? token;
  int groupId = 0;
  GroupInviteFriendListService({required this.groupId});
  Future<List<FriendListModel>?> getFriendsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse("$baseUrl/group/$groupId/friend/list/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var json = response.body;

      return friendListModelFromJson(json);
    }
    return null;
  }
}
