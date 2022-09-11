import 'package:als_frontend/const/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/model.dart';
import 'package:http/http.dart' as http;

class PrivacyPolicyService {
  String? token;
  int? id;
  Future<List<PrivacyPolicyModel>?> getPrivacyPolicy() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    id = (prefs.getInt('id') ?? '') as int?;
    var uri = Uri.parse("$baseUrl/privacy-policy/list/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var json = response.body;
      return privacyPolicyModelFromJson(json);
    }
    return null;
  }
}
