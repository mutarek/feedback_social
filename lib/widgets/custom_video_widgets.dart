import 'package:als_frontend/provider/watch_provider.dart';
import 'package:als_frontend/screens/home/shimmer_effect/timeline_post_shimmer_widget.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/widgets/custom_multiple_video_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';
import 'package:provider/provider.dart';

class CustomVideoWidget extends StatefulWidget {
  final String videoUrl;
  final String thumbnailURL;

  const CustomVideoWidget(this.videoUrl, this.thumbnailURL, {Key? key})
      : super(key: key);

  @override
  State<CustomVideoWidget> createState() => _CustomVideoWidgetState();
}

class _CustomVideoWidgetState extends State<CustomVideoWidget> {
  late final PodPlayerController controller;
  String thumbnailURLFinal = '';

  @override
  void initState() {
    Provider.of<WatchProvider>(context, listen: false).getWatchList(page: 1);
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
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       const SizedBox(height: 8,),
      //       Card(
      //         elevation: 20,
      //         child: PodVideoPlayer(
      //           frameAspectRatio:  1,
      //           // videoAspectRatio: controller.isInitialised ? controller.videoPlayerValue!.size.aspectRatio : 1,
      //           controller: controller,
      //           matchFrameAspectRatioToVideo: true,
      //           matchVideoAspectRatioToFrame: true,
      //           videoThumbnail: widget.thumbnailURL.isNotEmpty
      //               ? DecorationImage(image: NetworkImage(thumbnailURLFinal), fit: BoxFit.cover)
      //               : DecorationImage(image: AssetImage(thumbnailURLFinal), fit: BoxFit.cover),
      //           podProgressBarConfig: const PodProgressBarConfig(
      //
      //           ),
      //         ),
      //       ),
      //       const SizedBox(height: 8,),
      //       Card(
      //         elevation: 20,
      //         child: PodVideoPlayer(
      //           frameAspectRatio:  1,
      //           // videoAspectRatio: controller.isInitialised ? controller.videoPlayerValue!.size.aspectRatio : 1,
      //           controller: secondVideoController,
      //           matchFrameAspectRatioToVideo: true,
      //           matchVideoAspectRatioToFrame: true,
      //           videoThumbnail: widget.thumbnailURL.isNotEmpty
      //               ? DecorationImage(image: NetworkImage(thumbnailURLFinal), fit: BoxFit.cover)
      //               : DecorationImage(image: AssetImage(thumbnailURLFinal), fit: BoxFit.cover),
      //           podProgressBarConfig: const PodProgressBarConfig(
      //
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // )
      body: Consumer<WatchProvider>(builder: (context, watch_provider, child) {
        return Padding(
          padding: EdgeInsets.all(5),
          child: ListView(
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            children: [
              PodVideoPlayer(
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
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: watch_provider.isLoading
                    ? TimeLinePostShimmerWidget(20)
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: watch_provider.watchLists.length,
                        itemBuilder: (_, index) {
                          var data = watch_provider.watchLists[index];
                          return Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                    imageUrl: data.thumbnail.toString()),
                                SizedBox(
                                    height: 150,
                                    width: MediaQuery.of(context).size.width),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: Center(
                                    child: Container(
                                      height: 75,
                                      width: 75,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            width: 3, color: Colors.white),
                                      ),
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                    CustomMultipleVideoWidgets(data.video.toString(),data.thumbnail.toString())));
                                          },
                                          icon: const Icon(Icons.play_arrow,
                                              color: Colors.white, size: 38)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
