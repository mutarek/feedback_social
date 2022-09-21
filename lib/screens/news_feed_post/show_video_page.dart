import 'package:als_frontend/provider/post/single_video_show_provider.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowVideoPage extends StatefulWidget {
  const ShowVideoPage({Key? key}) : super(key: key);

  @override
  State<ShowVideoPage> createState() => _ShowVideoPageState();
}

class _ShowVideoPageState extends State<ShowVideoPage> {
  String videoUrl = "";

  @override
  void initState() {
    final value = Provider.of<SingleVideoShowProvider>(context, listen: false);
    videoUrl = value.videoUrl;

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      videoUrl,
      cacheConfiguration: const BetterPlayerCacheConfiguration(
        useCache: true,
        preCacheSize: 2 * 1024 * 1024,
        maxCacheSize: 2 * 1024 * 1024,
        maxCacheFileSize: 2 * 1024 * 1024,

        ///Android only option to use cached video between app sessions
        key: "testCacheKey",
      ),
    );

    BetterPlayerController _betterPlayerController = BetterPlayerController(
        const BetterPlayerConfiguration(),
        betterPlayerDataSource: betterPlayerDataSource);
    _betterPlayerController.play();

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer(
        controller: _betterPlayerController,
      ),
    );
  }
}
