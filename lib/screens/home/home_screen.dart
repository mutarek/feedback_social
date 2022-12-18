import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/provider/post_provider.dart';
import 'package:als_frontend/screens/home/shimmer_effect/timeline_post_shimmer_widget.dart';
import 'package:als_frontend/screens/home/widget/create_post_widget.dart';
import 'package:als_frontend/screens/home/widget/post_status_widget.dart';
import 'package:als_frontend/screens/home/widget/timeline_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();

  Future<void> _refresh(BuildContext context) async {
    Provider.of<NewsFeedProvider>(context, listen: false).initializeAllFeedData(isFirstTime: false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          Provider.of<NewsFeedProvider>(context, listen: false).hasNextData) {
        Provider.of<NewsFeedProvider>(context, listen: false).updatePageNo();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<NewsFeedProvider, AuthProvider,PostProvider>(
        builder: (context, newsFeedProvider, authProvider,postProvider, child) {
      return RefreshIndicator(
        onRefresh: () {
          return _refresh(context);
        },
        child: newsFeedProvider.isLoading
            ? const TimeLinePostShimmerWidget(20)
            : ListView(
                controller: controller,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: createPostWidget(context, authProvider, newsFeedProvider: newsFeedProvider, isForGroup: false)),
                  postProvider.isLoading?Visibility(
                    visible: true,
                    child: postProvider.isLoading?postStatusWidget(context, authProvider, postProvider,true,postProvider.status):postStatusWidget(context, authProvider, postProvider,false,postProvider.status),
                  ):Visibility(
                    visible: false,
                    child: postProvider.isLoading?postStatusWidget(context, authProvider, postProvider,true,postProvider.status):postStatusWidget(context, authProvider, postProvider,false,postProvider.status),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: newsFeedProvider.newsFeedLists.length,
                      itemBuilder: (context, index) {
                        if (index == newsFeedProvider.newsFeedLists.length) {
                          return const CupertinoActivityIndicator();
                        }
                        return TimeLineWidget(newsFeedProvider.newsFeedLists[index], index, newsFeedProvider,
                            isHomeScreen: true, groupPageID: newsFeedProvider.newsFeedLists[index].id! as int);
                      }),
                  newsFeedProvider.isBottomLoading
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          alignment: Alignment.center,
                          child: const CupertinoActivityIndicator())
                      : const SizedBox.shrink()
                ],
              ),
      );
    });
  }
}
