import 'package:als_frontend/screens/video/widget/custom_progress_bar.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class CustomVideoWidgets extends StatefulWidget {
  final String videoUrl;
  final String thumbnailURL;
  final String title;

  const CustomVideoWidgets(this.videoUrl, this.thumbnailURL, this.title,
      {Key? key})
      : super(key: key);

  @override
  State<CustomVideoWidgets> createState() => _CustomVideoWidgetsState();
}

class _CustomVideoWidgetsState extends State<CustomVideoWidgets> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CustomText(
              title: widget.title,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: PodVideoPlayer(
                  frameAspectRatio: 1.0,
                  videoAspectRatio: 1,
                  controller: controller,
                  matchFrameAspectRatioToVideo: true,
                  matchVideoAspectRatioToFrame: true,
                  // alwaysShowProgressBar: false,
                  onLoading: (context) {
                    return CustomProgressBar();
                  },
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
            ],
          ),
        ),
      ],
    );
  }
}
