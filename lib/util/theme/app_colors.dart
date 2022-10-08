import 'package:flutter/material.dart';

const Color colorPrimaryLight = Color(0xFF06113E);
const Color colorPrimaryDark = Color(0xFFF9C45A);

class AppColors {
  //TODO: for Light Theme color
  static const Color primaryColorLight = Color(0xFF06113E);
  static const Color hintTextColorLight = Color(0xff9E9E9E);
  static const Color imageBGColorLight = Color(0xffE2F0FF);
  static const Color whiteColorLight = Color(0xFFFFFFFF);
  static const Color unreadColorLight = Color(0xFF00ACFF);

  //TODO: for Dark Theme Color
  static const Color primaryColorDark = Color(0xFFF9C45A);
  static const Color hintTextColorDark = Color(0xff9E9E9E);
  static const Color imageBGColorDark = Color(0xffE2F0FF);
  static const Color whiteColorDark = Color(0xFFFFFFFF);
  static const Color unreadColorDark = Color(0xFF00ACFF);

  static const Color scaffold = Color(0xFFF0F2F5);
  static const LinearGradient createRoomGradient = LinearGradient(colors: [Color(0xFF496AE1), Color(0xFFCE48B1)]);
  static const Color textFont = Color(0xFF000000);
  static const Color timeColor = Color(0xFFFF8C31);

  static const Color HOME_BG = Color(0xffF0F0F0);
  static const Color redColor = Color(0xffFF0000);
  static const Color COLUMBIA_BLUE = Color(0xff92C6FF);
  static const Color accentColor = Color(0xFFE6A537);
  static const Color SELLER_TXT = Color(0xff92C6FF);
  static const Color black = Color(0xFF252525);
  static const Color ICON_BG = Color(0xffF9F9F9);
  static const Color grey = Color(0xFF909090);
  static const Color LOW_GREEN = Color(0xffEFF6FE);
  static const Color lightGrey = Color(0xFFDADADA);
  static const Color YELLOW = Color(0xFFFFAA47);

  static const Color bodyTextColorOverride = Color(0xFF020202);

  //
  // static Color barColor = HexColor('');
  // static Color fastButtonColor = HexColor('');
  // static Color bgndColor = HexColor('');
  // static Color searchBgndColor = HexColor('');
  // static Color searchButtonColor = HexColor('');
  // static Color searchIconColor = HexColor('');
  // static Color searchTextColor = HexColor('');
  // static Color qrbgndColor = HexColor('');
  // static Color qrIconColor = HexColor('');
  // static Color menuBarBgndColor = HexColor('');
  // static Color menuBarTextColor = HexColor('');
  // static Color menuIconColor = HexColor('');
  // static Color buttonColor = HexColor('');
  // static Color priceColor = HexColor('');
  // static Color iconColor = HexColor('');
  // static Color textColor = HexColor('');
  // static Color textLinkColor = HexColor('');
  // static Color settHeaderColor = HexColor('');
  // static Color settButtBgndColor = HexColor('');
  // static Color settIconsColor = HexColor('');
  // static Color settTextColor = HexColor('');
  // static Color primaryColor = HexColor('');
  // static Color primaryColor2 = HexColor('');
  // static Color activeColor = HexColor('');
  // static Color hintTextColor = HexColor('');
  // static Color fastButTextColor = HexColor('');
  // static Color menuIconActiveColor = HexColor('');
  // static Color bodyTextColor = HexColor('');

  static Map<String, Color> lightThemeColors = {
    "backgroundColor": const Color(0xFFf5f5f5),
    "fastButtonBackgroundColor": const Color(0xFFfe9585),
    "barColor": const Color(0xFFfe9585),
    "srcColor": const Color(0xFFfcfcfc),
    "iconColor": const Color(0xFFdedcd9),
    "textColor": const Color(0xFF000000),
    "srcButtonColor": const Color(0xFFff0000),
    "menuColor": const Color(0xFFf5f5f5),
    "buttonColor": const Color(0xFFfe9585),
    "qrColor": const Color(0xFFe82326),
  };

  static Map<String, dynamic> darkThemeColors = {
    "backgroundColor": const Color(0xFFf5f5f5),
    "fastButtonBackgroundColor": const Color(0xFFfe9585),
    "barColor": const Color(0xFFfe9585),
    "srcColor": const Color(0xFFfcfcfc),
    "iconColor": const Color(0xFFdedcd9),
    "textColor": const Color(0xFF000000),
    "srcButtonColor": const Color(0xFFff0000),
    "menuColor": const Color(0xFFf5f5f5),
    "buttonColor": const Color(0xFFfe9585),
    "qrColor": const Color(0xFFe82326),
  };

  static const LinearGradient defaultGradient = LinearGradient(colors: [primaryColorDark, const Color(0xFFfe9585)]);

  static const Color facebookColor = Color(0xFF1976D2);

  static const Color appleColor = Color(0xFF000000);
}
