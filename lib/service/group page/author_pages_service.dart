import 'package:als_frontend/const/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/model.dart';
import 'package:http/http.dart' as http;

class AuthorPagesService {
  String? token;
  var id;
  int pageIndex = 0;
  Future<List<AuthorPageModel>?> getPages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');

    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    id = (prefs2.getInt('id') ?? '');

    var uri = Uri.parse("$baseUrl/page/author-page/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var json = response.body;
      return authorPageModelFromJson(json);
    } else {
      return null;
    }
  }
}
