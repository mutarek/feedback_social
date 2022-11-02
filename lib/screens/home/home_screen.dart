import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/screens/home/shimmer_effect/timeline_post_shimmer_widget.dart';
import 'package:als_frontend/screens/home/widget/create_post_widget.dart';
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
    return Consumer2<NewsFeedProvider, AuthProvider>(builder: (context, newsFeedProvider, authProvider, child) {
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

                        return Container(
                            // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: TimeLineWidget(newsFeedProvider.newsFeedLists[index], index, newsFeedProvider,
                                isHomeScreen: true, groupPageID: newsFeedProvider.newsFeedLists[index].id!));
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
