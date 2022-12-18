export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'dart:typed_data';
export 'package:image_picker/image_picker.dart';
export 'package:flutter/material.dart';
export 'package:image_picker/image_picker.dart';
export 'dart:async';
export 'package:flutter/services.dart';
import 'package:als_frontend/screens/video/widget/custom_progress_bar.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class NewVideoPlayer extends StatefulWidget {
  const NewVideoPlayer(this.url,this.title,{Key? key}) : super(key: key);
  final String url;
  final String title;

  @override
  State<NewVideoPlayer> createState() => _NewVideoPlayerState();
}

class _NewVideoPlayerState extends State<NewVideoPlayer> {

  late Future<void> initializeVideoPlayerFuture;
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    super.initState();
    prepareVideo(url: widget.url);
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }

  clear() {
    videoPlayerController!.dispose();
    // videoPlayerController!.removeListener(checkVideoProgress);
  }
  prepareVideo({required String url}) {
    if (videoPlayerController != null) {
    }
    videoPlayerController = VideoPlayerController.network(url);
    initializeVideoPlayerFuture = videoPlayerController!.initialize();
    }
    //videoPlayerController!.addListener(checkVideoProgress);

  @override
  Widget build(BuildContext context) {
    // return Stack(
    //   children: [
    //     SizedBox(
    //       height: MediaQuery.of(context).size.height,
    //       child: FutureBuilder(
    //         future: initializeVideoPlayerFuture,
    //         builder: (context, snapshot) {
    //           if (snapshot.connectionState == ConnectionState.done) {
    //             return Stack(
    //               children: [
    //                 Container(
    //                   key: PageStorageKey(widget.url),
    //                   child: Chewie(
    //                     key: PageStorageKey(widget.url),
    //                     controller: ChewieController(
    //                       allowFullScreen: false,
    //                       videoPlayerController: videoPlayerController!,
    //                       aspectRatio: videoPlayerController!.value.aspectRatio,
    //                       showControls: true,
    //                       showOptions: false,
    //                       // Prepare the video to be played and display the first frame
    //                       autoInitialize: true,
    //                       looping: false,
    //                       autoPlay: true,
    //                       allowMuting: true,
    //                       // Errors can occur for example when trying to play a video
    //                       // from a non-existent URL
    //                       errorBuilder: (context, errorMessage) {
    //                         return Center(
    //                           child: Text(
    //                             errorMessage,
    //                             style: const TextStyle(color: Colors.white),
    //                           ),
    //                         );
    //                       },
    //
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             );
    //           } else {
    //             return Center(
    //               child: CustomProgressBar(),
    //             );
    //           }
    //         },
    //       ),
    //     ),
    //     const Spacer(),
    //   ],
    // );
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
                child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: FutureBuilder(
                        future: initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return Stack(
                              children: [
                                Container(
                                  key: PageStorageKey(widget.url),
                                  child: Chewie(
                                    key: PageStorageKey(widget.url),
                                    controller: ChewieController(
                                      allowFullScreen: false,
                                      videoPlayerController: videoPlayerController!,
                                      aspectRatio: videoPlayerController!.value.aspectRatio,
                                      showControls: true,
                                      showOptions: false,
                                      // Prepare the video to be played and display the first frame
                                      autoInitialize: true,
                                      looping: false,
                                      autoPlay: true,
                                      allowMuting: true,
                                      // Errors can occur for example when trying to play a video
                                      // from a non-existent URL
                                      errorBuilder: (context, errorMessage) {
                                        return Center(
                                          child: Text(
                                            errorMessage,
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                        );
                                      },

                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Center(
                              child: CustomProgressBar(),
                            );
                          }
                        },
                      ),
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
