import 'package:als_frontend/old_code/const/url.dart';

import 'package:als_frontend/old_code/model/settings/security_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SecurityService {
  String? token;
  Future<SecurityModel?> getsecurityValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse("$baseUrl/accounts/settings/security/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var json = response.body;

      return securityModelFromJson(json);
    }
    return null;
  }
}
