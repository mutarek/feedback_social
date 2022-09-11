import 'package:als_frontend/const/url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/model.dart';
import 'package:http/http.dart' as http;

class AuthorGroupService {
  String? token;
  int? id;
  int pageIndex = 0;
  Future<List<AuthorGroupModel>?> getGroups() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');

    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    id = (prefs2.getInt('id') ?? '') as int?;

    var uri = Uri.parse("$baseUrl/group/creator/$id/all/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var json = response.body;

      return authorGroupModelFromJson(json);
    } else {
      return null;
    }
  }
}
