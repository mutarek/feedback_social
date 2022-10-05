import 'dart:convert';

import 'package:als_frontend/old_code/const/url.dart';
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

    print(groupIndex);
    var uri = Uri.parse("$baseUrl/group/$groupIndex/"), headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var json = response.body;
      print('sssh ${json}');
      return AuthorGroupDetailsModel.fromJson(jsonDecode(json));
    } else {
      return null;
    }
  }
}
