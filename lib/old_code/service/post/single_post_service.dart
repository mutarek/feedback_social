import 'package:als_frontend/old_code/const/url.dart';
import 'package:als_frontend/old_code/model/post/single_post_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SinglePostService {
  SinglePostService({required this.url});
  String? token;
  String url = "";
  Future<SinglePostModel?> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');

    var uri = Uri.parse("$baseUrl$url"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    
    if (response.statusCode == 200) {
      var json = response.body;
      return singlePostModelFromJson(json);
    } else {
      return null;
    }
  }
}
