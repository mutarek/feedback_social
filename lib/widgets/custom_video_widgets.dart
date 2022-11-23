import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class CustomVideoWidget extends StatefulWidget {
  final String videoUrl;

  const CustomVideoWidget(this.videoUrl, {Key? key}) : super(key: key);

  @override
  State<CustomVideoWidget> createState() => _CustomVideoWidgetState();
}

class _CustomVideoWidgetState extends State<CustomVideoWidget> {
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.network(
          widget.videoUrl,
        ),
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
      body: Center(
        child: PodVideoPlayer(
          frameAspectRatio: controller.isInitialised?controller.videoPlayerValue!.size.width/controller.videoPlayerValue!.size.height:19/9,
          videoAspectRatio: controller.isInitialised?controller.videoPlayerValue!.size.width/controller.videoPlayerValue!.size.height:19/9,
            controller: controller),
      ),
    );
  }
}
