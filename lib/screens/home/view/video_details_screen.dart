import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_video_widgets.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class VideoDetailsScreen extends StatelessWidget {
  final String videoURL;
  final String videoThumbnailURl;

  const VideoDetailsScreen(this.videoThumbnailURl, {this.videoURL = '', Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Helper.back();
              }),
          title:  CustomText(title: LocaleKeys.feedback_Watch.tr(), color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
          backgroundColor: Colors.white,
          elevation: 0),
      body: Center(child: CustomVideoWidget(videoURL, videoThumbnailURl)),
    );
  }
}
