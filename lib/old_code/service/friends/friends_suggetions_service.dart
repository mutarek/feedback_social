import 'package:als_frontend/old_code/const/url.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/model.dart';
import 'package:http/http.dart' as http;

class FriendSuggetionsService {
  String? token;

  Future<List<FriendsSuggetionsModel>?> getFriendsSuggetions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse("$baseUrl/accounts/friends/suggestions/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var json = response.body;
      return friendsSuggetionsModelFromJson(json);
    } else {
      Fluttertoast.showToast(msg: "Something went wrong!");
      return null;
    }
  }
}
