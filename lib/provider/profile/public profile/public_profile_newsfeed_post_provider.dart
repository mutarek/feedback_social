// import 'dart:io';
// import 'package:als_frontend/model/post/author_post_model.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import '../../../const/url.dart';

// class OtherProfileNewsFeedPostProvider extends ChangeNotifier {
//   List<AuthorPostModel>? posts = [];
//   var isLoaded = false;
//   int index = 0;
//   int singleImageIndex = 0;
//   String postCaption = "";
//   List<String> postImages = [];
//   bool connection = false;
//   int? id;
//   String? token;

//   void checkConnection() async {
//     try {
//       final result = await InternetAddress.lookup('www.google.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         connection = true;
//         notifyListeners();
//       }
//     } on SocketException catch (_) {
//       connection = false;
//       notifyListeners();
//     }
//   }

//   Future<List<AuthorPostModel>?> getPosts() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     token = (prefs.getString('token') ?? '');
//     var uri = Uri.parse("$baseUrl/posts/author/$id/all/"),
//         headers = {'Authorization': 'token $token'};
//     var response = await http.get(uri, headers: headers);

//     if (response.statusCode == 200) {
//       var json = response.body;
//       return authorPostModelFromJson(json);
//     }
//     return null;
//   }

//   Future<void> getData() async {

//     posts = (await getPosts())!;
//     notifyListeners();
//     if (posts != null) {
//       isLoaded = true;
//       notifyListeners();
//     }
//   }

//   Future<void> refresh() async {
//     getData();
//   }
// }
