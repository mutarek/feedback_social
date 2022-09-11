import 'package:als_frontend/const/url.dart';

import 'package:als_frontend/model/settings/notidication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GetNotificationService {
  String? token;
  Future<SettingsNotificationModel?> getnotificationValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse("$baseUrl/accounts/settings/notification/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var json = response.body;

      return notificationValueFromJson(json);
    }
    return null;
  }
}
