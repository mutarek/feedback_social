import 'package:als_frontend/old_code/const/url.dart';
import 'package:als_frontend/old_code/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PageImagesService {
  String? token;
  int? id;
  int pageId;
  PageImagesService({required this.pageId});

  Future<List<PageImagesModel>?> getPageImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    id = (prefs.getInt('id') ?? '') as int?;
    var uri = Uri.parse("$baseUrl/page/$pageId/image/list/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var json = response.body;
      return pageImagesModelFromJson(json);
    }
    return null;
  }
}
