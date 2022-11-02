// import 'package:als_frontend/const/url.dart';
// import 'package:als_frontend/model/post/author_post_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:http/http.dart' as http;

// class ProfileNewsFeedPostService {
//   String? token;
//   int? id;
//   Future<List<AuthorPostModel>?> getPosts() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     token = (prefs.getString('token') ?? '');
//     id = (prefs.getInt('id') ?? '') as int;
//     var uri = Uri.parse("$baseUrl/posts/author/$id/all/"),
//         headers = {'Authorization': 'token $token'};
//     var response = await http.get(uri, headers: headers);

//     if (response.statusCode == 200) {
//       var json = response.body;
//       return authorPostModelFromJson(json);
//     }
//     return null;
//   }
// }
