
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../const/url.dart';
import '../../../model/model.dart';
import '../../../service/services.dart';

class AllPageProvider extends ChangeNotifier {
  List<AllPagesModel>? pages = [];
  var isLoaded = false;
  int pageIndex = 0;
  int singleImageIndex = 0;
  String postCaption = "";
  List<String> postImages = [];
  int? pageId;

  Future<void> getData() async {
    pages = (await AllPagesService().getPages());
    notifyListeners();
    if (pages != null) {
      isLoaded = true;
      notifyListeners();
    }
  }

  Future like() async {
    var apiUrl = "$baseUrl/page/$pageId/like/";

    Map mappeddata = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('token') ?? '');
    var uri = Uri.parse(apiUrl), headers = {'Authorization': 'token $token'};

        await http.post(uri, body: mappeddata, headers: headers);

    
  }
}
