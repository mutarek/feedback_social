import 'package:als_frontend/widgets/custom_text2.dart';
import 'package:als_frontend/widgets/custom_video_widgets.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoDetailsScreen extends StatefulWidget {
  final String videoURL;

  const VideoDetailsScreen(
      {this.videoURL = '', Key? key})
      : super(key: key);

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Get.back();
              }),
          title: const CustomText2(
              title: 'Feedback Watch',
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16),
          backgroundColor: Colors.white,
          elevation: 0),
      body: Center(
          child: CustomVideoWidget(widget.videoURL)),
    );
  }
}
