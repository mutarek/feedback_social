import 'package:als_frontend/old_code/const/url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../model/settings/audience_tag_model.dart';

class AudienceTagService {
  String? token;
  Future<AudienceTagModel?> getaudienceTagValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse("$baseUrl/accounts/settings/audience-tagging/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var json = response.body;

      return audienceTagModelFromJson(json);
    }
    return null;
  }
}
