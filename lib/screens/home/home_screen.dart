import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/screens/home/view/photo_view.dart';
import 'package:als_frontend/screens/home/widget/post_header.dart';
import 'package:als_frontend/screens/home/widget/post_stats.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  final RefreshController refreshController;

  const HomeScreen(this.refreshController, {Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = ScrollController()
      ..addListener(() {
        if (_controller.position.maxScrollExtent == _controller.position.pixels) {
          Provider.of<NewsFeedProvider>(context, listen: false).updatePageNo();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsFeedProvider>(builder: (context, newsFeedProvider, child) {
      return SmartRefresher(
        controller: widget.refreshController,
        enablePullDown: true,
        enablePullUp: false,
        onRefresh: () {
          newsFeedProvider.initializeAllFeedData((bool status) {
            if (status == true) {
              widget.refreshController.loadComplete();
              widget.refreshController.refreshCompleted();
            }
          }, isFirstTime: false);
        },
        child: ListView.separated(
            controller: _controller,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10.0);
            },
            itemCount: newsFeedProvider.newsFeedLists.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PostHeaderWidget(post: newsFeedProvider.newsFeedLists[index]),
                        const SizedBox(height: 8.0),
                        Text(newsFeedProvider.newsFeedLists[index].description!, style: latoStyle400Regular),
                        if (newsFeedProvider.newsFeedLists[index].totalImage != 0) const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                  if (newsFeedProvider.newsFeedLists[index].totalImage != 0)
                    PostPhotoContainer(postImageUrl: newsFeedProvider.newsFeedLists[index]),
                  PostStats(post: newsFeedProvider.newsFeedLists[index], index: index, newsFeedProvider: newsFeedProvider),
                ],
              );
            }),
      );
    });
  }
}
