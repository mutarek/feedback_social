import 'package:als_frontend/old_code/provider/post/single_video_show_provider.dart';
import 'package:als_frontend/widgets/videoitems.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      body: SafeArea(
        child: Center(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: VideoItems(
                videoPlayerController:
                    VideoPlayerController.network(widget.videoURL)),
          ),
        ),
      ),
    );
  }
}
