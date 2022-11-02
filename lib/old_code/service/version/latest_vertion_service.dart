import 'package:als_frontend/old_code/const/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/model.dart';
import 'package:http/http.dart' as http;

class LatestVersionService {
  String token = "";

  Future<LatestVersionModel?> getVersion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse("$baseUrl/latest-version/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var json = response.body;
      return latestVersionModelFromJson(json);
    }
    return null;
  }
}
