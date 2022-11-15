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
  late ChewieController _chewieController;

  @override
  void initState() {
    _chewieController = ChewieController(
      allowFullScreen: false,
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      autoPlay: true,
      looping: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          height: 250,
          child: Chewie(
            controller: _chewieController,
          ),
        ),
      ),
    );
  }
}
