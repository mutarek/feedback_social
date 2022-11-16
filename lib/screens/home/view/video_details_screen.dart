import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/videoitems.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoDetailsScreen extends StatefulWidget {
  final String videoURL;

  const VideoDetailsScreen({this.videoURL = '', Key? key}) : super(key: key);

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  late BetterPlayerDataSource betterPlayerDataSource;

  @override
  void initState() {
    betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.videoURL,
      cacheConfiguration: const BetterPlayerCacheConfiguration(
        // useCache: true,
        preCacheSize: 2 * 1024 * 1024,
        maxCacheSize: 2 * 1024 * 1024,
        maxCacheFileSize: 2 * 1024 * 1024,
        key: "testCacheKey",
      ),
    );

    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    // BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
    //   BetterPlayerDataSourceType.network,
    //   videoUrl,
    //   cacheConfiguration: const BetterPlayerCacheConfiguration(
    //     useCache: true,
    //     preCacheSize: 2 * 1024 * 1024,
    //     maxCacheSize: 2 * 1024 * 1024,
    //     maxCacheFileSize: 2 * 1024 * 1024,

    //     ///Android only option to use cached video between app sessions
    //     key: "testCacheKey",
    //   ),
    // );

    BetterPlayerController _betterPlayerController = BetterPlayerController(
        const BetterPlayerConfiguration(),
        betterPlayerDataSource: betterPlayerDataSource);
    _betterPlayerController.play();

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Get.back();
              }),
          title: const CustomText(
              title: 'Feedback Watch',
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16),
          backgroundColor: Colors.white,
          elevation: 0),
      body: Center(
        child: VideoItems(
          videoPlayerController: VideoPlayerController.network(widget.videoURL),
        ),
      ),
    );
  }
}
