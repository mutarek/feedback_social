import 'package:als_frontend/const/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/group page/group/author_group_details_model.dart';
import 'package:http/http.dart' as http;

class GroupDetailsService {
  GroupDetailsService({required this.groupIndex});
  String? token;
  var id;
  int groupIndex = 0;
  Future<AuthorGroupDetailsModel?> getgroups() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');

    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    id = (prefs2.getInt('id') ?? '');

    var uri = Uri.parse("$baseUrl/group/$groupIndex/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var json = response.body;
      return authorGroupDetailsModelFromJson(json);
    } else {
      return null;
    }
  }
}
