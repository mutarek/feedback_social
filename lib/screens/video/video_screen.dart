import 'package:als_frontend/provider/watch_provider.dart';
import 'package:als_frontend/screens/video/widget/custom_video_widgets.dart';
import 'package:als_frontend/screens/video/widget/new_video_widgets.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VideoScreen extends StatefulWidget {
  final String videoUrl;
  final String thumbnailURL;
  final String title;

  const VideoScreen(this.videoUrl, this.thumbnailURL, this.title, {Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<WatchProvider>(context, listen: false).getWatchList(page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Helper.back();
              }),
          title: CustomText(title: LocaleKeys.feedback_Watch.tr(), color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
          backgroundColor: Colors.white,
          elevation: 0),
      body: Consumer<WatchProvider>(builder: (context, watchProvider, child) {
        return PageView.builder(
          scrollDirection: Axis.vertical,
          pageSnapping: true,
          physics: const BouncingScrollPhysics(),
          itemCount: watchProvider.watchLists.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              //return CustomVideoWidgets(widget.videoUrl, widget.thumbnailURL, widget.title);
              return NewVideoPlayer(widget.videoUrl,widget.title);
            }
            var data = watchProvider.watchLists[index - 1];
            //return CustomVideoWidgets(data.video!, data.thumbnail!, data.header_text!);
            return NewVideoPlayer(data.video!,data.header_text!);
          },
        );
      }),
    );
  }
}
