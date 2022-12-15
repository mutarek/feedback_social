import 'package:als_frontend/util/image.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class CustomMultipleVideoWidgets extends StatefulWidget {
  final String videoUrl;
  final String thumbnailURL;
  const CustomMultipleVideoWidgets(this.videoUrl,this.thumbnailURL,{Key? key}) : super(key: key);

  @override
  State<CustomMultipleVideoWidgets> createState() => _CustomMultipleVideoWidgetsState();
}

class _CustomMultipleVideoWidgetsState extends State<CustomMultipleVideoWidgets> {
  late final PodPlayerController controller;
  String thumbnailURLFinal = '';

  @override
  void initState() {
    thumbnailURLFinal = '';
    thumbnailURLFinal =
    widget.thumbnailURL.isNotEmpty ? widget.thumbnailURL : ImagesModel.logo;
    controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.network(widget.videoUrl),
        podPlayerConfig: const PodPlayerConfig(
            autoPlay: true,
            isLooping: false,
            videoQualityPriority: [360, 720, 1080]))
      ..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: PodVideoPlayer(
          frameAspectRatio: 1,
          controller: controller,
          matchFrameAspectRatioToVideo: true,
          matchVideoAspectRatioToFrame: true,
          videoThumbnail: widget.thumbnailURL.isNotEmpty
              ? DecorationImage(
              image: NetworkImage(thumbnailURLFinal),
              fit: BoxFit.cover)
              : DecorationImage(
              image: AssetImage(thumbnailURLFinal),
              fit: BoxFit.cover),
          podProgressBarConfig: const PodProgressBarConfig(),
        ),
      ),
    );
  }
}
