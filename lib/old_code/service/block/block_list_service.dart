import 'package:als_frontend/old_code/const/url.dart';
import 'package:als_frontend/old_code/model/Block/blocklist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BlockListService {
  String? token;
  Future<List<BlocklistModel>?> getblocklistdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse("$baseUrl/accounts/settings/block/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var json = response.body;

      return blocklistModelFromJson(json);
    }
    return null;
  }
}
