import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/screens/home/shimmer_effect/timeline_post_shimmer_widget.dart';
import 'package:als_frontend/screens/home/widget/timeline_widget.dart';
import 'package:als_frontend/screens/posts/add_post_screen.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
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
                  InkWell(
                    onTap: () async {
                      var result =
                          await Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddPostScreen(authProvider.profileImage)));

                      if (result[0] == true && newsFeedProvider.count == 1) {
                        newsFeedProvider.addedDataOnLists();
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(.1), blurRadius: 10.0, spreadRadius: 3.3, offset: Offset(0.0, 0.0))
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                    backgroundImage: NetworkImage(authProvider.profileImage), backgroundColor: Colors.grey.withOpacity(.4)),
                                SizedBox(width: 5),
                                CustomText(
                                    title: 'Write Somethings',
                                    textStyle: latoStyle400Regular.copyWith(
                                        fontWeight: FontWeight.w300, fontSize: 13, color: Colors.grey.withOpacity(.8))),
                                SizedBox(width: 5),
                                Icon(Icons.mode_edit_outline_outlined, size: 20, color: Colors.grey.withOpacity(.8)),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(.1),
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.photo_camera_back, size: 20, color: Colors.grey),
                                            SizedBox(width: 5),
                                            CustomText(title: 'Photo', textStyle: latoStyle700Bold.copyWith()),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(CupertinoIcons.video_camera, size: 28, color: Colors.grey),
                                            SizedBox(width: 5),
                                            CustomText(title: 'Video', textStyle: latoStyle700Bold.copyWith()),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.calendar_month, size: 20, color: Colors.grey),
                                            SizedBox(width: 5),
                                            CustomText(title: 'Event', textStyle: latoStyle700Bold.copyWith()),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(.3),
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))),
                                  child: Icon(Icons.send, color: Color(0xff031765)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      // separatorBuilder: (context, index) {
                      //   return const SizedBox(height: 10.0);
                      // },
                      itemCount: newsFeedProvider.newsFeedLists.length,
                      itemBuilder: (context, index) {
                        if (index == newsFeedProvider.newsFeedLists.length) {
                          return const CupertinoActivityIndicator();
                        }

                        return TimeLineWidget(newsFeedProvider.newsFeedLists[index], index, newsFeedProvider,isHomeScreen: true);
                      }),
                ],
              ),
      );
    });
  }
}
