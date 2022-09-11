import 'package:als_frontend/const/url.dart';
import 'package:als_frontend/model/settings/drrect_massages_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../model/settings/audience_tag_model.dart';

class DrectMassagesService {
  String? token;
  Future<DrectMassagesModel?> getdrectmassageValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse("$baseUrl/accounts/settings/direct-message/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var json = response.body;

      return drectMassagesModelFromJson(json);
    }
    return null;
  }
}
