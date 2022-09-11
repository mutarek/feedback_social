import 'package:flutter/cupertino.dart';

class ShowPasswordProvider extends ChangeNotifier{
  bool obsecureText = true;
  
  showPassword(){
    obsecureText = !obsecureText;
    notifyListeners();
  }
}