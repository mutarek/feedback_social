import 'dart:io';

import 'package:cache_video_player/player/video_player.dart';
import 'package:flutter/material.dart';

class VideoViewFromFile extends StatefulWidget {
  final File file;

  const VideoViewFromFile(this.file, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _VideoViewFromFileState createState() => _VideoViewFromFileState();
}

class _VideoViewFromFileState extends State<VideoViewFromFile> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller!.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
            )
          : Container(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }
}
