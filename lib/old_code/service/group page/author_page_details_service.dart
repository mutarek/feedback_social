import 'package:als_frontend/old_code/const/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/response/page/author_page_details_model.dart';
import 'package:http/http.dart' as http;

class AuthorPageDetailsService {
  AuthorPageDetailsService({required this.pageIndex});
  String? token;
  var id;
  int pageIndex = 0;
  Future<AuthorPageDetailsModel?> getPages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');

    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    id = (prefs2.getInt('id') ?? '');

    var uri = Uri.parse("$baseUrl/page/$pageIndex/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    print("page details: ${response.statusCode}");

    if (response.statusCode == 200) {
      var json = response.body;
      return authorPageDetailsModelFromJson(json);
    } else {
      return null;
    }
  }
}
