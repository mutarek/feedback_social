import 'package:als_frontend/old_code/const/url.dart';
import 'package:als_frontend/data/model/response/user_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class PublicProfileDetailsService {
  PublicProfileDetailsService({required this.profileId});
  String? token;
  var id;
  int profileId = 0;
  Future<UserProfileModel?> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');

    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    id = (prefs2.getInt('id') ?? '');

    var uri = Uri.parse("$baseUrl/accounts/profile/$profileId/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var json = response.body;
      return userProfileModelFromJson(json);
    } else {
      return null;
    }
  }
}
