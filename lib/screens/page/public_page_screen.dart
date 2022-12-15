import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/group/invite_group_screen.dart';
import 'package:als_frontend/screens/group/shimmer_effect/my_group_shimmer_effect.dart';
import 'package:als_frontend/screens/home/widget/timeline_widget.dart';
import 'package:als_frontend/screens/page/page_image_video_view.dart';
import 'package:als_frontend/screens/page/widget/cover_photo_widget.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/widgets/single_image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PublicPageScreen extends StatefulWidget {
  final String pageID;
  final int index;
  final bool isFromMyPageScreen;
  final bool isFromSuggestedPage;

  const PublicPageScreen(this.pageID, {this.isFromMyPageScreen = false, this.isFromSuggestedPage = false, this.index = 0, Key? key})
      : super(key: key);

  @override
  State<PublicPageScreen> createState() => _PublicPageScreenState();
}

class _PublicPageScreenState extends State<PublicPageScreen> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PageProvider>(context, listen: false).callForGetPageInformation(widget.pageID);
    Provider.of<PageProvider>(context, listen: false).callForGetAllPagePosts(widget.pageID);
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          Provider.of<PageProvider>(context, listen: false).hasNextData) {
        Provider.of<PageProvider>(context, listen: false).updatePageNo(widget.pageID);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: SafeArea(
            child: Consumer2<PageProvider, AuthProvider>(
                builder: (context, pageProvider, authProvider, child) => (pageProvider.isLoading)
                    ? const MyGroupShimmerWidget()
                    : NestedScrollView(
                        scrollDirection: Axis.vertical,
                        controller: controller,
                        floatHeaderSlivers: true,
                        headerSliverBuilder: (context, innerBoxIsScrolled) {
                          return [
                            SliverList(
                                delegate: SliverChildListDelegate([
                              Container(
                                height: 260,
                                width: width,
                                color: Palette.scaffold,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                            width: width,
                                            child: CoverPhotoWidget(
                                              isTrue: false,
                                              coverPhotoChange: () {},
                                              back: () {
                                                Helper.back();
                                              },
                                              coverPhoto:
                                                  pageProvider.pageDetailsModel != null ? pageProvider.pageDetailsModel!.coverPhoto! : "",
                                              viewCoverPhoto: () {
                                                Helper.toScreen(SingleImageView(imageURL: pageProvider.pageDetailsModel!.coverPhoto!,));
                                              },
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.21,
                                            child: Container(
                                              height: height * 0.14,
                                              width: width,
                                              decoration: const BoxDecoration(
                                                  color: Palette.scaffold, borderRadius: BorderRadius.all(Radius.circular(15))),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: height * 0.22, left: width * 0.03),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(pageProvider.pageDetailsModel != null ? pageProvider.pageDetailsModel!.name! : "",
                                                        style: TextStyle(fontSize: height * 0.03, fontWeight: FontWeight.bold)),
                                                    Padding(
                                                        padding: EdgeInsets.only(right: width * 0.227),
                                                        child: Text(pageProvider.pageDetailsModel != null
                                                            ? pageProvider.pageDetailsModel!.category!
                                                            : "")),
                                                    SizedBox(height: height * 0.01),
                                                    InkWell(
                                                      onTap: () {
                                                        Helper.toScreen(InviteGroupScreen(int.parse(widget.pageID)));
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "${pageProvider.pageDetailsModel!.totalLike}",
                                                            style: TextStyle(fontSize: height * 0.03, fontWeight: FontWeight.bold),
                                                          ),
                                                          Text(LocaleKeys.followers.tr(), style: GoogleFonts.lato(fontSize: 10, color: Colors.black))
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Spacer(),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          pageProvider.pageLikeUnlike(int.parse(widget.pageID),
                                                              isFromMyPageScreen: widget.isFromMyPageScreen,
                                                              index: widget.index,
                                                              isFromSuggestedPage: widget.isFromSuggestedPage);
                                                        },
                                                        child: Container(
                                                          height: height * 0.036,
                                                          width: width * 0.2,
                                                          decoration: BoxDecoration(
                                                              color: (pageProvider.pageDetailsModel!.like == false)
                                                                  ? Palette.primary
                                                                  : Colors.green,
                                                              borderRadius: BorderRadius.circular(10)),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              const Icon(Icons.thumb_up_sharp, size: 16, color: Colors.white),
                                                              Text(
                                                                (pageProvider.pageDetailsModel!.like == false) ? LocaleKeys.likes.tr() : LocaleKeys.liked.tr(),
                                                                style: TextStyle(fontSize: height * 0.015, color: Colors.white),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: height * 0.03,
                                        color: Colors.white,
                                        margin: const EdgeInsets.only(top: 2),
                                        child: TabBar(tabs: [
                                          Text(LocaleKeys.post.tr(), style: TextStyle(fontSize: height * 0.013, color: Colors.black)),
                                          Text(LocaleKeys.photos.tr(), style: TextStyle(fontSize: height * 0.013, color: Colors.black)),
                                          Text(LocaleKeys.videos.tr(), style: TextStyle(fontSize: height * 0.013, color: Colors.black)),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ]))
                          ];
                        },
                        body: TabBarView(
                          children: [
                            SingleChildScrollView(
                              physics: const ScrollPhysics(),
                              child: Column(
                                children: [
                                  /*----------------------------------------Newsfeed---------------------------------*/
                                  const SizedBox(height: 15),
                                  ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: pageProvider.pageAllPosts.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                            margin: const EdgeInsets.only(bottom: 10),
                                            child: TimeLineWidget(pageProvider.pageAllPosts[index], index, pageProvider,
                                                isPage: true, groupPageID: int.parse(widget.pageID)));
                                      }),
                                ],
                              ),
                            ),
                            const PageImageVideoView(),
                            const PageImageVideoView(isForImage: false),
                          ],
                        ),
                      )),
          ),
        ));
  }
}
