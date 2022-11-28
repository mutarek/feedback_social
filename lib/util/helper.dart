import 'dart:developer';

import 'package:als_frontend/helper/animation/slideleft_toright.dart';
import 'package:als_frontend/helper/animation/slideright_toleft.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Helper {
  static toScreen(context, screen) {
    Navigator.push(context, SlideRightToLeft(page: screen));
  }

  static toReplacementScreenSlideRightToLeft(context, screen) {
    Navigator.pushReplacement(context, SlideRightToLeft(page: screen));
  }

  static toReplacementScreenSlideLeftToRight(context, screen) {
    Navigator.pushReplacement(context, SlideLeftToRight(page: screen));
  }

  static toRemoveUntilScreen(context, screen) {
    Navigator.pushAndRemoveUntil(context, SlideRightToLeft(page: screen), (route) => false);
  }

  static onWillPop(context, screen) {
    Navigator.pushAndRemoveUntil(context, SlideRightToLeft(page: screen), (route) => false);
  }

  static showSnack(context, message, {color = colorPrimaryLight, duration = 2}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message, style: const TextStyle(fontSize: 14)), backgroundColor: color, duration: Duration(seconds: duration)));
  }

  static circularProgress(context) {
    const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(colorPrimaryLight)));
  }

  static showLog(message) {
    log("APP SAYS: $message");
  }

  static boxDecoration(Color color, double radius) {
    BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(radius)));
  }
}
