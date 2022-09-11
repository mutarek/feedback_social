import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/screens.dart';

class DatabaseProvider extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  String _token = "";
  int? _id;
  String _firstName = "";
  String _lastName = "";
  String _profileImage = "";
  String _code = "";
  String? image;

  String get token => _token;
  int get id => _id!;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get code => _code;
  String get profileImage => _profileImage;

  void saveToken(String token) async {
    SharedPreferences value = await _pref;
    value.setString('token', token);
  }

  void saveUserID(int id) async {
    SharedPreferences value = await _pref;
    value.setInt('id', id);
  }

  void saveFirstName(String firstName) async {
    SharedPreferences value = await _pref;
    value.setString('firstName', firstName);
  }

  void saveLastName(String lastName) async {
    SharedPreferences value = await _pref;
    value.setString('lastName', lastName);
  }

  void saveCode(String code) async {
    SharedPreferences value = await _pref;
    value.setString('code', code);
  }

  void saveProfileImage(String profileImage) async {
    SharedPreferences value = await _pref;
    value.setString("profileImage", profileImage);
  }

  Future<String> getToken() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('token')) {
      String data = value.getString('token')!;
      _token = data;
      notifyListeners();
      return data;
    } else {
      _token = "";
      notifyListeners();
      return '';
    }
  }

  Future<int> getUserId() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('id')) {
      int data = value.getInt('id')!;
      _id = data;
      notifyListeners();
      return data;
    } else {
      _id = null;
      notifyListeners();
      return 0;
    }
  }

  Future<String> getFirstName() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('firstName')) {
      String data = value.getString('firstName')!;
      _firstName = data;
      notifyListeners();
      return data;
    } else {
      _firstName = "";
      notifyListeners();
      return '';
    }
  }

  Future<String> getLastName() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('lastName')) {
      String data = value.getString('lastName')!;
      _lastName = data;
      notifyListeners();
      return data;
    } else {
      _lastName = "";
      notifyListeners();
      return '';
    }
  }

  Future<String> getCode() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('code')) {
      String data = value.getString('code')!;
      _code = data;
      notifyListeners();
      return data;
    } else {
      _code = "";
      notifyListeners();
      return '';
    }
  }

  Future<String> getProfileImage() async {
    SharedPreferences value = await _pref;
    if (value.containsKey('profileImage')) {
      String data = value.getString('profileImage')!;
      _profileImage = data;
      return data;
    } else {
      _profileImage = "";
      notifyListeners();
      return '';
    }
  }

  void logout(BuildContext context) async {
    final value = await _pref;
    value.clear();
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false);
  }
}
