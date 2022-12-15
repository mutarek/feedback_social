import 'package:als_frontend/util/image.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class CustomVideoWidget extends StatefulWidget {
  final String videoUrl;
  final String thumbnailURL;

  const CustomVideoWidget(this.videoUrl, this.thumbnailURL, {Key? key}) : super(key: key);

  @override
  State<CustomVideoWidget> createState() => _CustomVideoWidgetState();
}

class _CustomVideoWidgetState extends State<CustomVideoWidget> {
  late final PodPlayerController controller;
  late final PodPlayerController secondVideoController;
  String thumbnailURLFinal = '';

  @override
  void initState() {
    thumbnailURLFinal = '';
    thumbnailURLFinal = widget.thumbnailURL.isNotEmpty ? widget.thumbnailURL : ImagesModel.logo;
    controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.network(widget.videoUrl),
        podPlayerConfig: const PodPlayerConfig(autoPlay: true, isLooping: false, videoQualityPriority: [360, 720, 1080]))
      ..initialise();
    customSecondPlayer();
    super.initState();
  }

  void customSecondPlayer(){
    secondVideoController = PodPlayerController(
        playVideoFrom: PlayVideoFrom.network(widget.videoUrl),
        podPlayerConfig: const PodPlayerConfig(autoPlay: false, isLooping: false, videoQualityPriority: [360, 720, 1080]))
      ..initialise();
  }

  @override
  void dispose() {
    controller.dispose();
    secondVideoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 8,),
            Card(
              elevation: 20,
              child: PodVideoPlayer(
                frameAspectRatio:  1,
                // videoAspectRatio: controller.isInitialised ? controller.videoPlayerValue!.size.aspectRatio : 1,
                controller: controller,
                matchFrameAspectRatioToVideo: true,
                matchVideoAspectRatioToFrame: true,
                videoThumbnail: widget.thumbnailURL.isNotEmpty
                    ? DecorationImage(image: NetworkImage(thumbnailURLFinal), fit: BoxFit.cover)
                    : DecorationImage(image: AssetImage(thumbnailURLFinal), fit: BoxFit.cover),
                podProgressBarConfig: const PodProgressBarConfig(

                ),
              ),
            ),
            SizedBox(height: 8,),
            Card(
              elevation: 20,
              child: PodVideoPlayer(
                frameAspectRatio:  1,
                // videoAspectRatio: controller.isInitialised ? controller.videoPlayerValue!.size.aspectRatio : 1,
                controller: secondVideoController,
                matchFrameAspectRatioToVideo: true,
                matchVideoAspectRatioToFrame: true,
                videoThumbnail: widget.thumbnailURL.isNotEmpty
                    ? DecorationImage(image: NetworkImage(thumbnailURLFinal), fit: BoxFit.cover)
                    : DecorationImage(image: AssetImage(thumbnailURLFinal), fit: BoxFit.cover),
                podProgressBarConfig: const PodProgressBarConfig(

                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
