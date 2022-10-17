import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/screens/home/shimmer_effect/timeline_post_shimmer_widget.dart';
import 'package:als_frontend/screens/home/widget/create_post_widget.dart';
import 'package:als_frontend/screens/home/widget/timeline_widget.dart';
import 'package:flutter/cupertino.dart';
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
    return Consumer2<NewsFeedProvider, AuthProvider>(builder: (context, newsFeedProvider, authProvider, child) {
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
        child: newsFeedProvider.isLoading
            ? const TimeLinePostShimmerWidget(20)
            : ListView(
                controller: _controller,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: createPostWidget(context, authProvider, newsFeedProvider: newsFeedProvider, isForGroup: true)),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      // separatorBuilder: (context, index) {
                      //   return const SizedBox(height: 10.0);
                      // },
                      itemCount: newsFeedProvider.newsFeedLists.length,
                      itemBuilder: (context, index) {
                        if (index == newsFeedProvider.newsFeedLists.length) {
                          return const CupertinoActivityIndicator();
                        }

                        return Container(margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),child: TimeLineWidget(newsFeedProvider.newsFeedLists[index], index, newsFeedProvider, isHomeScreen: true));
                      }),
                ],
              ),
      );
    });
  }
}
