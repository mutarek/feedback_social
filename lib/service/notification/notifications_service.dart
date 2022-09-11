// import 'package:als_frontend/const/url.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../model/model.dart';
// import 'package:http/http.dart' as http;

// class NotificationsService {
//   String? token;
//   Future<List<NotificationsModel>?> getNotifications() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     token = (prefs.getString('token') ?? '');
//     var uri = Uri.parse("$baseUrl/action/notifications/"),
//         headers = {'Authorization': 'token $token'};
//     var response = await http.get(uri, headers: headers);

//     if (response.statusCode == 200) {
//       var json = response.body;
//       return notificationsModelFromJson(json);
//     } else {
//       return null;
//     }
//   }
// }
