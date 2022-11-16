import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoItems extends StatefulWidget {
  VideoItems({
    required this.videoPlayerController,
  });

  final VideoPlayerController videoPlayerController;

  @override
  State<VideoItems> createState() => _VideoItemsState();
}

class _VideoItemsState extends State<VideoItems> {
  ChewieController? _chewieController;

  @override
  void initState() {
    _chewieController = ChewieController(
      allowFullScreen: true,
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: widget.videoPlayerController.value.aspectRatio,
      autoInitialize: false,
      autoPlay: true,
      looping: false,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.red),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(2),
        child: Card(
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            height: 400,
            child: Chewie(
              controller: _chewieController!,
            ),
          ),
        ),
      ),
    );
  }
}
