import 'package:als_frontend/data/model/response/watch_list_model.dart';
import 'package:als_frontend/provider/watch_provider.dart';
import 'package:als_frontend/screens/video/widget/new_video_widgets.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class VideoScreen extends StatefulWidget {
  final WatchListModel watchListModel;

  const VideoScreen(this.watchListModel, {Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  PageController? pageController;

  @override
  void initState() {
    super.initState();
    Provider.of<WatchProvider>(context, listen: false).getWatchList(page: 1, watchListModel: widget.watchListModel);
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.95),
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Helper.back();
              }),
          title: CustomText(title: LocaleKeys.feedback_Watch.tr(), color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
          backgroundColor: Colors.white,
          toolbarHeight: 48,
          elevation: 0),
      body: Consumer<WatchProvider>(builder: (context, watchProvider, child) {
        return PageView.builder(
          controller: pageController,
          scrollDirection: Axis.vertical,
          pageSnapping: true,
          physics: const BouncingScrollPhysics(),
          itemCount: watchProvider.watchLists.length + 1,
          onPageChanged: (i) {
            if (i == watchProvider.watchLists.length - 3) {
              watchProvider.updatePageNo();
            }
          },
          itemBuilder: (context, index) {
            // if (index == 0) {
            //   return NewVideoPlayer(widget.watchListModel, index);
            // }
            var data = watchProvider.watchLists[index];
            return NewVideoPlayer(data, index);
          },
        );
      }),
    );
  }
}
