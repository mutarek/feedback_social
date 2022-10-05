import 'package:als_frontend/old_code/const/url.dart';
import 'package:als_frontend/old_code/model/group%20page/group/all_group_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AllGroupsService {
  String? token;
  Future<List<AllGroupModel>?> getPages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse("$baseUrl/group/suggest/all/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var json = response.body;
      return allGroupModelFromJson(json);
    } else {
      return null;
    }
  }
}
