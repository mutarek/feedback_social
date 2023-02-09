import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/provider/post_provider.dart';
import 'package:als_frontend/screens/page/shimmer_effect/find_page_shimmer.dart';
import 'package:als_frontend/screens/page/widget/page_app_bar.dart';
import 'package:als_frontend/screens/post/widget/post_widget.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PostProvider>(context, listen: false).initializeBookmarkLists(isFirstTime: true);

    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          Provider.of<PostProvider>(context, listen: false).hasNextData) {
        Provider.of<PostProvider>(context, listen: false).updateBookmarkPageNo();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, postProvider, child) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: const PageAppBar(title: 'My Bookmark'),
            body: postProvider.isLoading
                ? const FindPageShimmer()
                : postProvider.bookmarkLists.isNotEmpty
                    ? ModalProgressHUD(
                        inAsyncCall: postProvider.isLoading2,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  controller: controller,
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  itemCount: postProvider.bookmarkLists.length,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    NewsFeedModel newsfeedModel = postProvider.bookmarkLists[index];
                                    return PostWidget(newsfeedModel,index: index,isFromMyBookMark: true);
                                  }),
                            ),
                            postProvider.isBottomLoading
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 100,
                                    alignment: Alignment.center,
                                    child: const CupertinoActivityIndicator())
                                : const SizedBox.shrink()
                          ],
                        ),
                      )
                    : const Center(child: CustomText(title: "You haven't any Bookmark Lists")));
      },
    );
  }
}
